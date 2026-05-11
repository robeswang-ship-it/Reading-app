import { useEffect, useRef } from 'react';
import type { Sentence } from '../types';

type SentenceListProps = {
  sentences: Sentence[];
  selectedIndex: number;
  onSelectSentence: (index: number) => void;
};

function SentenceList({
  sentences,
  selectedIndex,
  onSelectSentence,
}: SentenceListProps) {
  const selectedItemRef = useRef<HTMLLIElement | null>(null);

  useEffect(() => {
    selectedItemRef.current?.scrollIntoView({
      block: 'nearest',
      behavior: 'smooth',
    });
  }, [selectedIndex]);

  return (
    <aside className="min-h-64 rounded-lg border border-slate-200 bg-white shadow-sm lg:h-[calc(100vh-132px)]">
      <div className="border-b border-slate-200 px-4 py-3">
        <h2 className="text-sm font-semibold text-slate-900">Sentences</h2>
        <p className="mt-1 text-xs text-slate-500">
          {sentences.length} total
        </p>
      </div>
      <div className="max-h-80 overflow-y-auto p-2 lg:max-h-[calc(100vh-205px)]">
        <ol className="space-y-2">
          {sentences.map((sentence, index) => {
            const isSelected = index === selectedIndex;

            return (
              <li
                key={sentence.id}
                ref={isSelected ? selectedItemRef : null}
              >
                <button
                  type="button"
                  onClick={() => onSelectSentence(index)}
                  className={`w-full rounded-md border px-3 py-3 text-left text-sm leading-6 transition focus:outline-none focus:ring-2 focus:ring-cyan-500 ${
                    isSelected
                      ? 'border-cyan-600 bg-cyan-100 text-cyan-950 shadow-md ring-2 ring-cyan-200'
                      : 'border-transparent text-slate-700 hover:border-slate-200 hover:bg-slate-50'
                  }`}
                  aria-current={isSelected ? 'true' : undefined}
                >
                  <span className="mb-1 block text-xs font-semibold text-slate-400">
                    {index + 1}
                  </span>
                  {sentence.text}
                </button>
              </li>
            );
          })}
        </ol>
      </div>
    </aside>
  );
}

export default SentenceList;
