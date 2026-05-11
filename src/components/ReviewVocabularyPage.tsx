import { useMemo, useState } from 'react';
import type { VocabularyItem } from '../types';
import {
  getVocabularyReviewQueue,
  reviewVocabularyItem,
} from '../utils/storage';

type ReviewVocabularyPageProps = {
  onBackToLibrary: () => void;
};

function getMeaning(item: VocabularyItem) {
  return item.meaning?.trim() || item.note?.trim() || item.sentenceText;
}

function ReviewVocabularyPage({
  onBackToLibrary,
}: ReviewVocabularyPageProps) {
  const [queue, setQueue] = useState<VocabularyItem[]>(() =>
    getVocabularyReviewQueue(),
  );
  const [currentIndex, setCurrentIndex] = useState(0);
  const [isMeaningVisible, setIsMeaningVisible] = useState(false);

  const currentItem = queue[currentIndex] ?? null;
  const progressText = useMemo(
    () =>
      queue.length > 0
        ? `${Math.min(currentIndex + 1, queue.length)} / ${queue.length}`
        : '0 / 0',
    [currentIndex, queue.length],
  );

  const moveNext = () => {
    setIsMeaningVisible(false);
    setCurrentIndex((index) => Math.min(index + 1, queue.length));
  };

  const handleReview = (remembered: boolean) => {
    if (!currentItem) {
      return;
    }

    reviewVocabularyItem(currentItem.id, remembered);
    setQueue(getVocabularyReviewQueue());
    moveNext();
  };

  return (
    <main className="min-h-screen bg-slate-50 text-slate-950">
      <div className="mx-auto flex min-h-screen w-full max-w-3xl flex-col px-4 py-8 sm:px-6 lg:px-8">
        <header className="flex items-center justify-between border-b border-slate-200 pb-5">
          <div>
            <p className="text-sm font-medium text-cyan-700">Review</p>
            <h1 className="mt-1 text-3xl font-semibold text-slate-950">
              Vocabulary
            </h1>
          </div>
          <button
            type="button"
            onClick={onBackToLibrary}
            className="inline-flex h-10 items-center justify-center rounded-md border border-slate-300 bg-white px-4 text-sm font-semibold text-slate-700 shadow-sm transition hover:bg-slate-100 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
          >
            Back
          </button>
        </header>

        <section className="flex flex-1 items-center py-8">
          {currentItem ? (
            <div className="w-full rounded-lg border border-slate-200 bg-white p-6 text-center shadow-sm sm:p-8">
              <p className="text-sm font-medium text-slate-500">
                {progressText} · Familiarity {currentItem.familiarity}/5 ·
                Reviewed {currentItem.reviewCount} times
              </p>
              <h2 className="mt-8 break-words text-5xl font-semibold text-slate-950">
                {currentItem.word}
              </h2>
              <p className="mt-4 text-sm text-slate-500">
                {currentItem.documentTitle}
              </p>

              <div className="mt-8 min-h-32 border-t border-slate-200 pt-6">
                {isMeaningVisible ? (
                  <p className="text-xl leading-9 text-slate-800">
                    {getMeaning(currentItem)}
                  </p>
                ) : (
                  <p className="text-base text-slate-500">Meaning hidden</p>
                )}
              </div>

              <div className="mt-8 flex flex-col gap-3 sm:flex-row sm:justify-center">
                <button
                  type="button"
                  onClick={() => setIsMeaningVisible(true)}
                  className="inline-flex h-11 items-center justify-center rounded-md border border-slate-300 bg-white px-5 text-sm font-semibold text-slate-700 shadow-sm transition hover:bg-slate-100 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
                >
                  Show Meaning
                </button>
                <button
                  type="button"
                  onClick={() => handleReview(true)}
                  className="inline-flex h-11 items-center justify-center rounded-md bg-emerald-700 px-5 text-sm font-semibold text-white shadow-sm transition hover:bg-emerald-800 focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:ring-offset-2"
                >
                  I Know
                </button>
                <button
                  type="button"
                  onClick={() => handleReview(false)}
                  className="inline-flex h-11 items-center justify-center rounded-md bg-rose-700 px-5 text-sm font-semibold text-white shadow-sm transition hover:bg-rose-800 focus:outline-none focus:ring-2 focus:ring-rose-500 focus:ring-offset-2"
                >
                  I Don't Know
                </button>
              </div>
            </div>
          ) : (
            <div className="w-full border-l-4 border-cyan-700 bg-white p-5 shadow-sm">
              <h2 className="text-lg font-semibold text-slate-950">
                No vocabulary to review
              </h2>
              <p className="mt-2 text-sm leading-6 text-slate-600">
                Add words from the reader, then come back for a focused review
                loop.
              </p>
            </div>
          )}
        </section>
      </div>
    </main>
  );
}

export default ReviewVocabularyPage;
