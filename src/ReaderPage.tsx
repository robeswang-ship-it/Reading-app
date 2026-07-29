import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import ContinuousText from './components/ContinuousText';
import SentenceDetail from './components/SentenceDetail';
import WordPanel from './components/WordPanel';
import { analyzeSentence } from './services/aiService';
import type { Document, VocabularyItem } from './types';
import {
  addFavoriteSentence,
  addVocabularyItem,
  updateSentenceAiFields,
  updateSentenceFields,
  updateDocument,
} from './utils/storage';

type ReaderPageProps = {
  document: Document;
  onBackToLibrary: () => void;
  onDocumentChange: (document: Document) => void;
  onSystemProgressChange?: (
    documentId: string,
    currentSentenceIndex: number,
  ) => void;
  onSystemSentenceNoteChange?: (
    documentId: string,
    sentenceId: string,
    note: string,
  ) => void;
};

type ReadingMode = 'extensive' | 'intensive';
const ARTICLE_FONT_SIZE_KEY = 'ai-intensive-reading:article-font-size';
const DEFAULT_ARTICLE_FONT_SIZE = 21;
const MIN_ARTICLE_FONT_SIZE = 16;
const MAX_ARTICLE_FONT_SIZE = 28;

function updateTransientSentence(
  document: Document,
  sentenceId: string,
  fields: Partial<Document['sentences'][number]>,
) {
  const sentences = document.sentences.map((sentence) =>
    sentence.id === sentenceId ? { ...sentence, ...fields } : sentence,
  );
  const sentenceById = new Map(
    sentences.map((sentence) => [sentence.id, sentence]),
  );

  return {
    ...document,
    sentences,
    paragraphs: document.paragraphs?.map((paragraph) => ({
      ...paragraph,
      sentences: paragraph.sentences
        .map((sentence) => sentenceById.get(sentence.id))
        .filter((sentence) => sentence !== undefined),
    })),
  };
}

function getStoredArticleFontSize() {
  const storedValue = window.localStorage.getItem(ARTICLE_FONT_SIZE_KEY);
  const parsedValue = storedValue ? Number(storedValue) : DEFAULT_ARTICLE_FONT_SIZE;

  if (!Number.isFinite(parsedValue)) {
    return DEFAULT_ARTICLE_FONT_SIZE;
  }

  return Math.min(
    Math.max(parsedValue, MIN_ARTICLE_FONT_SIZE),
    MAX_ARTICLE_FONT_SIZE,
  );
}

