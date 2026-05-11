import { useMemo, useState } from 'react';
import type { FavoriteSentence } from '../types';
import {
  deleteFavoriteSentence,
  getFavoriteSentences,
  updateFavoriteNote,
} from '../utils/storage';

type FavoritesPageProps = {
  onBackToLibrary: () => void;
};

function formatDate(value: string) {
  return new Intl.DateTimeFormat(undefined, {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
  }).format(new Date(value));
}

function FavoritesPage({ onBackToLibrary }: FavoritesPageProps) {
  const [items, setItems] = useState<FavoriteSentence[]>(() =>
    getFavoriteSentences(),
  );
  const [searchQuery, setSearchQuery] = useState('');

  const filteredItems = useMemo(() => {
    const normalizedQuery = searchQuery.trim().toLowerCase();

    if (!normalizedQuery) {
      return items;
    }

    return items.filter(
      (item) =>
        item.sentenceText.toLowerCase().includes(normalizedQuery) ||
        item.documentTitle.toLowerCase().includes(normalizedQuery),
    );
  }, [items, searchQuery]);

  const refreshItems = () => {
    setItems(getFavoriteSentences());
  };

  const handleUpdateNote = (id: string, note: string) => {
    updateFavoriteNote(id, note);
    refreshItems();
  };

  const handleDelete = (id: string) => {
    deleteFavoriteSentence(id);
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
              Favorite Sentences
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
            placeholder="Search sentence or document"
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
                      <p className="text-lg font-semibold leading-8 text-slate-950">
                        {item.sentenceText}
                      </p>
                      <p className="mt-2 text-sm text-slate-500">
                        {item.documentTitle} · {formatDate(item.createdAt)}
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
                    Note
                  </label>
                  <textarea
                    value={item.note ?? ''}
                    onChange={(event) =>
                      handleUpdateNote(item.id, event.target.value)
                    }
                    rows={2}
                    className="mt-2 w-full resize-y rounded-md border border-slate-300 bg-white px-3 py-2 text-sm leading-6 outline-none transition focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
                    placeholder="Add a note..."
                  />
                </li>
              ))}
            </ul>
          ) : (
            <div className="border-l-4 border-cyan-700 bg-white p-5 shadow-sm">
              <h2 className="text-lg font-semibold text-slate-950">
                No favorite sentences found
              </h2>
              <p className="mt-2 text-sm leading-6 text-slate-600">
                Save sentences from the reader detail panel.
              </p>
            </div>
          )}
        </section>
      </div>
    </main>
  );
}

export default FavoritesPage;
