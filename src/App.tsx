import { useCallback, useEffect, useState } from 'react';
import type { Session } from '@supabase/supabase-js';
import ReaderPage from './ReaderPage';
import AuthPage from './components/AuthPage';
import DocumentLibrary from './components/DocumentLibrary';
import type { LibraryNavigationState } from './components/DocumentLibrary';
import FavoritesPage from './components/FavoritesPage';
import ResetPasswordPage from './components/ResetPasswordPage';
import TextImporter from './components/TextImporter';
import VocabularyPage from './components/VocabularyPage';
import WritingBankPage from './components/WritingBankPage';
import type { Document, Folder } from './types';
import { createDocumentStructure } from './utils/sentenceSplitter';
import { supabase } from './services/supabaseClient';
import { useCloudLibrarySync } from './hooks/useCloudLibrarySync';
import { useSystemLibrary } from './hooks/useSystemLibrary';
import { useWritingBank } from './hooks/useWritingBank';
import {
  deleteDocument,
  generateDocumentId,
  getDocuments,
  getFolders,
  recordDocumentOpened,
  saveDocument,
} from './utils/storage';
import {
  getDocumentReturnView,
  getFolderPath,
  parseSystemView,
} from './utils/libraryNavigation';

type AppRoute =
  | 'library'
  | 'create'
  | 'reader'
  | 'vocabulary'
  | 'favorites'
  | 'writing';

function App() {
  const [route, setRoute] = useState<AppRoute>('library');
  const [documents, setDocuments] = useState<Document[]>(() => getDocuments());
  const [folders, setFolders] = useState<Folder[]>(() => getFolders());
  const [activeDocument, setActiveDocument] = useState<Document | null>(null);
  const [readerOrigin, setReaderOrigin] = useState<'library' | 'writing'>(
    'library',
  );
  const [libraryNavigation, setLibraryNavigation] =
    useState<LibraryNavigationState>({
      selectedView: 'all',
      searchQuery: '',
      sortOption: 'newest',
      scrollY: 0,
      expandedFolderIds: [],
      expandedSystemCollectionIds: [],
    });
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
  const systemLibrary = useSystemLibrary(session?.user.id);
  const writingBank = useWritingBank(
    session?.user.id,
    route === 'writing',
  );

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

  const handleOpenDocument = (
    document: Document,
    origin: 'library' | 'writing' = 'library',
  ) => {
    if (document.origin === 'system') {
      const nextState = systemLibrary.recordOpened(document.id);
      setActiveDocument({
        ...document,
        readCount: nextState.readCount,
        lastOpenedAt: nextState.lastOpenedAt,
      });
    } else {
      const updatedDocument = recordDocumentOpened(document.id);
      setActiveDocument(updatedDocument ?? document);
      refreshLibrary();
    }

    setReaderOrigin(origin);
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
    setLibraryNavigation((current) => ({
      ...current,
      selectedView: 'all',
      scrollY: 0,
    }));
    setReaderOrigin('library');
    setRoute('library');
  };

  const handleBackToDocuments = () => {
    if (readerOrigin === 'writing') {
      setRoute('writing');
      return;
    }

    if (!activeDocument) {
      handleBackToLibrary();
      return;
    }

    const selectedView = getDocumentReturnView(activeDocument);
    const systemView = parseSystemView(selectedView);
    const folderPathIds =
      activeDocument.origin === 'system'
        ? []
        : getFolderPath(activeDocument.folderId, folders).map(
            (folder) => folder.id,
          );
    refreshLibrary();
    setLibraryNavigation((current) => ({
      ...current,
      selectedView,
      scrollY: current.selectedView === selectedView ? current.scrollY : 0,
      expandedFolderIds: [
        ...new Set([...current.expandedFolderIds, ...folderPathIds]),
      ],
      expandedSystemCollectionIds: systemView
        ? [
            ...new Set([
              ...current.expandedSystemCollectionIds,
              systemView.collectionId,
            ]),
          ]
        : current.expandedSystemCollectionIds,
    }));
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
        onBackToDocuments={handleBackToDocuments}
        onBackToLibrary={handleBackToLibrary}
        backToDocumentsLabel={
          readerOrigin === 'writing' ? 'Back to Writing Bank' : undefined
        }
        onDocumentChange={setActiveDocument}
        onSystemProgressChange={systemLibrary.updateProgress}
        onSystemSentenceNoteChange={systemLibrary.updateSentenceNote}
      />
    );
  }

  if (route === 'vocabulary') {
    return <VocabularyPage onBackToLibrary={() => setRoute('library')} />;
  }

  if (route === 'favorites') {
    return <FavoritesPage onBackToLibrary={() => setRoute('library')} />;
  }

  if (route === 'writing') {
    return (
      <WritingBankPage
        items={writingBank.items}
        essays={systemLibrary.documents}
        stateByItemId={writingBank.stateByItemId}
        view={writingBank.view}
        onBackToLibrary={() => setRoute('library')}
        onOpenEssay={(essayId) => {
          const essay = systemLibrary.documents.find(
            (document) => document.id === essayId,
          );

          if (essay) {
            handleOpenDocument(essay, 'writing');
          }
        }}
        onRetry={writingBank.reload}
        onUpdateState={writingBank.updateState}
      />
    );
  }

  return (
    <DocumentLibrary
      documents={[...systemLibrary.documents, ...documents]}
      folders={folders}
      cloudSyncView={cloudSyncView}
      systemCollections={systemLibrary.collections}
      systemLibraryView={systemLibrary.view}
      userEmail={session.user.email ?? ''}
      onCreateDocument={() => setRoute('create')}
      onDeleteDocument={handleDeleteDocument}
      onLogout={handleLogout}
      onLibraryChange={refreshLibrary}
      onOpenDocument={handleOpenDocument}
      onOpenFavorites={() => setRoute('favorites')}
      onOpenVocabulary={() => setRoute('vocabulary')}
      onOpenWritingBank={() => setRoute('writing')}
      onRetryCloudSync={retryCloudSync}
      onSyncNow={uploadThisDevice}
      onOverwriteCloud={overwriteCloudWithThisDevice}
      onUseCloudCopy={useCloudCopy}
      navigationState={libraryNavigation}
      onNavigationStateChange={setLibraryNavigation}
    />
  );
}

export default App;
