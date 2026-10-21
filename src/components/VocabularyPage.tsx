import { useEffect, useMemo, useRef, useState } from 'react';
import type { ChangeEvent } from 'react';
import type { VocabularyItem } from '../types';
import { lookupWord } from '../services/aiService';
import type { WordLookup } from '../services/aiService';
import { parseDocxFile, parseTxtFile } from '../utils/fileParsers';
import {
  deleteVocabularyItem,
  getVocabularyItems,
  importVocabularyItems,
  setVocabularyDirtyBasketStatus,
  updateVocabularyDetails,
} from '../utils/storage';
import {
  parseVocabularyText,
  type VocabularyImportResult,
} from '../utils/vocabularyImport';
import {
  exportVocabularyExcel,
  exportVocabularyWord,
  getVocabularyExcelFileName,
} from '../utils/vocabularyExport';

type VocabularyPageProps = {
  onBackToLibrary: () => void;
};

type ImportPreview = VocabularyImportResult & {
  fileName: string;
};

const VOCABULARY_PAGE_SIZE = 50;
type VocabularySortMode = 'newest' | 'oldest' | 'alphabetical' | 'random';
type VocabularyViewMode = 'all' | 'dirtyBasket';

function formatDate(value: string) {
  return new Intl.DateTimeFormat(undefined, {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
  }).format(new Date(value));
}

function getCompactMeaning(item: VocabularyItem) {
  const meaning = item.meaning?.trim();

  if (!meaning || !/[\u3400-\u9fff]/.test(meaning)) {
    return 'No Chinese meaning yet';
  }

  const meanings = meaning
    .split(/[;；]/)
    .map((value) => value.trim())
    .filter(Boolean);

  return meanings.length > 0 ? meanings.slice(0, 4).join('；') : meaning;
}

function getRandomRank(value: string, seed: number) {
  let hash = seed | 0;

  for (let index = 0; index < value.length; index += 1) {
    hash = Math.imul(hash ^ value.charCodeAt(index), 16_777_619);
  }

  hash ^= hash >>> 16;
  return hash >>> 0;
}

function downloadBlob(blob: Blob, fileName: string) {
  const url = URL.createObjectURL(blob);
  const link = document.createElement('a');

  link.href = url;
  link.download = fileName;
  link.click();
  window.setTimeout(() => URL.revokeObjectURL(url), 1_000);
}

