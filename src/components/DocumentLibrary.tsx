import { useMemo, useRef, useState } from 'react';
import type { ChangeEvent } from 'react';
import type { Document, Folder } from '../types';
import { splitIntoSentences } from '../utils/sentenceSplitter';
import {
  createFolder,
  deleteFolder,
  exportDocuments,
  generateDocumentId,
  getFavoriteSentences,
  getVocabularyItems,
  importDocuments,
  importLibrary,
  isLibraryExport,
  moveDocumentToFolder,
  renameDocument,
  renameFolder,
} from '../utils/storage';

type FolderView = 'all' | 'unfiled' | string;
type SortOption = 'newest' | 'oldest' | 'title-asc' | 'title-desc';

type DocumentLibraryProps = {
  documents: Document[];
  folders: Folder[];
  userEmail: string;
  onCreateDocument: () => void;
  onDeleteDocument: (id: string) => void;
  onLogout: () => void;
  onLibraryChange: () => void;
  onOpenDocument: (document: Document) => void;
  onOpenFavorites: () => void;
  onOpenVocabulary: () => void;
  onReviewSentences: () => void;
  onReviewVocabulary: () => void;
};

function formatDate(value: string) {
  return new Intl.DateTimeFormat(undefined, {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
  }).format(new Date(value));
}

function getExportFileName() {
  const date = new Date().toISOString().slice(0, 10);
  return `intensive-reading-library-${date}.json`;
}

function downloadJsonFile(fileName: string, data: unknown) {
  const blob = new Blob([JSON.stringify(data, null, 2)], {
    type: 'application/json',
  });
  const url = URL.createObjectURL(blob);
  const link = document.createElement('a');

  link.href = url;
  link.download = fileName;
  link.click();
  URL.revokeObjectURL(url);
}

function getTitleFromTxtFile(file: File) {
  return file.name.replace(/\.txt$/i, '').trim() || 'Untitled Document';
}

function getFolderName(folders: Folder[], folderId?: string) {
  return folders.find((folder) => folder.id === folderId)?.name ?? 'Unfiled';
}

function sortDocuments(documents: Document[], sortOption: SortOption) {
  return [...documents].sort((a, b) => {
    if (sortOption === 'oldest') {
      return new Date(a.createdAt).getTime() - new Date(b.createdAt).getTime();
    }

    if (sortOption === 'title-asc') {
      return a.title.localeCompare(b.title);
    }

    if (sortOption === 'title-desc') {
      return b.title.localeCompare(a.title);
    }

    return new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime();
  });
}

function getProgress(document: Document) {
  const totalSentences = document.sentences.length;
  const currentPosition = totalSentences === 0 ? 0 : document.currentSentenceIndex + 1;
  const percentage =
    totalSentences === 0
      ? 0
      : Math.round((currentPosition / totalSentences) * 100);

  return { currentPosition, totalSentences, percentage };
}

