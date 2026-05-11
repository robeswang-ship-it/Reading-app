import { useMemo, useState } from 'react';
import type { VocabularyItem } from '../types';
import {
  deleteVocabularyItem,
  getVocabularyItems,
  updateVocabularyDetails,
} from '../utils/storage';

type VocabularyPageProps = {
  onBackToLibrary: () => void;
};

function formatDate(value: string) {
  return new Intl.DateTimeFormat(undefined, {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
  }).format(new Date(value));
}

function VocabularyPage({ onBackToLibrary }: VocabularyPageProps) {
  const [items, setItems] = useState<VocabularyItem[]>(() =>
    getVocabularyItems(),
  );
  const [searchQuery, setSearchQuery] = useState('');

  const filteredItems = useMemo(() => {
    const normalizedQuery = searchQuery.trim().toLowerCase();

    if (!normalizedQuery) {
      return items;
    }

    return items.filter(
      (item) =>
        item.word.toLowerCase().includes(normalizedQuery) ||
        item.documentTitle.toLowerCase().includes(normalizedQuery),
    );
  }, [items, searchQuery]);

  const refreshItems = () => {
    setItems(getVocabularyItems());
  };

  const handleUpdateDetails = (
    id: string,
    fields: {
      meaning?: string;
      phonetic?: string;
      example?: string;
      note?: string;
    },
  ) => {
    updateVocabularyDetails(id, fields);
    refreshItems();
  };

  const handleDelete = (id: string) => {
    deleteVocabularyItem(id);
    refreshItems();
  };

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
          <button
            type="button"
            onClick={onBackToLibrary}
            className="inline-flex h-10 items-center justify-center rounded-md border border-slate-300 bg-white px-4 text-sm font-semibold text-slate-700 shadow-sm transition hover:bg-slate-100 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
          >
            Back to Library
          </button>
        </header>

        <div className="mt-5 rounded-lg border border-slate-200 bg-white p-4 shadow-sm">
          <input
            type="search"
            value={searchQuery}
            onChange={(event) => setSearchQuery(event.target.value)}
            className="h-10 w-full rounded-md border border-slate-300 bg-white px-3 text-sm outline-none transition placeholder:text-slate-400 focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100 md:max-w-md"
            placeholder="Search word or document"
          />
        </div>

        <section className="mt-4">
          {filteredItems.length > 0 ? (
            <ul className="space-y-3">
              {filteredItems.map((item) => (
                <li
                  key={item.id}
                  className="rounded-lg border border-slate-200 bg-white p-4 shadow-sm"
                >
                  <div className="flex flex-col gap-3 md:flex-row md:items-start md:justify-between">
                    <div className="min-w-0">
                      <h2 className="text-2xl font-semibold text-slate-950">
                        {item.word}
                      </h2>
                      <p className="mt-1 text-sm text-slate-500">
                        {item.documentTitle} · {formatDate(item.createdAt)}
                      </p>
                      <p className="mt-3 text-sm leading-6 text-slate-700">
                        {item.sentenceText}
                      </p>
                    </div>
                    <button
                      type="button"
                      onClick={() => handleDelete(item.id)}
                      className="inline-flex h-9 items-center justify-center rounded-md border border-rose-200 bg-white px-3 text-sm font-semibold text-rose-700 shadow-sm transition hover:bg-rose-50 focus:outline-none focus:ring-2 focus:ring-rose-500 focus:ring-offset-2"
                    >
                      Delete
                    </button>
                  </div>
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
                </li>
              ))}
            </ul>
          ) : (
            <div className="border-l-4 border-cyan-700 bg-white p-5 shadow-sm">
              <h2 className="text-lg font-semibold text-slate-950">
                No vocabulary items found
              </h2>
              <p className="mt-2 text-sm leading-6 text-slate-600">
                Add words from the reader word panel.
              </p>
            </div>
          )}
        </section>
      </div>
    </main>
  );
}

export default VocabularyPage;