function VocabularyPage({ onBackToLibrary }: VocabularyPageProps) {
  const importInputRef = useRef<HTMLInputElement>(null);
  const [items, setItems] = useState<VocabularyItem[]>(() =>
    getVocabularyItems(),
  );
  const [searchQuery, setSearchQuery] = useState('');
  const [viewMode, setViewMode] = useState<VocabularyViewMode>('all');
  const [sortMode, setSortMode] = useState<VocabularySortMode>('newest');
  const [shuffleSeed, setShuffleSeed] = useState(() => Date.now());
  const [currentPage, setCurrentPage] = useState(1);
  const [expandedItemId, setExpandedItemId] = useState<string | null>(null);
  const [importPreview, setImportPreview] = useState<ImportPreview | null>(null);
  const [importStatus, setImportStatus] = useState('');
  const [isParsingImport, setIsParsingImport] = useState(false);
  const [analyzingItemId, setAnalyzingItemId] = useState<string | null>(null);
  const [bulkAiProgress, setBulkAiProgress] = useState<{
    completed: number;
    total: number;
  } | null>(null);
  const [exportingFormat, setExportingFormat] = useState<
    'word' | 'excel' | null
  >(null);

  const dirtyBasketCount = useMemo(
    () => items.filter((item) => item.inDirtyBasket).length,
    [items],
  );
  const viewItems = useMemo(
    () =>
      viewMode === 'dirtyBasket'
        ? items.filter((item) => item.inDirtyBasket)
        : items,
    [items, viewMode],
  );

  const filteredItems = useMemo(() => {
    const normalizedQuery = searchQuery.trim().toLowerCase();

    const matchingItems = !normalizedQuery ? viewItems : viewItems.filter(
      (item) =>
        item.word.toLowerCase().includes(normalizedQuery) ||
        item.meaning?.toLowerCase().includes(normalizedQuery) ||
        item.documentTitle.toLowerCase().includes(normalizedQuery),
    );

    return [...matchingItems].sort((left, right) => {
      if (sortMode === 'alphabetical') {
        return left.word.localeCompare(right.word, 'en', {
          sensitivity: 'base',
        });
      }

      if (sortMode === 'oldest') {
        return (
          new Date(left.createdAt).getTime() -
          new Date(right.createdAt).getTime()
        );
      }

      if (sortMode === 'random') {
        return (
          getRandomRank(left.id, shuffleSeed) -
          getRandomRank(right.id, shuffleSeed)
        );
      }

      return (
        new Date(right.createdAt).getTime() -
        new Date(left.createdAt).getTime()
      );
    });
  }, [searchQuery, shuffleSeed, sortMode, viewItems]);
  const pageCount = Math.max(
    1,
    Math.ceil(filteredItems.length / VOCABULARY_PAGE_SIZE),
  );
  const paginatedItems = useMemo(() => {
    const startIndex = (currentPage - 1) * VOCABULARY_PAGE_SIZE;

    return filteredItems.slice(
      startIndex,
      startIndex + VOCABULARY_PAGE_SIZE,
    );
  }, [currentPage, filteredItems]);
  const firstVisibleItem =
    filteredItems.length === 0
      ? 0
      : (currentPage - 1) * VOCABULARY_PAGE_SIZE + 1;
  const lastVisibleItem = Math.min(
    currentPage * VOCABULARY_PAGE_SIZE,
    filteredItems.length,
  );
  const existingWordKeys = useMemo(
    () => new Set(items.map((item) => item.word.toLocaleLowerCase())),
    [items],
  );
  const previewNewEntries = useMemo(
    () =>
      importPreview?.entries.filter(
        (entry) => !existingWordKeys.has(entry.word.toLocaleLowerCase()),
      ) ?? [],
    [existingWordKeys, importPreview],
  );
  const previewExistingCount =
    (importPreview?.entries.length ?? 0) - previewNewEntries.length;

  useEffect(() => {
    setCurrentPage((page) => Math.min(page, pageCount));
  }, [pageCount]);

  const refreshItems = () => {
    setItems(getVocabularyItems());
  };

  const handleUpdateDetails = (
    id: string,
    fields: Parameters<typeof updateVocabularyDetails>[1],
  ) => {
    updateVocabularyDetails(id, fields);
    refreshItems();
  };

  const saveAiLookup = (item: VocabularyItem, result: WordLookup) => {
    const lookedUpForm = item.originalForm || item.word;

    updateVocabularyDetails(item.id, {
      word: result.lemma || item.word,
      originalForm:
        result.lemma.toLowerCase() !== lookedUpForm.toLowerCase()
          ? lookedUpForm
          : undefined,
      meaning: result.chineseMeaning || result.meaning,
      partOfSpeech: result.partOfSpeech,
      englishExplanation: result.englishExplanation,
      inflectionExplanation: result.inflectionExplanation,
      phonetic: result.phonetic,
      example: result.example,
    });
  };

  const handleAnalyzeItem = async (item: VocabularyItem) => {
    setAnalyzingItemId(item.id);
    setImportStatus('');

    try {
      const result = await lookupWord(
        item.originalForm || item.word,
        item.sentenceText,
        item.entryType ?? 'word',
      );
      saveAiLookup(item, result);
      refreshItems();
      setImportStatus(`AI details updated for “${result.lemma || item.word}”.`);
    } catch {
      setImportStatus(`AI analysis failed for “${item.word}”. Please try again.`);
    } finally {
      setAnalyzingItemId(null);
    }
  };

  const handleAnalyzeMissing = async () => {
    const missingItems = items.filter(
      (item) =>
        !/[\u3400-\u9fff]/.test(item.meaning ?? '') ||
        !item.partOfSpeech ||
        !item.englishExplanation,
    );

    if (missingItems.length === 0) {
      setImportStatus('Every saved word already has AI dictionary details.');
      return;
    }

    setBulkAiProgress({ completed: 0, total: missingItems.length });
    setImportStatus('');
    let successCount = 0;

    for (let index = 0; index < missingItems.length; index += 1) {
      const item = missingItems[index];

      try {
        const result = await lookupWord(
          item.originalForm || item.word,
          item.sentenceText,
          item.entryType ?? 'word',
        );
        saveAiLookup(item, result);
        successCount += 1;
      } catch {
        // Keep the original entry and continue with the remaining words.
      }

      setBulkAiProgress({ completed: index + 1, total: missingItems.length });
    }

    refreshItems();
    setBulkAiProgress(null);
    setImportStatus(
      `AI dictionary details updated for ${successCount} of ${missingItems.length} words.` +
        (successCount < missingItems.length ? ' Failed words were left unchanged.' : ''),
    );
  };

  const handleDelete = (id: string) => {
    deleteVocabularyItem(id);
    setExpandedItemId((current) => (current === id ? null : current));
    refreshItems();
  };

  const handleDirtyBasketStatus = (
    item: VocabularyItem,
    inDirtyBasket: boolean,
  ) => {
    setVocabularyDirtyBasketStatus(item.id, inDirtyBasket);
    setExpandedItemId(null);
    refreshItems();
    setImportStatus(
      inDirtyBasket
        ? `Added “${item.word}” to the Dirty Basket.`
        : `Removed “${item.word}” from the Dirty Basket. It remains in Vocabulary.`,
    );
  };

  const handleImportFile = async (event: ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    event.target.value = '';

    if (!file) {
      return;
    }

    setImportStatus('');
    setIsParsingImport(true);

    try {
      const fileName = file.name.toLowerCase();
      const text = fileName.endsWith('.docx')
        ? await parseDocxFile(file)
        : /\.(txt|md|csv)$/i.test(fileName)
          ? await parseTxtFile(file)
          : '';

      if (!text) {
        throw new Error('Please choose a DOCX, TXT, Markdown, or CSV file.');
      }

      const result = parseVocabularyText(text);

      if (result.entries.length === 0) {
        throw new Error('No readable English words were found in this file.');
      }

      setImportPreview({ ...result, fileName: file.name });
    } catch (error) {
      setImportPreview(null);
      setImportStatus(
        error instanceof Error ? error.message : 'Could not read this file.',
      );
    } finally {
      setIsParsingImport(false);
    }
  };

  const handleConfirmImport = () => {
    if (!importPreview) {
      return;
    }

    const result = importVocabularyItems(importPreview.entries);
    refreshItems();
    setImportPreview(null);
    setImportStatus(
      `Imported ${result.importedCount} word${result.importedCount === 1 ? '' : 's'}.` +
        (result.skippedCount > 0
          ? ` Skipped ${result.skippedCount} already in your vocabulary.`
          : ''),
    );
  };

  const handleExportWord = async () => {
    if (items.length === 0) {
      return;
    }

    setExportingFormat('word');
    setImportStatus('');

    try {
      const result = await exportVocabularyWord(items);
      downloadBlob(result.blob, result.fileName);
      setImportStatus(
        `Exported ${items.length} words in the four-part 百词 Word format.`,
      );
    } catch {
      setImportStatus('Word export failed. Please try again.');
    } finally {
      setExportingFormat(null);
    }
  };

  const handleExportExcel = async () => {
    if (items.length === 0) {
      return;
    }

    setExportingFormat('excel');
    setImportStatus('');

    try {
      const blob = await exportVocabularyExcel(items);
      downloadBlob(blob, getVocabularyExcelFileName());
      setImportStatus(
        `Exported ${items.length} words to four Excel worksheets.`,
      );
    } catch {
      setImportStatus('Excel export failed. Please try again.');
    } finally {
      setExportingFormat(null);
    }
  };

  const handlePageChange = (page: number) => {
    setExpandedItemId(null);
    setCurrentPage(Math.min(Math.max(page, 1), pageCount));
  };

  const paginationControls =
    filteredItems.length > VOCABULARY_PAGE_SIZE ? (
      <nav
        aria-label="Vocabulary pages"
        className="flex flex-wrap items-center justify-center gap-3"
      >
        <button
          type="button"
          onClick={() => handlePageChange(currentPage - 1)}
          disabled={currentPage === 1}
          className="inline-flex h-9 items-center justify-center rounded-md border border-slate-300 bg-white px-3 text-sm font-semibold text-slate-700 shadow-sm transition hover:bg-slate-50 disabled:cursor-not-allowed disabled:opacity-40"
        >
          Previous
        </button>
        <span className="min-w-28 text-center text-sm text-slate-600">
          Page {currentPage} of {pageCount}
        </span>
        <button
          type="button"
          onClick={() => handlePageChange(currentPage + 1)}
          disabled={currentPage === pageCount}
          className="inline-flex h-9 items-center justify-center rounded-md border border-slate-300 bg-white px-3 text-sm font-semibold text-slate-700 shadow-sm transition hover:bg-slate-50 disabled:cursor-not-allowed disabled:opacity-40"
        >
          Next
        </button>
      </nav>
    ) : null;

  return (
    <main className="min-h-screen bg-slate-50 text-slate-950">
      <div className="mx-auto w-full max-w-5xl px-4 py-8 sm:px-6 lg:px-8">
        <header className="flex flex-col gap-4 border-b border-slate-200 pb-6 md:flex-row md:items-end md:justify-between">
          <div>
            <p className="text-sm font-medium text-cyan-700">
              AI Intensive Reading
            </p>
            <h1 className="mt-2 text-3xl font-semibold text-slate-950">
              Vocabulary
            </h1>
          </div>
          <div className="flex flex-wrap gap-2">
            <input
              ref={importInputRef}
              type="file"
              accept=".docx,.txt,.md,.csv"
              onChange={handleImportFile}
              className="hidden"
            />
            <button
              type="button"
              onClick={() => importInputRef.current?.click()}
              disabled={isParsingImport || bulkAiProgress !== null}
              className="inline-flex h-10 items-center justify-center rounded-md border border-cyan-300 bg-white px-4 text-sm font-semibold text-cyan-800 shadow-sm transition hover:bg-cyan-50 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2 disabled:cursor-wait disabled:opacity-60"
            >
              {isParsingImport ? 'Reading File...' : 'Import Words'}
            </button>
            <button
              type="button"
              onClick={() => void handleAnalyzeMissing()}
              disabled={
                bulkAiProgress !== null ||
                analyzingItemId !== null ||
                exportingFormat !== null
              }
              className="inline-flex h-10 items-center justify-center rounded-md border border-violet-300 bg-white px-4 text-sm font-semibold text-violet-800 shadow-sm transition hover:bg-violet-50 focus:outline-none focus:ring-2 focus:ring-violet-500 focus:ring-offset-2 disabled:cursor-wait disabled:opacity-60"
            >
              {bulkAiProgress
                ? `AI ${bulkAiProgress.completed}/${bulkAiProgress.total}`
                : 'AI Fill Missing'}
            </button>
            <button
              type="button"
              onClick={() => void handleExportWord()}
              disabled={items.length === 0 || exportingFormat !== null}
              className="inline-flex h-10 items-center justify-center rounded-md border border-slate-300 bg-white px-4 text-sm font-semibold text-slate-700 shadow-sm transition hover:bg-slate-100 disabled:cursor-wait disabled:opacity-60 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
            >
              {exportingFormat === 'word' ? 'Building Word...' : 'Export 百词 Word'}
            </button>
            <button
              type="button"
              onClick={() => void handleExportExcel()}
              disabled={items.length === 0 || exportingFormat !== null}
              className="inline-flex h-10 items-center justify-center rounded-md border border-slate-300 bg-white px-4 text-sm font-semibold text-slate-700 shadow-sm transition hover:bg-slate-100 disabled:cursor-wait disabled:opacity-60 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
            >
              {exportingFormat === 'excel'
                ? 'Building Excel...'
                : 'Export Excel'}
            </button>
            <button
              type="button"
              onClick={onBackToLibrary}
              className="inline-flex h-10 items-center justify-center rounded-md border border-slate-300 bg-white px-4 text-sm font-semibold text-slate-700 shadow-sm transition hover:bg-slate-100 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
            >
              Back to Library
            </button>
          </div>
        </header>

        <div className="mt-5 rounded-lg border border-slate-200 bg-white p-4 shadow-sm">
          <div
            className="mb-4 inline-flex rounded-lg border border-slate-200 bg-slate-100 p-1"
            role="group"
            aria-label="Vocabulary list"
          >
            <button
              type="button"
              onClick={() => {
                setViewMode('all');
                setCurrentPage(1);
                setExpandedItemId(null);
              }}
              aria-pressed={viewMode === 'all'}
              className={`inline-flex h-9 items-center justify-center rounded-md px-4 text-sm font-semibold transition focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2 ${
                viewMode === 'all'
                  ? 'bg-white text-slate-950 shadow-sm'
                  : 'text-slate-600 hover:text-slate-950'
              }`}
            >
              Vocabulary
              <span className="ml-2 text-xs text-slate-500">{items.length}</span>
            </button>
            <button
              type="button"
              onClick={() => {
                setViewMode('dirtyBasket');
                setCurrentPage(1);
                setExpandedItemId(null);
              }}
              aria-pressed={viewMode === 'dirtyBasket'}
              className={`inline-flex h-9 items-center justify-center rounded-md px-4 text-sm font-semibold transition focus:outline-none focus:ring-2 focus:ring-amber-500 focus:ring-offset-2 ${
                viewMode === 'dirtyBasket'
                  ? 'bg-white text-amber-800 shadow-sm'
                  : 'text-slate-600 hover:text-amber-800'
              }`}
            >
              Dirty Basket
              <span
                className={`ml-2 rounded-full px-2 py-0.5 text-xs ${
                  viewMode === 'dirtyBasket'
                    ? 'bg-amber-100 text-amber-800'
                    : 'bg-slate-200 text-slate-600'
                }`}
              >
                {dirtyBasketCount}
              </span>
            </button>
          </div>
          <div className="flex flex-col gap-3 md:flex-row md:items-center md:justify-between">
            <input
              type="search"
              value={searchQuery}
              onChange={(event) => {
                setSearchQuery(event.target.value);
                setCurrentPage(1);
                setExpandedItemId(null);
              }}
              className="h-10 w-full rounded-md border border-slate-300 bg-white px-3 text-sm outline-none transition placeholder:text-slate-400 focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100 md:max-w-md"
              placeholder="Search English or Chinese meaning"
            />
            <div className="flex flex-wrap items-center gap-2">
              <select
                value={sortMode}
                onChange={(event) => {
                  const nextMode = event.target.value as VocabularySortMode;
                  setSortMode(nextMode);
                  if (nextMode === 'random') {
                    setShuffleSeed(Date.now() + Math.random());
                  }
                  setCurrentPage(1);
                  setExpandedItemId(null);
                }}
                className="h-10 rounded-md border border-slate-300 bg-white px-3 text-sm font-medium text-slate-700 outline-none transition focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
                aria-label="Vocabulary order"
              >
                <option value="newest">Newest saved</option>
                <option value="oldest">Oldest saved</option>
                <option value="alphabetical">Alphabetical A–Z</option>
                <option value="random">Random</option>
              </select>
              {sortMode === 'random' ? (
                <button
                  type="button"
                  onClick={() => {
                    setShuffleSeed(Date.now() + Math.random());
                    setCurrentPage(1);
                    setExpandedItemId(null);
                  }}
                  className="inline-flex h-10 items-center justify-center rounded-md border border-cyan-300 bg-white px-3 text-sm font-semibold text-cyan-800 shadow-sm transition hover:bg-cyan-50 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
                >
                  Shuffle again
                </button>
              ) : null}
              <p className="text-sm text-slate-500">
                {filteredItems.length} / {viewItems.length} entries
                {filteredItems.length > 0
                  ? ` · showing ${firstVisibleItem}–${lastVisibleItem}`
                  : ''}
              </p>
            </div>
          </div>
          {importStatus ? (
            <p className="mt-3 text-sm text-slate-600">{importStatus}</p>
          ) : null}
          {paginationControls ? (
            <div className="mt-4 border-t border-slate-200 pt-4">
              {paginationControls}
            </div>
          ) : null}
        </div>

        {importPreview ? (
          <section className="mt-4 rounded-lg border border-cyan-200 bg-white p-4 shadow-sm">
            <div className="flex flex-col gap-3 md:flex-row md:items-start md:justify-between">
              <div>
                <h2 className="text-lg font-semibold text-slate-950">
                  Import preview
                </h2>
                <p className="mt-1 text-sm text-slate-600">
                  {importPreview.fileName} · {previewNewEntries.length} new ·{' '}
                  {previewExistingCount} already saved
                  {importPreview.duplicateCount > 0
                    ? ` · ${importPreview.duplicateCount} repeated in file`
                    : ''}
                </p>
              </div>
              <div className="flex gap-2">
                <button
                  type="button"
                  onClick={() => setImportPreview(null)}
                  className="inline-flex h-9 items-center justify-center rounded-md border border-slate-300 bg-white px-3 text-sm font-semibold text-slate-700 hover:bg-slate-50"
                >
                  Cancel
                </button>
                <button
                  type="button"
                  onClick={handleConfirmImport}
                  disabled={previewNewEntries.length === 0}
                  className="inline-flex h-9 items-center justify-center rounded-md bg-cyan-700 px-3 text-sm font-semibold text-white hover:bg-cyan-800 disabled:cursor-not-allowed disabled:opacity-50"
                >
                  Import {previewNewEntries.length}
                </button>
              </div>
            </div>
            <div className="mt-4 max-h-72 overflow-y-auto rounded-md border border-slate-200">
              <table className="w-full border-collapse text-left text-sm">
                <thead className="sticky top-0 bg-slate-100 text-slate-600">
                  <tr>
                    <th className="px-3 py-2 font-semibold">English</th>
                    <th className="px-3 py-2 font-semibold">Chinese meaning</th>
                    <th className="px-3 py-2 font-semibold">Status</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-slate-200">
                  {importPreview.entries.map((entry) => {
                    const alreadySaved = existingWordKeys.has(
                      entry.word.toLocaleLowerCase(),
                    );

                    return (
                      <tr key={entry.word} className="bg-white">
                        <td className="px-3 py-2 font-semibold text-slate-900">
                          {entry.word}
                        </td>
                        <td className="px-3 py-2 text-slate-700">
                          {entry.meaning ?? '—'}
                        </td>
                        <td className="px-3 py-2 text-slate-500">
                          {alreadySaved ? 'Already saved' : 'New'}
                        </td>
                      </tr>
                    );
                  })}
                </tbody>
              </table>
            </div>
            {importPreview.invalidLines.length > 0 ? (
              <details className="mt-3 text-sm text-amber-800">
                <summary className="cursor-pointer font-semibold">
                  {importPreview.invalidLines.length} line(s) could not be read
                </summary>
                <ul className="mt-2 list-disc space-y-1 pl-5 text-amber-700">
                  {importPreview.invalidLines.map((line, index) => (
                    <li key={`${index}-${line}`}>{line}</li>
                  ))}
                </ul>
              </details>
            ) : null}
          </section>
        ) : null}

        <section className="mt-4">
          {filteredItems.length > 0 ? (
            <ul className="divide-y divide-slate-200 overflow-hidden rounded-lg border border-slate-200 bg-white shadow-sm">
              {paginatedItems.map((item) => {
                const isExpanded = expandedItemId === item.id;

                return (
                  <li key={item.id}>
                    <button
                      type="button"
                      onClick={() =>
                        setExpandedItemId((current) =>
                          current === item.id ? null : item.id,
                        )
                      }
                      aria-expanded={isExpanded}
                      className="grid w-full grid-cols-[minmax(0,0.8fr)_minmax(0,1.7fr)_auto] items-center gap-4 px-4 py-3 text-left transition hover:bg-slate-50 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-cyan-500"
                    >
                      <span className="min-w-0 text-base font-semibold text-slate-950">
                        <span className="break-words">{item.word}</span>
                        {item.entryType === 'phrase' ? (
                          <span className="ml-2 inline-flex rounded-full bg-violet-50 px-2 py-0.5 align-middle text-[10px] font-semibold uppercase tracking-wide text-violet-700">
                            Phrase
                          </span>
                        ) : null}
                        {viewMode === 'all' && item.inDirtyBasket ? (
                          <span className="ml-2 inline-flex rounded-full bg-amber-50 px-2 py-0.5 align-middle text-[10px] font-semibold uppercase tracking-wide text-amber-700">
                            Dirty Basket
                          </span>
                        ) : null}
                      </span>
                      <span
                        className={`break-words text-sm leading-5 ${
                          item.meaning ? 'text-slate-700' : 'text-slate-400'
                        }`}
                      >
                        {getCompactMeaning(item)}
                      </span>
                      <span className="text-sm text-slate-400" aria-hidden="true">
                        {isExpanded ? '▾' : '▸'}
                      </span>
                    </button>

                    {isExpanded ? (
                      <div className="border-t border-slate-200 bg-slate-50/60 p-4">
                        <div className="flex flex-col gap-3 md:flex-row md:items-start md:justify-between">
                          <div className="min-w-0">
                            <h2 className="text-2xl font-semibold text-slate-950">
                              {item.word}
                            </h2>
                            <p className="mt-1 text-sm text-slate-500">
                              {[item.documentTitle, formatDate(item.createdAt)]
                                .filter(Boolean)
                                .join(' · ')}
                            </p>
                            {item.sentenceText ? (
                              <p className="mt-3 text-sm leading-6 text-slate-700">
                                {item.sentenceText}
                              </p>
                            ) : null}
                          </div>
                          <div className="flex shrink-0 flex-wrap gap-2">
                            <button
                              type="button"
                              onClick={() => void handleAnalyzeItem(item)}
                              disabled={analyzingItemId !== null}
                              className="inline-flex h-9 items-center justify-center rounded-md border border-violet-200 bg-white px-3 text-sm font-semibold text-violet-700 shadow-sm transition hover:bg-violet-50 disabled:cursor-wait disabled:opacity-50 focus:outline-none focus:ring-2 focus:ring-violet-500 focus:ring-offset-2"
                            >
                              {analyzingItemId === item.id
                                ? 'Analyzing...'
                                : 'Analyze with AI'}
                            </button>
                            <button
                              type="button"
                              onClick={() =>
                                handleDirtyBasketStatus(
                                  item,
                                  !item.inDirtyBasket,
                                )
                              }
                              className={`inline-flex h-9 items-center justify-center rounded-md border bg-white px-3 text-sm font-semibold shadow-sm transition focus:outline-none focus:ring-2 focus:ring-offset-2 ${
                                item.inDirtyBasket
                                  ? 'border-amber-300 text-amber-800 hover:bg-amber-50 focus:ring-amber-500'
                                  : 'border-slate-300 text-slate-700 hover:border-amber-300 hover:bg-amber-50 hover:text-amber-800 focus:ring-amber-500'
                              }`}
                            >
                              {item.inDirtyBasket
                                ? 'Remove from Dirty Basket'
                                : 'Add to Dirty Basket'}
                            </button>
                            {viewMode === 'all' ? (
                              <button
                                type="button"
                                onClick={() => handleDelete(item.id)}
                                className="inline-flex h-9 items-center justify-center rounded-md border border-rose-200 bg-white px-3 text-sm font-semibold text-rose-700 shadow-sm transition hover:bg-rose-50 focus:outline-none focus:ring-2 focus:ring-rose-500 focus:ring-offset-2"
                              >
                                Delete
                              </button>
                            ) : null}
                          </div>
                        </div>
                        {item.originalForm || item.inflectionExplanation ? (
                          <p className="mt-4 rounded-md bg-violet-50 px-3 py-2 text-sm text-violet-900">
                            {item.originalForm
                              ? `Collected form: ${item.originalForm}`
                              : 'Base form'}
                            {item.inflectionExplanation
                              ? ` · ${item.inflectionExplanation}`
                              : ''}
                          </p>
                        ) : null}
                        <label className="mt-4 block text-sm font-semibold text-slate-700">
                          Meaning
                        </label>
                        <textarea
                          value={item.meaning ?? ''}
                          onChange={(event) =>
                            handleUpdateDetails(item.id, {
                              meaning: event.target.value,
                              phonetic: item.phonetic,
                              example: item.example,
                              note: item.note,
                            })
                          }
                          rows={2}
                          className="mt-2 w-full resize-y rounded-md border border-slate-300 bg-white px-3 py-2 text-sm leading-6 outline-none transition focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
                          placeholder="Add manual meaning..."
                        />
                        <div className="mt-4 grid gap-4 md:grid-cols-2">
                          <div>
                            <label className="block text-sm font-semibold text-slate-700">
                              Part of speech
                            </label>
                            <input
                              value={item.partOfSpeech ?? ''}
                              onChange={(event) =>
                                handleUpdateDetails(item.id, {
                                  partOfSpeech: event.target.value,
                                })
                              }
                              className="mt-2 h-10 w-full rounded-md border border-slate-300 bg-white px-3 text-sm outline-none transition focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
                              placeholder="noun / verb / adjective..."
                            />
                          </div>
                          <div>
                            <label className="block text-sm font-semibold text-slate-700">
                              Phonetic
                            </label>
                            <input
                              value={item.phonetic ?? ''}
                              onChange={(event) =>
                                handleUpdateDetails(item.id, {
                                  meaning: item.meaning,
                                  phonetic: event.target.value,
                                  example: item.example,
                                  note: item.note,
                                })
                              }
                              className="mt-2 h-10 w-full rounded-md border border-slate-300 bg-white px-3 text-sm outline-none transition focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
                              placeholder="/.../"
                            />
                          </div>
                          <div>
                            <label className="block text-sm font-semibold text-slate-700">
                              Note
                            </label>
                            <input
                              value={item.note ?? ''}
                              onChange={(event) =>
                                handleUpdateDetails(item.id, {
                                  meaning: item.meaning,
                                  phonetic: item.phonetic,
                                  example: item.example,
                                  note: event.target.value,
                                })
                              }
                              className="mt-2 h-10 w-full rounded-md border border-slate-300 bg-white px-3 text-sm outline-none transition focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
                              placeholder="Short note..."
                            />
                          </div>
                          <div className="md:col-span-2">
                            <label className="block text-sm font-semibold text-slate-700">
                              English explanation
                            </label>
                            <textarea
                              value={item.englishExplanation ?? ''}
                              onChange={(event) =>
                                handleUpdateDetails(item.id, {
                                  englishExplanation: event.target.value,
                                })
                              }
                              rows={2}
                              className="mt-2 w-full resize-y rounded-md border border-slate-300 bg-white px-3 py-2 text-sm leading-6 outline-none transition focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
                              placeholder="AI or manual English explanation..."
                            />
                          </div>
                        </div>
                        <label className="mt-4 block text-sm font-semibold text-slate-700">
                          Example
                        </label>
                        <textarea
                          value={item.example ?? ''}
                          onChange={(event) =>
                            handleUpdateDetails(item.id, {
                              meaning: item.meaning,
                              phonetic: item.phonetic,
                              example: event.target.value,
                              note: item.note,
                            })
                          }
                          rows={2}
                          className="mt-2 w-full resize-y rounded-md border border-slate-300 bg-white px-3 py-2 text-sm leading-6 outline-none transition focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
                          placeholder="Add example usage..."
                        />
                      </div>
                    ) : null}
                  </li>
                );
              })}
            </ul>
          ) : (
            <div className="border-l-4 border-cyan-700 bg-white p-5 shadow-sm">
              <h2 className="text-lg font-semibold text-slate-950">
                {viewMode === 'dirtyBasket'
                  ? dirtyBasketCount === 0
                    ? 'The Dirty Basket is empty'
                    : 'No matching Dirty Basket entries'
                  : 'No vocabulary items found'}
              </h2>
              <p className="mt-2 text-sm leading-6 text-slate-600">
                {viewMode === 'dirtyBasket'
                  ? dirtyBasketCount === 0
                    ? 'Open a word in Vocabulary and add it here for focused review.'
                    : 'Try a different English word or Chinese meaning.'
                  : 'Add words from the reader word panel or import a vocabulary file.'}
              </p>
            </div>
          )}
          {paginationControls ? (
            <div className="mt-4">{paginationControls}</div>
          ) : null}
        </section>
      </div>
    </main>
  );
}

export default VocabularyPage;