function DocumentLibrary({
  documents,
  folders,
  userEmail,
  onCreateDocument,
  onDeleteDocument,
  onLogout,
  onLibraryChange,
  onOpenDocument,
  onOpenFavorites,
  onOpenVocabulary,
  onReviewSentences,
  onReviewVocabulary,
}: DocumentLibraryProps) {
  const libraryInputRef = useRef<HTMLInputElement>(null);
  const txtInputRef = useRef<HTMLInputElement>(null);
  const [selectedFolder, setSelectedFolder] = useState<FolderView>('all');
  const [searchQuery, setSearchQuery] = useState('');
  const [sortOption, setSortOption] = useState<SortOption>('newest');
  const [statusMessage, setStatusMessage] = useState('');
  const [statusType, setStatusType] = useState<'success' | 'error'>('success');
  const vocabularyItems = getVocabularyItems();
  const favoriteSentences = getFavoriteSentences();
  const vocabularyCountByDocument = useMemo(() => {
    return vocabularyItems.reduce<Record<string, number>>((counts, item) => {
      counts[item.documentId] = (counts[item.documentId] ?? 0) + 1;
      return counts;
    }, {});
  }, [vocabularyItems]);
  const favoriteCountByDocument = useMemo(() => {
    return favoriteSentences.reduce<Record<string, number>>((counts, item) => {
      counts[item.documentId] = (counts[item.documentId] ?? 0) + 1;
      return counts;
    }, {});
  }, [favoriteSentences]);

  const filteredDocuments = useMemo(() => {
    const normalizedQuery = searchQuery.trim().toLowerCase();
    const folderFilteredDocuments = documents.filter((document) => {
      if (selectedFolder === 'all') {
        return true;
      }

      if (selectedFolder === 'unfiled') {
        return !document.folderId;
      }

      return document.folderId === selectedFolder;
    });

    const searchedDocuments = normalizedQuery
      ? folderFilteredDocuments.filter(
          (document) =>
            document.title.toLowerCase().includes(normalizedQuery) ||
            document.sourceText.toLowerCase().includes(normalizedQuery),
        )
      : folderFilteredDocuments;

    return sortDocuments(searchedDocuments, sortOption);
  }, [documents, searchQuery, selectedFolder, sortOption]);

  const showStatus = (type: 'success' | 'error', message: string) => {
    setStatusType(type);
    setStatusMessage(message);
  };

  const handleCreateFolder = () => {
    const folderName = window.prompt('Folder name');

    if (!folderName?.trim()) {
      return;
    }

    const folder = createFolder(folderName);
    setSelectedFolder(folder.id);
    onLibraryChange();
    showStatus('success', `Created folder "${folder.name}".`);
  };

  const handleRenameFolder = (folder: Folder) => {
    const folderName = window.prompt('Rename folder', folder.name);

    if (!folderName?.trim()) {
      return;
    }

    renameFolder(folder.id, folderName);
    onLibraryChange();
    showStatus('success', 'Folder renamed.');
  };

  const handleDeleteFolder = (folder: Folder) => {
    const confirmed = window.confirm(
      `Delete folder "${folder.name}"? Documents inside it will become unfiled.`,
    );

    if (!confirmed) {
      return;
    }

    deleteFolder(folder.id);
    setSelectedFolder('all');
    onLibraryChange();
    showStatus('success', 'Folder deleted. Documents were kept.');
  };

  const handleRenameDocument = (document: Document) => {
    const title = window.prompt('Rename document', document.title);

    if (!title?.trim()) {
      return;
    }

    renameDocument(document.id, title);
    onLibraryChange();
    showStatus('success', 'Document renamed.');
  };

  const handleMoveDocument = (documentId: string, folderId: string) => {
    moveDocumentToFolder(documentId, folderId || undefined);
    onLibraryChange();
    showStatus('success', 'Document moved.');
  };

  const handleExportLibrary = () => {
    downloadJsonFile(getExportFileName(), exportDocuments());
    showStatus('success', `Exported ${documents.length} document(s).`);
  };

  const handleImportLibrary = async (event: ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    event.target.value = '';

    if (!file) {
      return;
    }

    try {
      const fileText = await file.text();
      const parsedData: unknown = JSON.parse(fileText);

      if (!isLibraryExport(parsedData)) {
        showStatus(
          'error',
          'Import failed: JSON does not contain valid library data.',
        );
        return;
      }

      importLibrary(parsedData);
      onLibraryChange();
      showStatus('success', `Imported version ${parsedData.version} library.`);
    } catch {
      showStatus('error', 'Import failed: please choose a valid JSON file.');
    }
  };

  const handleImportTxtFiles = async (
    event: ChangeEvent<HTMLInputElement>,
  ) => {
    const files = Array.from(event.target.files ?? []);
    event.target.value = '';

    if (files.length === 0) {
      return;
    }

    const importedDocuments: Document[] = [];
    let failedCount = 0;

    await Promise.all(
      files.map(async (file) => {
        try {
          const sourceText = await file.text();
          const sentences = splitIntoSentences(sourceText).map((text) => ({
            id: generateDocumentId(),
            text,
          }));

          if (sentences.length === 0) {
            failedCount += 1;
            return;
          }

          importedDocuments.push({
            id: generateDocumentId(),
            title: getTitleFromTxtFile(file),
            createdAt: new Date().toISOString(),
            sourceText,
            sentences,
            currentSentenceIndex: 0,
            folderId: selectedFolder === 'all' || selectedFolder === 'unfiled'
              ? undefined
              : selectedFolder,
          });
        } catch {
          failedCount += 1;
        }
      }),
    );

    if (importedDocuments.length > 0) {
      importDocuments(importedDocuments);
      onLibraryChange();
    }

    if (failedCount > 0) {
      showStatus(
        importedDocuments.length > 0 ? 'success' : 'error',
        `Imported ${importedDocuments.length} TXT file(s). ${failedCount} file(s) failed.`,
      );
      return;
    }

    showStatus('success', `Imported ${importedDocuments.length} TXT file(s).`);
  };

  return (
    <main className="min-h-screen bg-slate-50 text-slate-950">
      <div className="mx-auto w-full max-w-7xl px-4 py-8 sm:px-6 lg:px-8">
        <header className="flex flex-col gap-4 border-b border-slate-200 pb-6 lg:flex-row lg:items-end lg:justify-between">
          <div>
            <p className="text-sm font-medium text-cyan-700">
              AI Intensive Reading
            </p>
            <h1 className="mt-2 text-3xl font-semibold text-slate-950">
              Document Library
            </h1>
            <p className="mt-2 max-w-2xl text-sm leading-6 text-slate-600">
              Organize local reading documents, collect useful words, and save
              favorite sentences.
            </p>
            <p className="mt-2 text-sm font-medium text-slate-500">
              Signed in as {userEmail}
            </p>
          </div>

          <div className="flex flex-col gap-2 sm:flex-row sm:flex-wrap lg:justify-end">
            <button
              type="button"
              onClick={onCreateDocument}
              className="inline-flex h-10 items-center justify-center rounded-md bg-cyan-700 px-4 text-sm font-semibold text-white shadow-sm transition hover:bg-cyan-800 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
            >
              New Document
            </button>
            <button
              type="button"
              onClick={() => libraryInputRef.current?.click()}
              className="inline-flex h-10 items-center justify-center rounded-md border border-slate-300 bg-white px-4 text-sm font-semibold text-slate-700 shadow-sm transition hover:border-slate-400 hover:bg-slate-100 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
            >
              Import Library
            </button>
            <button
              type="button"
              onClick={handleExportLibrary}
              className="inline-flex h-10 items-center justify-center rounded-md border border-slate-300 bg-white px-4 text-sm font-semibold text-slate-700 shadow-sm transition hover:border-slate-400 hover:bg-slate-100 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
            >
              Export Library
            </button>
            <button
              type="button"
              onClick={() => txtInputRef.current?.click()}
              className="inline-flex h-10 items-center justify-center rounded-md border border-slate-300 bg-white px-4 text-sm font-semibold text-slate-700 shadow-sm transition hover:border-slate-400 hover:bg-slate-100 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
            >
              Import TXT Files
            </button>
            <button
              type="button"
              onClick={onOpenVocabulary}
              className="inline-flex h-10 items-center justify-center rounded-md border border-slate-300 bg-white px-4 text-sm font-semibold text-slate-700 shadow-sm transition hover:border-slate-400 hover:bg-slate-100 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
            >
              Vocabulary
            </button>
            <button
              type="button"
              onClick={onReviewVocabulary}
              className="inline-flex h-10 items-center justify-center rounded-md border border-slate-300 bg-white px-4 text-sm font-semibold text-slate-700 shadow-sm transition hover:border-slate-400 hover:bg-slate-100 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
            >
              Review Vocabulary
            </button>
            <button
              type="button"
              onClick={onOpenFavorites}
              className="inline-flex h-10 items-center justify-center rounded-md border border-slate-300 bg-white px-4 text-sm font-semibold text-slate-700 shadow-sm transition hover:border-slate-400 hover:bg-slate-100 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
            >
              Favorites
            </button>
            <button
              type="button"
              onClick={onReviewSentences}
              className="inline-flex h-10 items-center justify-center rounded-md border border-slate-300 bg-white px-4 text-sm font-semibold text-slate-700 shadow-sm transition hover:border-slate-400 hover:bg-slate-100 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
            >
              Review Sentences
            </button>
            <button
              type="button"
              onClick={onLogout}
              className="inline-flex h-10 items-center justify-center rounded-md border border-rose-200 bg-white px-4 text-sm font-semibold text-rose-700 shadow-sm transition hover:bg-rose-50 focus:outline-none focus:ring-2 focus:ring-rose-500 focus:ring-offset-2"
            >
              Logout
            </button>
          </div>
        </header>

        <section className="mt-5 grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
          <div className="rounded-lg border border-slate-200 bg-white p-4 shadow-sm">
            <p className="text-xs font-semibold uppercase text-slate-500">
              Documents
            </p>
            <p className="mt-2 text-2xl font-semibold text-slate-950">
              {documents.length}
            </p>
          </div>
          <div className="rounded-lg border border-slate-200 bg-white p-4 shadow-sm">
            <p className="text-xs font-semibold uppercase text-slate-500">
              Folders
            </p>
            <p className="mt-2 text-2xl font-semibold text-slate-950">
              {folders.length}
            </p>
          </div>
          <div className="rounded-lg border border-slate-200 bg-white p-4 shadow-sm">
            <p className="text-xs font-semibold uppercase text-slate-500">
              Vocabulary
            </p>
            <p className="mt-2 text-2xl font-semibold text-slate-950">
              {vocabularyItems.length}
            </p>
          </div>
          <div className="rounded-lg border border-slate-200 bg-white p-4 shadow-sm">
            <p className="text-xs font-semibold uppercase text-slate-500">
              Favorites
            </p>
            <p className="mt-2 text-2xl font-semibold text-slate-950">
              {favoriteSentences.length}
            </p>
          </div>
        </section>

        <section className="mt-5 grid gap-4 lg:grid-cols-[260px_minmax(0,1fr)]">
          <aside className="rounded-lg border border-slate-200 bg-white shadow-sm">
            <div className="flex items-center justify-between border-b border-slate-200 px-4 py-3">
              <h2 className="text-sm font-semibold text-slate-900">Folders</h2>
              <button
                type="button"
                onClick={handleCreateFolder}
                className="rounded-md px-2 py-1 text-sm font-semibold text-cyan-700 transition hover:bg-cyan-50 focus:outline-none focus:ring-2 focus:ring-cyan-500"
              >
                New
              </button>
            </div>

            <nav className="space-y-1 p-2">
              <button
                type="button"
                onClick={() => setSelectedFolder('all')}
                className={`w-full rounded-md px-3 py-2 text-left text-sm transition ${
                  selectedFolder === 'all'
                    ? 'bg-cyan-50 font-semibold text-cyan-950'
                    : 'text-slate-700 hover:bg-slate-50'
                }`}
              >
                All Documents
              </button>
              <button
                type="button"
                onClick={() => setSelectedFolder('unfiled')}
                className={`w-full rounded-md px-3 py-2 text-left text-sm transition ${
                  selectedFolder === 'unfiled'
                    ? 'bg-cyan-50 font-semibold text-cyan-950'
                    : 'text-slate-700 hover:bg-slate-50'
                }`}
              >
                Unfiled
              </button>

              {folders.map((folder) => (
                <div key={folder.id} className="flex gap-1">
                  <button
                    type="button"
                    onClick={() => setSelectedFolder(folder.id)}
                    className={`min-w-0 flex-1 truncate rounded-md px-3 py-2 text-left text-sm transition ${
                      selectedFolder === folder.id
                        ? 'bg-cyan-50 font-semibold text-cyan-950'
                        : 'text-slate-700 hover:bg-slate-50'
                    }`}
                  >
                    {folder.name}
                  </button>
                  <button
                    type="button"
                    onClick={() => handleRenameFolder(folder)}
                    className="rounded-md px-2 text-xs font-semibold text-slate-500 hover:bg-slate-100"
                  >
                    Edit
                  </button>
                  <button
                    type="button"
                    onClick={() => handleDeleteFolder(folder)}
                    className="rounded-md px-2 text-xs font-semibold text-rose-600 hover:bg-rose-50"
                  >
                    Del
                  </button>
                </div>
              ))}
            </nav>
          </aside>

          <div className="min-w-0">
            <div className="flex flex-col gap-3 rounded-lg border border-slate-200 bg-white p-4 shadow-sm md:flex-row md:items-center md:justify-between">
              <div className="flex flex-1 flex-col gap-3 md:flex-row">
                <input
                  type="search"
                  value={searchQuery}
                  onChange={(event) => setSearchQuery(event.target.value)}
                  className="h-10 w-full rounded-md border border-slate-300 bg-white px-3 text-sm outline-none transition placeholder:text-slate-400 focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100 md:max-w-md"
                  placeholder="Search title or text"
                />
                <select
                  value={sortOption}
                  onChange={(event) =>
                    setSortOption(event.target.value as SortOption)
                  }
                  className="h-10 rounded-md border border-slate-300 bg-white px-3 text-sm text-slate-700 outline-none transition focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
                >
                  <option value="newest">Newest first</option>
                  <option value="oldest">Oldest first</option>
                  <option value="title-asc">Title A-Z</option>
                  <option value="title-desc">Title Z-A</option>
                </select>
              </div>

              {statusMessage ? (
                <p
                  className={`text-sm font-medium ${
                    statusType === 'success'
                      ? 'text-emerald-700'
                      : 'text-rose-700'
                  }`}
                  role="status"
                >
                  {statusMessage}
                </p>
              ) : null}
            </div>

            <section className="mt-4">
              {filteredDocuments.length > 0 ? (
                <div className="overflow-hidden rounded-lg border border-slate-200 bg-white shadow-sm">
                  <ul className="divide-y divide-slate-200">
                    {filteredDocuments.map((document) => {
                      const progress = getProgress(document);

                      return (
                        <li
                          key={document.id}
                          className="grid gap-4 p-4 transition hover:bg-slate-50 xl:grid-cols-[minmax(0,1fr)_auto] xl:items-center"
                        >
                        <div className="min-w-0">
                          <div className="flex flex-wrap items-center gap-2">
                            <h2 className="truncate text-lg font-semibold text-slate-950">
                              {document.title}
                            </h2>
                            <span className="rounded bg-slate-100 px-2 py-1 text-xs font-medium text-slate-600">
                              {getFolderName(folders, document.folderId)}
                            </span>
                          </div>
                          <dl className="mt-3 grid gap-2 text-sm text-slate-600 md:grid-cols-5">
                            <div>
                              <dt className="font-medium text-slate-500">
                                Created
                              </dt>
                              <dd>{formatDate(document.createdAt)}</dd>
                            </div>
                            <div>
                              <dt className="font-medium text-slate-500">
                                Sentences
                              </dt>
                              <dd>{document.sentences.length}</dd>
                            </div>
                            <div>
                              <dt className="font-medium text-slate-500">
                                Progress
                              </dt>
                              <dd>
                                {progress.currentPosition} /{' '}
                                {progress.totalSentences} ·{' '}
                                {progress.percentage}%
                              </dd>
                            </div>
                            <div>
                              <dt className="font-medium text-slate-500">
                                Vocabulary
                              </dt>
                              <dd>
                                {vocabularyCountByDocument[document.id] ?? 0}
                              </dd>
                            </div>
                            <div>
                              <dt className="font-medium text-slate-500">
                                Favorites
                              </dt>
                              <dd>
                                {favoriteCountByDocument[document.id] ?? 0}
                              </dd>
                            </div>
                          </dl>
                        </div>

                        <div className="flex flex-col gap-2 md:flex-row xl:justify-end">
                          <select
                            value={document.folderId ?? ''}
                            onChange={(event) =>
                              handleMoveDocument(
                                document.id,
                                event.target.value,
                              )
                            }
                            className="h-10 rounded-md border border-slate-300 bg-white px-3 text-sm text-slate-700 outline-none transition focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
                            aria-label={`Move ${document.title}`}
                          >
                            <option value="">Unfiled</option>
                            {folders.map((folder) => (
                              <option key={folder.id} value={folder.id}>
                                {folder.name}
                              </option>
                            ))}
                          </select>
                          <button
                            type="button"
                            onClick={() => onOpenDocument(document)}
                            className="inline-flex h-10 items-center justify-center rounded-md bg-slate-900 px-4 text-sm font-semibold text-white shadow-sm transition hover:bg-slate-800 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
                          >
                            Open
                          </button>
                          <button
                            type="button"
                            onClick={() => handleRenameDocument(document)}
                            className="inline-flex h-10 items-center justify-center rounded-md border border-slate-300 bg-white px-4 text-sm font-semibold text-slate-700 shadow-sm transition hover:bg-slate-100 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
                          >
                            Rename
                          </button>
                          <button
                            type="button"
                            onClick={() => onDeleteDocument(document.id)}
                            className="inline-flex h-10 items-center justify-center rounded-md border border-rose-200 bg-white px-4 text-sm font-semibold text-rose-700 shadow-sm transition hover:bg-rose-50 focus:outline-none focus:ring-2 focus:ring-rose-500 focus:ring-offset-2"
                          >
                            Delete
                          </button>
                        </div>
                        </li>
                      );
                    })}
                  </ul>
                </div>
              ) : (
                <div className="border-l-4 border-cyan-700 bg-white p-5 shadow-sm">
                  <h2 className="text-lg font-semibold text-slate-950">
                    No documents found
                  </h2>
                  <p className="mt-2 text-sm leading-6 text-slate-600">
                    Try another folder or search term, or create a new
                    document.
                  </p>
                </div>
              )}
            </section>
          </div>
        </section>

        <input
          ref={libraryInputRef}
          type="file"
          accept="application/json,.json"
          className="hidden"
          onChange={handleImportLibrary}
        />
        <input
          ref={txtInputRef}
          type="file"
          accept="text/plain,.txt"
          multiple
          className="hidden"
          onChange={handleImportTxtFiles}
        />
      </div>
    </main>
  );
}

export default DocumentLibrary;
