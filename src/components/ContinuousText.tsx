import { useEffect, useRef } from 'react';
import type { Sentence } from '../types';

type ContinuousTextProps = {
  sentences: Sentence[];
  selectedIndex: number;
  selectedWord: string | null;
  fontSize?: number;
  onSelectSentence: (index: number) => void;
  onSelectWord: (word: string) => void;
};

function normalizeWord(word: string) {
  return word.replace(/^[^\w']+|[^\w']+$/g, '');
}

function ContinuousText({
  sentences,
  selectedIndex,
  selectedWord,
  fontSize = 21,
  onSelectSentence,
  onSelectWord,
}: ContinuousTextProps) {
  const selectedSentenceRef = useRef<HTMLSpanElement | null>(null);

  useEffect(() => {
    selectedSentenceRef.current?.scrollIntoView({
      block: 'center',
      behavior: 'smooth',
    });
  }, [selectedIndex]);

  return (
    <article className="min-w-0 rounded-lg border border-slate-200 bg-white shadow-sm">
      <div className="mx-auto max-w-3xl px-5 py-6 sm:px-8 sm:py-8">
        <div
          className="text-slate-900"
          style={{
            fontSize,
            lineHeight: 1.75,
          }}
        >
          {sentences.map((sentence, sentenceIndex) => {
            const isSelected = sentenceIndex === selectedIndex;
            const words = sentence.text.split(/(\s+)/);

            return (
              <span
                key={sentence.id}
                ref={isSelected ? selectedSentenceRef : null}
                onClick={() => onSelectSentence(sentenceIndex)}
                className={`rounded px-1 py-0.5 transition ${
                  isSelected ? 'bg-slate-200/80' : 'hover:bg-slate-100'
                }`}
              >
                {words.map((part, wordIndex) => {
                  if (/^\s+$/.test(part)) {
                    return part;
                  }

                  const normalizedWord = normalizeWord(part);
                  const isWordSelected =
                    selectedWord?.toLowerCase() ===
                    normalizedWord.toLowerCase();

                  return (
                    <button
                      key={`${sentence.id}-${part}-${wordIndex}`}
                      type="button"
                      onClick={(event) => {
                        event.stopPropagation();
                        onSelectSentence(sentenceIndex);
                        if (normalizedWord) {
                          onSelectWord(normalizedWord);
                        }
                      }}
                      className={`inline rounded px-0.5 text-left transition focus:outline-none focus:ring-2 focus:ring-slate-400 ${
                        isWordSelected
                          ? 'bg-amber-100 text-amber-950'
                          : 'hover:bg-slate-100'
                      }`}
                    >
                      {part}
                    </button>
                  );
                })}{' '}
              </span>
            );
          })}
        </div>
      </div>
    </article>
  );
}

export default ContinuousText;
