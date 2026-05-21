import { useEffect, useRef, useState } from 'react';
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
  const panelRef = useRef<HTMLElement | null>(null);
  const wordExplanationRef = useRef<HTMLElement | null>(null);

  useEffect(() => {
    setTranslation(sentence?.translation ?? '');
    setGrammar(sentence?.grammar ?? '');
    setUserNote(sentence?.userNote ?? '');
    setSaveStatus('');
  }, [sentence?.id, sentence?.grammar, sentence?.translation, sentence?.userNote]);

  useEffect(() => {
    if (!selectedWord || !showWordExplanation) {
      return;
    }

    const panel = panelRef.current;
    const wordExplanation = wordExplanationRef.current;

    if (!panel || !wordExplanation) {
      return;
    }

    panel.scrollTo({
      top: wordExplanation.offsetTop - 18,
      behavior: 'smooth',
    });
  }, [selectedWord, showWordExplanation]);

  const handleSaveNotes = () => {
    onSaveSentenceNotes({ translation, grammar, userNote });
    setSaveStatus('Saved.');
  };

  return (
    <article
      ref={panelRef}
      className="min-w-0 rounded-lg border border-slate-200 bg-white shadow-sm lg:sticky lg:top-36 lg:max-h-[calc(100vh-10rem)] lg:overflow-y-auto"
    >
      <div className="border-b border-slate-200 px-5 py-4">
        <div className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
          <h2 className="text-sm font-semibold text-slate-900">
            Sentence detail
          </h2>
          <div className="flex flex-wrap items-center gap-2">
            {favoriteStatus ? (
              <p className="text-sm font-medium text-emerald-700">
                {favoriteStatus}
              </p>
            ) : null}
            <button
              type="button"
              onClick={onFavoriteSentence}
              disabled={!sentence}
              className="inline-flex h-8 shrink-0 items-center justify-center whitespace-nowrap rounded-full border border-amber-200 bg-amber-50 px-3 text-xs font-semibold text-amber-800 transition hover:border-amber-300 hover:bg-amber-100 disabled:cursor-not-allowed disabled:opacity-50 focus:outline-none focus:ring-2 focus:ring-amber-500 focus:ring-offset-2"
            >
              Favorite Sentence
            </button>
            <button
              type="button"
              onClick={onReanalyzeSentence}
              disabled={!sentence || sentence.aiStatus === 'loading'}
              className="inline-flex h-8 shrink-0 items-center justify-center whitespace-nowrap rounded-full border border-cyan-200 bg-cyan-50 px-3 text-xs font-semibold text-cyan-800 transition hover:border-cyan-300 hover:bg-cyan-100 disabled:cursor-not-allowed disabled:opacity-50 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
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
                  onClick={() => {
                    if (normalizedWord) {
                      onSelectWord(normalizedWord);
                    }
                  }}
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
          <div className="mt-3 max-h-72 min-h-40 overflow-y-auto rounded-lg border border-slate-200 bg-slate-50 px-4 py-4">
            <textarea
              value={grammar}
              onChange={(event) => setGrammar(event.target.value)}
              rows={7}
              className="min-h-36 w-full resize-none border-0 bg-transparent p-0 text-[15px] leading-7 text-slate-800 outline-none placeholder:text-slate-400"
              placeholder="Add grammar explanation..."
            />
          </div>
        </section>

        <section className="border-t border-slate-200 pt-5">
          <h3 className="text-xs font-semibold uppercase text-slate-500">
            Key phrases
          </h3>
          {sentence?.keyPhrases?.length ? (
            <div className="mt-3 space-y-2">
              {sentence.keyPhrases.map((item, index) => (
                <div
                  key={`${item.phrase}-${index}`}
                  className="rounded-lg border border-slate-200 bg-white px-3 py-3"
                >
                  <p className="text-sm font-semibold text-slate-950">
                    {item.phrase}
                  </p>
                  <p className="mt-1 text-sm leading-6 text-slate-600">
                    {item.explanation}
                  </p>
                </div>
              ))}
            </div>
          ) : (
            <p className="mt-3 text-sm leading-6 text-slate-500">
              Key phrases will appear after AI analysis.
            </p>
          )}
        </section>

        <section className="border-t border-slate-200 pt-5">
          <h3 className="text-xs font-semibold uppercase text-slate-500">
            Advanced vocabulary
          </h3>
          {sentence?.advancedVocabulary?.length ? (
            <div className="mt-3 space-y-2">
              {sentence.advancedVocabulary.map((item, index) => (
                <div
                  key={`${item.word}-${index}`}
                  className="rounded-lg border border-slate-200 bg-white px-3 py-3"
                >
                  <div className="flex flex-wrap items-baseline gap-x-2 gap-y-1">
                    <p className="text-sm font-semibold text-slate-950">
                      {item.word}
                    </p>
                    <p className="text-sm font-medium text-cyan-800">
                      {item.meaning}
                    </p>
                  </div>
                  <p className="mt-1 text-sm leading-6 text-slate-600">
                    {item.explanation}
                  </p>
                </div>
              ))}
            </div>
          ) : (
            <p className="mt-3 text-sm leading-6 text-slate-500">
              Advanced vocabulary will appear after AI analysis.
            </p>
          )}
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
          <section ref={wordExplanationRef}>
            <WordPanel
              embedded
              word={selectedWord}
              vocabularyStatus={vocabularyStatus}
              onAddVocabulary={onAddVocabulary}
            />
          </section>
        ) : null}
      </div>
    </article>
  );
}

export default SentenceDetail;
