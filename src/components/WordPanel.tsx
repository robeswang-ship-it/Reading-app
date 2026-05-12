import { useEffect, useState } from 'react';
import { lookupWord } from '../services/aiService';
import type { VocabularyItem } from '../types';

type WordPanelProps = {
  word: string | null;
  vocabularyStatus?: string;
  embedded?: boolean;
  onAddVocabulary: (
    details: Partial<
      Pick<VocabularyItem, 'meaning' | 'phonetic' | 'example' | 'note'>
    >,
  ) => void;
};

function pronounce(word: string) {
  if (!('speechSynthesis' in window)) {
    return;
  }

  window.speechSynthesis.cancel();

  const utterance = new SpeechSynthesisUtterance(word);
  utterance.lang = 'en-US';
  utterance.rate = 0.9;
  window.speechSynthesis.speak(utterance);
}

function WordPanel({
  word,
  vocabularyStatus,
  embedded = false,
  onAddVocabulary,
}: WordPanelProps) {
  const [note, setNote] = useState('');
  const [meaning, setMeaning] = useState('');
  const [phonetic, setPhonetic] = useState('');
  const [example, setExample] = useState('');
  const [aiStatus, setAiStatus] = useState('');

  useEffect(() => {
    setNote('');
    setMeaning('');
    setPhonetic('');
    setExample('');
    setAiStatus('');
  }, [word]);

  const handleAddVocabulary = () => {
    onAddVocabulary({ meaning, phonetic, example, note });
    setNote('');
  };

  const handleAiExplain = async () => {
    if (!word) {
      return;
    }

    if (meaning.trim()) {
      setAiStatus('Meaning already exists. Skipped.');
      return;
    }

    setAiStatus('Looking up...');
    const result = await lookupWord(word);
    setMeaning((currentMeaning) => currentMeaning || result.meaning);
    setPhonetic((currentPhonetic) => currentPhonetic || result.phonetic);
    setExample((currentExample) => currentExample || result.example);
    setAiStatus('AI explanation ready.');
  };

  const content = (
    <>
        {word ? (
          <div className="space-y-5">
            <div>
              <p className="text-xs font-semibold uppercase text-slate-500">
                Selected word
              </p>
              <p className="mt-2 break-words text-3xl font-semibold text-slate-950">
                {word}
              </p>
            </div>

            <div className="border-t border-slate-200 pt-4">
              <label
                htmlFor="word-meaning"
                className="text-xs font-semibold uppercase text-slate-500"
              >
                Meaning
              </label>
              <textarea
                id="word-meaning"
                value={meaning}
                onChange={(event) => setMeaning(event.target.value)}
                rows={3}
                className="mt-2 w-full resize-y rounded-md border border-slate-300 bg-white px-3 py-2 text-sm leading-6 outline-none transition focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
                placeholder={`Add meaning for "${word}"...`}
              />
            </div>

            <div className="border-t border-slate-200 pt-4">
              <label
                htmlFor="word-phonetic"
                className="text-xs font-semibold uppercase text-slate-500"
              >
                Phonetic
              </label>
              <input
                id="word-phonetic"
                value={phonetic}
                onChange={(event) => setPhonetic(event.target.value)}
                className="mt-2 h-10 w-full rounded-md border border-slate-300 bg-white px-3 text-sm outline-none transition focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
                placeholder="/.../"
              />
            </div>

            <div className="border-t border-slate-200 pt-4">
              <label
                htmlFor="word-example"
                className="text-xs font-semibold uppercase text-slate-500"
              >
                Example
              </label>
              <textarea
                id="word-example"
                value={example}
                onChange={(event) => setExample(event.target.value)}
                rows={3}
                className="mt-2 w-full resize-y rounded-md border border-slate-300 bg-white px-3 py-2 text-sm leading-6 outline-none transition focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
                placeholder="Add example usage..."
              />
            </div>

            <button
              type="button"
              onClick={() => pronounce(word)}
              className="inline-flex h-11 w-full items-center justify-center rounded-md bg-slate-900 px-4 text-sm font-semibold text-white shadow-sm transition hover:bg-slate-800 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
            >
              🔊 Pronounce
            </button>
            <button
              type="button"
              onClick={handleAiExplain}
              className="inline-flex h-11 w-full items-center justify-center rounded-md border border-amber-200 bg-white px-4 text-sm font-semibold text-amber-700 shadow-sm transition hover:bg-amber-50 focus:outline-none focus:ring-2 focus:ring-amber-500 focus:ring-offset-2"
            >
              AI Explain
            </button>
            {aiStatus ? (
              <p className="text-sm font-medium text-slate-600">{aiStatus}</p>
            ) : null}
            <div className="border-t border-slate-200 pt-4">
              <label
                htmlFor="vocabulary-note"
                className="text-xs font-semibold uppercase text-slate-500"
              >
                Optional note
              </label>
              <textarea
                id="vocabulary-note"
                value={note}
                onChange={(event) => setNote(event.target.value)}
                rows={2}
                className="mt-2 w-full resize-y rounded-md border border-slate-300 bg-white px-3 py-2 text-sm leading-6 outline-none transition focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
                placeholder="Add a quick note..."
              />
            </div>
            <button
              type="button"
              onClick={handleAddVocabulary}
              className="inline-flex h-11 w-full items-center justify-center rounded-md border border-cyan-200 bg-white px-4 text-sm font-semibold text-cyan-700 shadow-sm transition hover:bg-cyan-50 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
            >
              Add to Vocabulary
            </button>
            {vocabularyStatus ? (
              <p className="text-sm font-medium text-emerald-700">
                {vocabularyStatus}
              </p>
            ) : null}
          </div>
        ) : (
          <div className="border-l-4 border-slate-200 bg-slate-50 p-4 text-sm leading-6 text-slate-600">
            Click a word in the article to view its explanation.
          </div>
        )}
    </>
  );

  if (embedded) {
    return (
      <section className="border-t border-slate-200 pt-5">
        <h3 className="text-xs font-semibold uppercase text-slate-500">
          Word explanation
        </h3>
        <div className="mt-3">{content}</div>
      </section>
    );
  }

  return (
    <aside className="min-w-0 rounded-lg border border-slate-200 bg-white shadow-sm lg:sticky lg:top-36 lg:max-h-[calc(100vh-10rem)] lg:overflow-y-auto">
      <div className="border-b border-slate-200 px-5 py-4">
        <h2 className="text-sm font-semibold text-slate-900">Word panel</h2>
      </div>

      <div className="p-5">{content}</div>
    </aside>
  );
}

export default WordPanel;
