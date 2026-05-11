import { useEffect, useState } from 'react';
import type { Sentence, VocabularyItem } from '../types';
import WordPanel from './WordPanel';

type SentenceDetailProps = {
  sentence: Sentence | null;
  selectedWord: string | null;
  favoriteStatus?: string;
  onFavoriteSentence: () => void;
  onReanalyzeSentence: () => void;
  onSaveSentenceNotes: (
    fields: Pick<Sentence, 'translation' | 'grammar' | 'userNote'>,
  ) => void;
  onAddVocabulary?: (
    details: Partial<
      Pick<VocabularyItem, 'meaning' | 'phonetic' | 'example' | 'note'>
    >,
  ) => void;
  onSelectWord: (word: string) => void;
  showWordExplanation?: boolean;
  vocabularyStatus?: string;
};

function normalizeWord(word: string) {
  return word.replace(/^[^\w']+|[^\w']+$/g, '');
}

function SentenceDetail({
  sentence,
  selectedWord,
  favoriteStatus,
  onFavoriteSentence,
  onReanalyzeSentence,
  onSaveSentenceNotes,
  onAddVocabulary,
  onSelectWord,
  showWordExplanation = false,
  vocabularyStatus,
}: SentenceDetailProps) {
  const sentenceText = sentence?.text ?? '';
  const words = sentenceText.split(/\s+/).filter(Boolean);
  const [translation, setTranslation] = useState('');
  const [grammar, setGrammar] = useState('');
  const [userNote, setUserNote] = useState('');
  const [saveStatus, setSaveStatus] = useState('');

  useEffect(() => {
    setTranslation(sentence?.translation ?? '');
    setGrammar(sentence?.grammar ?? '');
    setUserNote(sentence?.userNote ?? '');
    setSaveStatus('');
  }, [sentence?.id, sentence?.grammar, sentence?.translation, sentence?.userNote]);

  const handleSaveNotes = () => {
    onSaveSentenceNotes({ translation, grammar, userNote });
    setSaveStatus('Saved.');
  };

  return (
    <article className="min-w-0 rounded-lg border border-slate-200 bg-white shadow-sm lg:max-h-[calc(100vh-150px)] lg:overflow-y-auto">
      <div className="border-b border-slate-200 px-5 py-4">
        <div className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
          <h2 className="text-sm font-semibold text-slate-900">
            Sentence detail
          </h2>
          <div className="flex flex-col gap-2 sm:flex-row sm:items-center">
            {favoriteStatus ? (
              <p className="text-sm font-medium text-emerald-700">
                {favoriteStatus}
              </p>
            ) : null}
            <button
              type="button"
              onClick={onFavoriteSentence}
              disabled={!sentence}
              className="inline-flex h-9 items-center justify-center rounded-md border border-amber-200 bg-white px-3 text-sm font-semibold text-amber-700 shadow-sm transition hover:bg-amber-50 disabled:cursor-not-allowed disabled:opacity-50 focus:outline-none focus:ring-2 focus:ring-amber-500 focus:ring-offset-2"
            >
              Favorite Sentence
            </button>
            <button
              type="button"
              onClick={onReanalyzeSentence}
              disabled={!sentence || sentence.aiStatus === 'loading'}
              className="inline-flex h-9 items-center justify-center rounded-md border border-cyan-200 bg-white px-3 text-sm font-semibold text-cyan-700 shadow-sm transition hover:bg-cyan-50 disabled:cursor-not-allowed disabled:opacity-50 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
            >
              Re-analyze
            </button>
          </div>
        </div>
      </div>

      <div className="space-y-6 p-5 sm:p-6">
        {sentence?.aiStatus === 'loading' ? (
          <div className="border-l-4 border-cyan-600 bg-cyan-50 p-3 text-sm font-medium text-cyan-900">
            Analyzing...
          </div>
        ) : null}
        {sentence?.aiStatus === 'error' ? (
          <div className="border-l-4 border-rose-600 bg-rose-50 p-3 text-sm font-medium text-rose-800">
            Analysis failed. You can edit manually or try Re-analyze.
          </div>
        ) : null}
        {sentence?.aiStatus === 'done' ? (
          <div className="border-l-4 border-emerald-600 bg-emerald-50 p-3 text-sm font-medium text-emerald-800">
            AI analysis ready.
          </div>
        ) : null}

        <section>
          <h3 className="text-xs font-semibold uppercase text-slate-500">
            English
          </h3>
          <p className="mt-3 text-2xl font-semibold leading-10 text-slate-950">
            {words.map((word, index) => {
              const normalizedWord = normalizeWord(word);
              const isSelected =
                selectedWord?.toLowerCase() === normalizedWord.toLowerCase();

              return (
                <button
                  key={`${word}-${index}`}
                  type="button"
                  onClick={() => onSelectWord(normalizedWord)}
                  className={`mx-0.5 rounded px-1.5 py-0.5 text-left transition focus:outline-none focus:ring-2 focus:ring-cyan-500 ${
                    isSelected
                      ? 'bg-amber-100 text-amber-950'
                      : 'hover:bg-cyan-50 hover:text-cyan-900'
                  }`}
                >
                  {word}
                </button>
              );
            })}
          </p>
        </section>

        <section className="border-t border-slate-200 pt-5">
          <h3 className="text-xs font-semibold uppercase text-slate-500">
            Chinese translation
          </h3>
          <textarea
            value={translation}
            onChange={(event) => setTranslation(event.target.value)}
            rows={3}
            className="mt-2 w-full resize-y rounded-md border border-slate-300 bg-white px-3 py-2 text-sm leading-6 outline-none transition focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
            placeholder="Add Chinese translation..."
          />
        </section>

        <section className="border-t border-slate-200 pt-5">
          <h3 className="text-xs font-semibold uppercase text-slate-500">
            Grammar explanation
          </h3>
          <textarea
            value={grammar}
            onChange={(event) => setGrammar(event.target.value)}
            rows={4}
            className="mt-2 w-full resize-y rounded-md border border-slate-300 bg-white px-3 py-2 text-sm leading-6 outline-none transition focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
            placeholder="Add grammar explanation..."
          />
        </section>

        <section className="border-t border-slate-200 pt-5">
          <h3 className="text-xs font-semibold uppercase text-slate-500">
            Personal note
          </h3>
          <textarea
            value={userNote}
            onChange={(event) => setUserNote(event.target.value)}
            rows={3}
            className="mt-2 w-full resize-y rounded-md border border-slate-300 bg-white px-3 py-2 text-sm leading-6 outline-none transition focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
            placeholder="Add your own reading note..."
          />
        </section>

        <div className="flex flex-col gap-2 border-t border-slate-200 pt-5 sm:flex-row sm:items-center">
          <button
            type="button"
            onClick={handleSaveNotes}
            disabled={!sentence}
            className="inline-flex h-10 items-center justify-center rounded-md bg-cyan-700 px-4 text-sm font-semibold text-white shadow-sm transition hover:bg-cyan-800 disabled:cursor-not-allowed disabled:opacity-50 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
          >
            Save Notes
          </button>
          {saveStatus ? (
            <p className="text-sm font-medium text-emerald-700">
              {saveStatus}
            </p>
          ) : null}
        </div>

        {showWordExplanation && onAddVocabulary ? (
          <WordPanel
            embedded
            word={selectedWord}
            vocabularyStatus={vocabularyStatus}
            onAddVocabulary={onAddVocabulary}
          />
        ) : null}
      </div>
    </article>
  );
}

export default SentenceDetail;
