import { useState } from 'react';
import type { FavoriteSentence } from '../types';
import { getFavoriteSentences } from '../utils/storage';

type ReviewSentencesPageProps = {
  onBackToLibrary: () => void;
};

type ReviewMode = 'en-cn' | 'cn-en';

function getTranslationPlaceholder(item: FavoriteSentence) {
  return item.note?.trim() || '中文翻译占位：这里将显示收藏句子的中文释义。';
}

function ReviewSentencesPage({
  onBackToLibrary,
}: ReviewSentencesPageProps) {
  const [items] = useState<FavoriteSentence[]>(() => getFavoriteSentences());
  const [currentIndex, setCurrentIndex] = useState(0);
  const [mode, setMode] = useState<ReviewMode>('en-cn');
  const [isAnswerVisible, setIsAnswerVisible] = useState(false);

  const currentItem = items[currentIndex] ?? null;

  const handleNext = () => {
    setIsAnswerVisible(false);
    setCurrentIndex((index) => (items.length === 0 ? 0 : (index + 1) % items.length));
  };

  return (
    <main className="min-h-screen bg-slate-50 text-slate-950">
      <div className="mx-auto flex min-h-screen w-full max-w-3xl flex-col px-4 py-8 sm:px-6 lg:px-8">
        <header className="flex flex-col gap-4 border-b border-slate-200 pb-5 sm:flex-row sm:items-end sm:justify-between">
          <div>
            <p className="text-sm font-medium text-cyan-700">Review</p>
            <h1 className="mt-1 text-3xl font-semibold text-slate-950">
              Sentences
            </h1>
          </div>
          <div className="flex flex-col gap-2 sm:flex-row">
            <select
              value={mode}
              onChange={(event) => {
                setMode(event.target.value as ReviewMode);
                setIsAnswerVisible(false);
              }}
              className="h-10 rounded-md border border-slate-300 bg-white px-3 text-sm text-slate-700 outline-none transition focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
            >
              <option value="en-cn">EN → CN</option>
              <option value="cn-en">CN → EN</option>
            </select>
            <button
              type="button"
              onClick={onBackToLibrary}
              className="inline-flex h-10 items-center justify-center rounded-md border border-slate-300 bg-white px-4 text-sm font-semibold text-slate-700 shadow-sm transition hover:bg-slate-100 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
            >
              Back
            </button>
          </div>
        </header>

        <section className="flex flex-1 items-center py-8">
          {currentItem ? (
            <div className="w-full rounded-lg border border-slate-200 bg-white p-6 text-center shadow-sm sm:p-8">
              <p className="text-sm font-medium text-slate-500">
                {currentIndex + 1} / {items.length} · {currentItem.documentTitle}
              </p>

              <div className="mt-8 min-h-48">
                <p className="text-3xl font-semibold leading-10 text-slate-950">
                  {mode === 'en-cn'
                    ? currentItem.sentenceText
                    : getTranslationPlaceholder(currentItem)}
                </p>

                <div className="mt-8 border-t border-slate-200 pt-6">
                  {isAnswerVisible ? (
                    <p className="text-xl leading-9 text-slate-800">
                      {mode === 'en-cn'
                        ? getTranslationPlaceholder(currentItem)
                        : currentItem.sentenceText}
                    </p>
                  ) : (
                    <p className="text-base text-slate-500">Answer hidden</p>
                  )}
                </div>
              </div>

              <div className="mt-8 flex flex-col gap-3 sm:flex-row sm:justify-center">
                <button
                  type="button"
                  onClick={() => setIsAnswerVisible(true)}
                  className="inline-flex h-11 items-center justify-center rounded-md border border-slate-300 bg-white px-5 text-sm font-semibold text-slate-700 shadow-sm transition hover:bg-slate-100 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
                >
                  Show Answer
                </button>
                <button
                  type="button"
                  onClick={handleNext}
                  className="inline-flex h-11 items-center justify-center rounded-md bg-cyan-700 px-5 text-sm font-semibold text-white shadow-sm transition hover:bg-cyan-800 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
                >
                  Next
                </button>
              </div>
            </div>
          ) : (
            <div className="w-full border-l-4 border-cyan-700 bg-white p-5 shadow-sm">
              <h2 className="text-lg font-semibold text-slate-950">
                No favorite sentences to review
              </h2>
              <p className="mt-2 text-sm leading-6 text-slate-600">
                Favorite sentences in the reader to build a sentence review
                queue.
              </p>
            </div>
          )}
        </section>
      </div>
    </main>
  );
}

export default ReviewSentencesPage;
