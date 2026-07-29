import { useCallback, useEffect, useState } from 'react';
import type { Session } from '@supabase/supabase-js';
import ReaderPage from './ReaderPage';
import AuthPage from './components/AuthPage';
import DocumentLibrary from './components/DocumentLibrary';
import FavoritesPage from './components/FavoritesPage';
import ReviewSentencesPage from './components/ReviewSentencesPage';
import ReviewVocabularyPage from './components/ReviewVocabularyPage';
import ResetPasswordPage from './components/ResetPasswordPage';
import TextImporter from './components/TextImporter';
import VocabularyPage from './components/VocabularyPage';
import type { Document, Folder } from './types';
import { createDocumentStructure } from './utils/sentenceSplitter';
import { supabase } from './services/supabaseClient';
import { useCloudLibrarySync } from './hooks/useCloudLibrarySync';
import {
  deleteDocument,
  generateDocumentId,
  getDocuments,
  getFolders,
  saveDocument,
} from './utils/storage';

type AppRoute =
  | 'library'
  | 'create'
  | 'reader'
  | 'vocabulary'
  | 'favorites'
  | 'reviewVocabulary'
  | 'reviewSentences';

function App() {
  const [route, setRoute] = useState<AppRoute>('library');
  const [documents, setDocuments] = useState<Document[]>(() => getDocuments());
  const [folders, setFolders] = useState<Folder[]>(() => getFolders());
  const [activeDocument, setActiveDocument] = useState<Document | null>(null);
  const [session, setSession] = useState<Session | null>(null);
  const [isAuthLoading, setIsAuthLoading] = useState(true);
  const [isPasswordRecovery, setIsPasswordRecovery] = useState(false);

  useEffect(() => {
    supabase.auth.getSession().then(({ data }) => {
      setSession(data.session);
      setIsAuthLoading(false);
    });

    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange((event, nextSession) => {
      if (event === 'PASSWORD_RECOVERY') {
        setIsPasswordRecovery(true);
      }

      setSession(nextSession);
    });

    return () => subscription.unsubscribe();
  }, []);

  const refreshLibrary = useCallback(() => {
    setDocuments(getDocuments());
    setFolders(getFolders());
  }, []);
  const {
    view: cloudSyncView,
    retry: retryCloudSync,
    uploadThisDevice,
    overwriteCloudWithThisDevice,
    useCloudCopy,
  } = useCloudLibrarySync(session?.user.id, refreshLibrary);

  const handleCreateDocument = (title: string, sourceText: string) => {
    const { paragraphs, sentences } = createDocumentStructure(
      sourceText,
      generateDocumentId,
    );

    if (sentences.length === 0) {
      return 'Please enter text that contains at least one readable sentence.';
    }

    const document: Document = {
      id: generateDocumentId(),
      title: title.trim(),
      createdAt: new Date().toISOString(),
      sourceText,
      paragraphs,
      sentences,
      currentSentenceIndex: 0,
    };

    saveDocument(document);
    refreshLibrary();
    setActiveDocument(document);
    setRoute('reader');

    return null;
  };

  const handleOpenDocument = (document: Document) => {
    setActiveDocument(document);
    setRoute('reader');
  };

  const handleDeleteDocument = (id: string) => {
    deleteDocument(id);
    refreshLibrary();

    if (activeDocument?.id === id) {
      setActiveDocument(null);
      setRoute('library');
    }
  };

  const handleBackToLibrary = () => {
    refreshLibrary();
    setRoute('library');
  };

  const handleLogout = async () => {
    if (
      cloudSyncView.state === 'synced' ||
      cloudSyncView.state === 'syncing'
    ) {
      await uploadThisDevice();
    }

    await supabase.auth.signOut();
    setActiveDocument(null);
    setRoute('library');
  };

  if (isAuthLoading) {
    return (
      <main className="flex min-h-screen items-center justify-center bg-slate-50 text-slate-600">
        <p className="text-sm font-medium">Loading...</p>
      </main>
    );
  }

  if (!session) {
    return <AuthPage />;
  }

  if (isPasswordRecovery) {
    return (
      <ResetPasswordPage
        onPasswordUpdated={() => {
          setIsPasswordRecovery(false);
          window.history.replaceState(
            null,
            '',
            `${window.location.pathname}${window.location.search}`,
          );
        }}
      />
    );
  }

  if (route === 'create') {
    return (
      <TextImporter
        onCancel={() => setRoute('library')}
        onCreateDocument={handleCreateDocument}
      />
    );
  }

  if (route === 'reader' && activeDocument) {
    return (
      <ReaderPage
        document={activeDocument}
        onBackToLibrary={handleBackToLibrary}
        onDocumentChange={setActiveDocument}
      />
    );
  }

  if (route === 'vocabulary') {
    return <VocabularyPage onBackToLibrary={() => setRoute('library')} />;
  }

  if (route === 'favorites') {
    return <FavoritesPage onBackToLibrary={() => setRoute('library')} />;
  }

  if (route === 'reviewVocabulary') {
    return (
      <ReviewVocabularyPage onBackToLibrary={() => setRoute('library')} />
    );
  }

  if (route === 'reviewSentences') {
    return (
      <ReviewSentencesPage onBackToLibrary={() => setRoute('library')} />
    );
  }

  return (
    <DocumentLibrary
      documents={documents}
      folders={folders}
      cloudSyncView={cloudSyncView}
      userEmail={session.user.email ?? ''}
      onCreateDocument={() => setRoute('create')}
      onDeleteDocument={handleDeleteDocument}
      onLogout={handleLogout}
      onLibraryChange={refreshLibrary}
      onOpenDocument={handleOpenDocument}
      onOpenFavorites={() => setRoute('favorites')}
      onOpenVocabulary={() => setRoute('vocabulary')}
      onReviewSentences={() => setRoute('reviewSentences')}
      onReviewVocabulary={() => setRoute('reviewVocabulary')}
      onRetryCloudSync={retryCloudSync}
      onSyncNow={uploadThisDevice}
      onOverwriteCloud={overwriteCloudWithThisDevice}
      onUseCloudCopy={useCloudCopy}
    />
  );
}

export default App;