function ReaderPage({
  document,
  onBackToLibrary,
  onDocumentChange,
  onSystemProgressChange,
  onSystemSentenceNoteChange,
}: ReaderPageProps) {
  const isSystemDocument = document.origin === 'system';
  const [selectedSentenceIndex, setSelectedSentenceIndex] = useState(
    document.currentSentenceIndex,
  );
  const [selectedWord, setSelectedWord] = useState<string | null>(null);
  const [favoriteStatus, setFavoriteStatus] = useState('');
  const [vocabularyStatus, setVocabularyStatus] = useState('');
  const [readingMode, setReadingMode] = useState<ReadingMode>('extensive');
  const [articleFontSize, setArticleFontSize] = useState(
    getStoredArticleFontSize,
  );
  const documentRef = useRef(document);

  useEffect(() => {
    documentRef.current = document;
  }, [document]);

  useEffect(() => {
    window.localStorage.setItem(
      ARTICLE_FONT_SIZE_KEY,
      String(articleFontSize),
    );
  }, [articleFontSize]);

  const selectedSentence = useMemo(
    () => document.sentences[selectedSentenceIndex] ?? null,
    [document.sentences, selectedSentenceIndex],
  );
  const progressPercentage =
    document.sentences.length > 0
      ? Math.round(((selectedSentenceIndex + 1) / document.sentences.length) * 100)
      : 0;

  const persistAiFields = useCallback((
    sentenceId: string,
    fields: Parameters<typeof updateSentenceAiFields>[2],
  ) => {
    const updatedDocument = updateSentenceAiFields(
      documentRef.current.id,
      sentenceId,
      fields,
    );

    if (updatedDocument) {
      onDocumentChange(updatedDocument);
    }
  }, [onDocumentChange]);

  useEffect(() => {
    setSelectedSentenceIndex(document.currentSentenceIndex);
  }, [document.id, document.currentSentenceIndex]);

  useEffect(() => {
    setFavoriteStatus('');
    setVocabularyStatus('');
  }, [selectedSentenceIndex]);

  useEffect(() => {
    setSelectedWord(null);
  }, [document.id]);

  useEffect(() => {
    const handleKeyDown = (event: KeyboardEvent) => {
      const activeElement = window.document.activeElement;
      const isTyping =
        activeElement instanceof HTMLInputElement ||
        activeElement instanceof HTMLTextAreaElement ||
        activeElement instanceof HTMLSelectElement;

      if (isTyping) {
        return;
      }

      if (event.key === 'ArrowDown') {
        event.preventDefault();
        handleSelectSentence(
          Math.min(selectedSentenceIndex + 1, document.sentences.length - 1),
        );
      }

      if (event.key === 'ArrowUp') {
        event.preventDefault();
        handleSelectSentence(Math.max(selectedSentenceIndex - 1, 0));
      }
    };

    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  });

  useEffect(() => {
    if (isSystemDocument) {
      return;
    }

    let isCancelled = false;

    const getProcessingQueue = () => {
      const sentenceEntries = documentRef.current.sentences
        .map((sentence, index) => ({ sentence, index }))
        .filter(
          ({ sentence }) =>
            !sentence.translation || !sentence.grammar,
        );
      const current = sentenceEntries.filter(
        ({ index }) => index === selectedSentenceIndex,
      );
      const upcoming = sentenceEntries.filter(
        ({ index }) => index > selectedSentenceIndex,
      );
      const previous = sentenceEntries.filter(
        ({ index }) => index < selectedSentenceIndex,
      );

      return [...current, ...upcoming.slice(0, 4), ...upcoming.slice(4), ...previous];
    };

    const processQueue = async () => {
      for (const { sentence } of getProcessingQueue()) {
        if (isCancelled) {
          return;
        }

        persistAiFields(sentence.id, { aiStatus: 'loading' });

        try {
          const analysis = await analyzeSentence(sentence.text);

          if (isCancelled) {
            return;
          }

          persistAiFields(sentence.id, {
            translation: sentence.translation || analysis.translation,
            grammar: sentence.grammar || analysis.grammar,
            keyPhrases: sentence.keyPhrases?.length
              ? sentence.keyPhrases
              : analysis.keyPhrases,
            advancedVocabulary: sentence.advancedVocabulary?.length
              ? sentence.advancedVocabulary
              : analysis.advancedVocabulary,
            aiStatus: 'done',
          });
        } catch {
          if (!isCancelled) {
            persistAiFields(sentence.id, { aiStatus: 'error' });
          }
        }

        await new Promise((resolve) => {
          window.setTimeout(resolve, 150);
        });
      }
    };

    processQueue();

    return () => {
      isCancelled = true;
    };
  }, [
    document.id,
    isSystemDocument,
    persistAiFields,
    selectedSentenceIndex,
  ]);

  const handleSelectSentence = (index: number) => {
    setSelectedWord(null);
    setSelectedSentenceIndex(index);
    const nextDocument = {
      ...document,
      currentSentenceIndex: index,
    };

    if (isSystemDocument) {
      onSystemProgressChange?.(document.id, index);
    } else {
      updateDocument(nextDocument);
    }

    onDocumentChange(nextDocument);
  };

  const handleSelectWord = (word: string) => {
    setSelectedWord((currentWord) =>
      currentWord?.toLowerCase() === word.toLowerCase() ? null : word,
    );
  };

  const handleFavoriteSentence = () => {
    if (!selectedSentence) {
      return;
    }

    const result = addFavoriteSentence({
      documentId: document.id,
      documentTitle: document.title,
      sentenceId: selectedSentence.id,
      sentenceText: selectedSentence.text,
    });

    setFavoriteStatus(result.added ? 'Saved to favorites.' : 'Already saved.');
  };

  const handleAddVocabulary = (
    details: Partial<
      Pick<VocabularyItem, 'meaning' | 'phonetic' | 'example' | 'note'>
    >,
  ) => {
    if (!selectedSentence || !selectedWord) {
      return;
    }

    const result = addVocabularyItem({
      word: selectedWord,
      documentId: document.id,
      documentTitle: document.title,
      sentenceId: selectedSentence.id,
      sentenceText: selectedSentence.text,
      meaning: details.meaning,
      phonetic: details.phonetic,
      example: details.example,
      note: details.note,
    });

    setVocabularyStatus(
      result.added ? 'Saved to vocabulary.' : 'Already in vocabulary.',
    );
  };

  const handleSaveSentenceNotes = (fields: {
    translation?: string;
    grammar?: string;
    userNote?: string;
  }) => {
    if (!selectedSentence) {
      return;
    }

    if (isSystemDocument) {
      onSystemSentenceNoteChange?.(
        document.id,
        selectedSentence.id,
        fields.userNote ?? '',
      );
      const nextDocument = {
        ...document,
        sentences: document.sentences.map((sentence) =>
          sentence.id === selectedSentence.id
            ? {
                ...sentence,
                userNote: fields.userNote?.trim() || undefined,
              }
            : sentence,
        ),
      };
      onDocumentChange(nextDocument);
      return;
    }

    const updatedDocument = updateSentenceFields(
      document.id,
      selectedSentence.id,
      fields,
    );

    if (updatedDocument) {
      onDocumentChange(updatedDocument);
    }
  };

  const handleReanalyzeSentence = async () => {
    if (!selectedSentence) {
      return;
    }

    if (isSystemDocument) {
      onDocumentChange(
        updateTransientSentence(documentRef.current, selectedSentence.id, {
          aiStatus: 'loading',
        }),
      );

      try {
        const analysis = await analyzeSentence(selectedSentence.text);
        onDocumentChange(
          updateTransientSentence(documentRef.current, selectedSentence.id, {
            translation: analysis.translation,
            grammar: analysis.grammar,
            keyPhrases: analysis.keyPhrases,
            advancedVocabulary: analysis.advancedVocabulary,
            aiStatus: 'done',
          }),
        );
      } catch {
        onDocumentChange(
          updateTransientSentence(documentRef.current, selectedSentence.id, {
            aiStatus: 'error',
          }),
        );
      }
      return;
    }

    persistAiFields(selectedSentence.id, { aiStatus: 'loading' });

    try {
      const analysis = await analyzeSentence(selectedSentence.text);
      persistAiFields(selectedSentence.id, {
        translation: analysis.translation,
        grammar: analysis.grammar,
        keyPhrases: analysis.keyPhrases,
        advancedVocabulary: analysis.advancedVocabulary,
        aiStatus: 'done',
        overwrite: true,
      });
    } catch {
      persistAiFields(selectedSentence.id, { aiStatus: 'error' });
    }
  };

  const adjustArticleFontSize = (delta: number) => {
    setArticleFontSize((currentSize) =>
      Math.min(
        Math.max(currentSize + delta, MIN_ARTICLE_FONT_SIZE),
        MAX_ARTICLE_FONT_SIZE,
      ),
    );
  };

  return (
    <main className="min-h-screen bg-slate-50 text-slate-950">
      <div className="mx-auto flex min-h-screen w-full max-w-7xl flex-col gap-4 px-4 py-4 sm:px-6 lg:px-8">
        <header className="sticky top-0 z-20 flex flex-col gap-4 rounded-lg border border-slate-200 bg-white p-4 shadow-sm lg:flex-row lg:items-center lg:justify-between">
          <div>
            <p className="text-sm font-medium text-cyan-700">
              AI Intensive Reading
            </p>
            <h1 className="mt-1 text-2xl font-semibold text-slate-950">
              {document.title}
            </h1>
            <p className="mt-1 text-sm text-slate-500">
              Sentence {selectedSentenceIndex + 1} / {document.sentences.length}
              {' '}· {progressPercentage}%
            </p>
          </div>
          <div className="flex flex-col gap-2 sm:flex-row sm:flex-wrap sm:items-center">
            <div className="inline-flex rounded-md border border-slate-300 bg-slate-50 p-1">
              <button
                type="button"
                onClick={() => setReadingMode('extensive')}
                className={`h-9 rounded px-3 text-sm font-semibold transition ${
                  readingMode === 'extensive'
                    ? 'bg-white text-slate-950 shadow-sm'
                    : 'text-slate-600 hover:text-slate-900'
                }`}
              >
                Extensive Reading
              </button>
              <button
                type="button"
                onClick={() => setReadingMode('intensive')}
                className={`h-9 rounded px-3 text-sm font-semibold transition ${
                  readingMode === 'intensive'
                    ? 'bg-white text-slate-950 shadow-sm'
                    : 'text-slate-600 hover:text-slate-900'
                }`}
              >
                Intensive Reading
              </button>
            </div>
            <div className="inline-flex items-center rounded-md border border-slate-300 bg-white p-1">
              <button
                type="button"
                onClick={() => adjustArticleFontSize(-1)}
                className="h-8 rounded px-3 text-sm font-semibold text-slate-700 transition hover:bg-slate-100 disabled:cursor-not-allowed disabled:opacity-50"
                disabled={articleFontSize <= MIN_ARTICLE_FONT_SIZE}
              >
                A-
              </button>
              <span className="px-2 text-sm font-medium text-slate-500">
                {articleFontSize}px
              </span>
              <button
                type="button"
                onClick={() => adjustArticleFontSize(1)}
                className="h-8 rounded px-3 text-sm font-semibold text-slate-700 transition hover:bg-slate-100 disabled:cursor-not-allowed disabled:opacity-50"
                disabled={articleFontSize >= MAX_ARTICLE_FONT_SIZE}
              >
                A+
              </button>
              <button
                type="button"
                onClick={() => setArticleFontSize(DEFAULT_ARTICLE_FONT_SIZE)}
                className="h-8 rounded px-3 text-sm font-semibold text-slate-700 transition hover:bg-slate-100"
              >
                Reset
              </button>
            </div>
            <button
              type="button"
              onClick={onBackToLibrary}
              className="inline-flex h-10 items-center justify-center rounded-md border border-slate-300 bg-white px-4 text-sm font-medium text-slate-700 shadow-sm transition hover:border-slate-400 hover:bg-slate-100 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
            >
              Back to Library
            </button>
          </div>
        </header>

        <section
          className={`grid flex-1 gap-4 ${
            readingMode === 'intensive'
              ? 'lg:grid-cols-[400px_minmax(0,1fr)]'
              : 'lg:grid-cols-[minmax(0,1fr)_320px]'
          }`}
        >
          {readingMode === 'intensive' ? (
            <SentenceDetail
              sentence={selectedSentence}
              onSelectWord={handleSelectWord}
              selectedWord={selectedWord}
              favoriteStatus={favoriteStatus}
              onFavoriteSentence={handleFavoriteSentence}
              onReanalyzeSentence={handleReanalyzeSentence}
              onSaveSentenceNotes={handleSaveSentenceNotes}
              onAddVocabulary={handleAddVocabulary}
              isSystemDocument={isSystemDocument}
              showWordExplanation
              vocabularyStatus={vocabularyStatus}
            />
          ) : null}
          <ContinuousText
            paragraphs={document.paragraphs}
            sentences={document.sentences}
            selectedIndex={selectedSentenceIndex}
            selectedWord={selectedWord}
            fontSize={articleFontSize}
            onSelectSentence={handleSelectSentence}
            onSelectWord={handleSelectWord}
          />
          {readingMode === 'extensive' ? (
            <WordPanel
              word={selectedWord}
              vocabularyStatus={vocabularyStatus}
              onAddVocabulary={handleAddVocabulary}
            />
          ) : null}
        </section>
      </div>
    </main>
  );
}

export default ReaderPage;
