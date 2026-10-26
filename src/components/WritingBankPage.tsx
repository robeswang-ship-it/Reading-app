import { useEffect, useMemo, useState } from 'react';
import type { WritingBankView } from '../hooks/useWritingBank';
import type {
  Document,
  WritingExampleReference,
  WritingItem,
  WritingItemState,
} from '../types';
import { pronounceEnglish } from '../utils/pronunciation';

type WritingBankPageProps = {
  items: WritingItem[];
  essays: Document[];
  stateByItemId: Map<string, WritingItemState>;
  view: WritingBankView;
  onBackToLibrary: () => void;
  onOpenEssay: (essayId: string) => void;
  onRetry: () => void;
  onUpdateState: (
    itemId: string,
    fields: Partial<WritingItemState>,
  ) => Promise<void>;
};

type WritingTab = 'phrase' | 'sentence_pattern' | 'example_sentence';
type ListMode = 'all' | 'focus';

const PAGE_SIZE = 50;

const TAB_LABELS: Record<WritingTab, string> = {
  phrase: 'Phrases',
  sentence_pattern: 'Sentence Patterns',
  example_sentence: 'Example Sentences',
};

function getItemTitle(item: WritingItem) {
  if (item.type === 'phrase') {
    return item.text;
  }

  if (item.type === 'sentence_pattern') {
    return item.pattern;
  }

  return item.text;
}

function getItemSummary(item: WritingItem) {
  if (item.type === 'phrase') {
    return item.meaning;
  }

  if (item.type === 'sentence_pattern') {
    return item.function;
  }

  return item.translation;
}

function getItemSearchText(item: WritingItem) {
  if (item.type === 'phrase') {
    return [
      item.text,
      item.meaning,
      item.optionalEnglishExplanation,
      item.usageNote,
      ...item.tags,
    ]
      .filter(Boolean)
      .join(' ')
      .toLocaleLowerCase();
  }

  if (item.type === 'sentence_pattern') {
    return [
      item.pattern,
      item.function,
      item.grammarNote,
      item.usageNote,
      ...item.tags,
    ]
      .filter(Boolean)
      .join(' ')
      .toLocaleLowerCase();
  }

  return [item.text, item.translation, item.shortNote, ...item.tags]
    .filter(Boolean)
    .join(' ')
    .toLocaleLowerCase();
}

function getExamples(item: WritingItem): WritingExampleReference[] {
  if (item.type === 'example_sentence') {
    return [
      {
        essayId: item.essayId,
        sentenceId: item.sentenceId,
        sentenceText: item.text,
        translation: item.translation,
      },
    ];
  }

  return item.examples;
}

function WritingBankPage({
  items,
  essays,
  stateByItemId,
  view,
  onBackToLibrary,
  onOpenEssay,
  onRetry,
  onUpdateState,
}: WritingBankPageProps) {
  const [activeTab, setActiveTab] = useState<WritingTab>('phrase');
  const [listMode, setListMode] = useState<ListMode>('all');
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedTag, setSelectedTag] = useState('all');
  const [currentPage, setCurrentPage] = useState(1);
  const [expandedItemId, setExpandedItemId] = useState<string | null>(null);
  const essayById = useMemo(
    () => new Map(essays.map((essay) => [essay.id, essay])),
    [essays],
  );

  const tabItems = useMemo(
    () => items.filter((item) => item.type === activeTab),
    [activeTab, items],
  );
  const tags = useMemo(
    () =>
      [...new Set(tabItems.flatMap((item) => item.tags))].sort((left, right) =>
        left.localeCompare(right, 'zh-CN'),
      ),
    [tabItems],
  );
  const focusCount = useMemo(
    () =>
      tabItems.filter((item) => stateByItemId.get(item.id)?.inFocusList).length,
    [stateByItemId, tabItems],
  );
  const filteredItems = useMemo(() => {
    const normalizedQuery = searchQuery.trim().toLocaleLowerCase();

    return tabItems.filter((item) => {
      if (listMode === 'focus' && !stateByItemId.get(item.id)?.inFocusList) {
        return false;
      }

      if (selectedTag !== 'all' && !item.tags.includes(selectedTag)) {
        return false;
      }

      return !normalizedQuery || getItemSearchText(item).includes(normalizedQuery);
    });
  }, [listMode, searchQuery, selectedTag, stateByItemId, tabItems]);
  const pageCount = Math.max(1, Math.ceil(filteredItems.length / PAGE_SIZE));
  const paginatedItems = filteredItems.slice(
    (currentPage - 1) * PAGE_SIZE,
    currentPage * PAGE_SIZE,
  );

  useEffect(() => {
    setCurrentPage((page) => Math.min(page, pageCount));
  }, [pageCount]);

  const resetListPosition = () => {
    setCurrentPage(1);
    setExpandedItemId(null);
  };

  const handleTabChange = (tab: WritingTab) => {
    setActiveTab(tab);
    setListMode('all');
    setSelectedTag('all');
    resetListPosition();
  };

  const renderSource = (example: WritingExampleReference, index: number) => {
    const essay = essayById.get(example.essayId);

    return (
      <article
        key={`${example.essayId}-${example.sentenceId}-${index}`}
        className="rounded-lg border border-slate-200 bg-white p-4"
      >
        <p className="text-sm leading-6 text-slate-900">
          {example.sentenceText}
        </p>
        <p className="mt-2 text-sm leading-6 text-slate-600">
          {example.translation}
        </p>
        {example.bindings ? (
          <dl className="mt-3 grid gap-1 text-xs text-slate-500">
            {Object.entries(example.bindings).map(([slot, value]) => (
              <div key={slot} className="flex flex-wrap gap-1">
                <dt className="font-semibold">[{slot}]</dt>
                <dd>{value}</dd>
              </div>
            ))}
          </dl>
        ) : null}
        <div className="mt-3 flex flex-wrap items-center justify-between gap-2 border-t border-slate-100 pt-3">
          <p className="text-xs font-medium text-slate-500">
            {essay?.title ?? 'Source essay'}
          </p>
          <button
            type="button"
            onClick={() => onOpenEssay(example.essayId)}
            disabled={!essay}
            className="inline-flex h-8 items-center justify-center rounded-md border border-cyan-300 bg-white px-3 text-xs font-semibold text-cyan-800 transition hover:bg-cyan-50 disabled:cursor-not-allowed disabled:opacity-40"
          >
            Open Full Essay
          </button>
        </div>
      </article>
    );
  };

  const renderDetails = (item: WritingItem) => {
    const state = stateByItemId.get(item.id);
    const inFocusList = state?.inFocusList ?? false;
    const title = getItemTitle(item);

    return (
      <div className="border-t border-slate-200 bg-slate-50/70 p-4 sm:p-5">
        <div className="flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
          <div className="min-w-0">
            <h2 className="break-words text-2xl font-semibold text-slate-950">
              {title}
            </h2>
            <div className="mt-2 flex flex-wrap gap-2">
              {item.type === 'phrase' ? (
                <span className="rounded-full bg-violet-100 px-2 py-1 text-xs font-semibold text-violet-800">
                  {item.priority}
                </span>
              ) : null}
              {item.tags.map((tag) => (
                <span
                  key={tag}
                  className="rounded-full bg-slate-200 px-2 py-1 text-xs font-medium text-slate-700"
                >
                  {tag}
                </span>
              ))}
            </div>
          </div>
          <div className="flex shrink-0 flex-wrap gap-2">
            <button
              type="button"
              onClick={() => pronounceEnglish(title)}
              className="inline-flex h-9 items-center justify-center rounded-md border border-slate-300 bg-white px-3 text-sm font-semibold text-slate-700 shadow-sm transition hover:bg-slate-100"
            >
              Pronounce
            </button>
            <button
              type="button"
              onClick={() =>
                void onUpdateState(item.id, { inFocusList: !inFocusList })
              }
              className={`inline-flex h-9 items-center justify-center rounded-md border px-3 text-sm font-semibold shadow-sm transition ${
                inFocusList
                  ? 'border-amber-300 bg-amber-50 text-amber-800 hover:bg-amber-100'
                  : 'border-cyan-300 bg-white text-cyan-800 hover:bg-cyan-50'
              }`}
            >
              {inFocusList ? 'Remove from Focus List' : 'Add to Focus List'}
            </button>
          </div>
        </div>

        {item.type === 'phrase' ? (
          <div className="mt-5 grid gap-4 md:grid-cols-2">
            <div>
              <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
                Chinese meaning
              </p>
              <p className="mt-2 text-base leading-7 text-slate-900">
                {item.meaning}
              </p>
            </div>
            <div>
              <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
                English explanation
              </p>
              <p className="mt-2 text-sm leading-6 text-slate-700">
                {item.optionalEnglishExplanation ?? '—'}
              </p>
            </div>
            <div className="md:col-span-2">
              <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
                Usage
              </p>
              <p className="mt-2 text-sm leading-6 text-slate-700">
                {item.usageNote ?? '—'}
              </p>
            </div>
          </div>
        ) : null}

        {item.type === 'sentence_pattern' ? (
          <div className="mt-5 grid gap-4 md:grid-cols-2">
            <div>
              <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
                Function
              </p>
              <p className="mt-2 text-base leading-7 text-slate-900">
                {item.function}
              </p>
            </div>
            <div>
              <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
                Grammar
              </p>
              <p className="mt-2 text-sm leading-6 text-slate-700">
                {item.grammarNote ?? '—'}
              </p>
            </div>
            <div className="md:col-span-2">
              <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
                Usage
              </p>
              <p className="mt-2 text-sm leading-6 text-slate-700">
                {item.usageNote ?? '—'}
              </p>
            </div>
          </div>
        ) : null}

        {item.type === 'example_sentence' && item.shortNote ? (
          <div className="mt-5">
            <p className="text-xs font-semibold uppercase tracking-wide text-slate-500">
              Learning note
            </p>
            <p className="mt-2 text-sm leading-6 text-slate-700">
              {item.shortNote}
            </p>
          </div>
        ) : null}

        <div className="mt-5">
          <label
            htmlFor={`writing-note-${item.id}`}
            className="text-xs font-semibold uppercase tracking-wide text-slate-500"
          >
            Personal note
          </label>
          <textarea
            key={`${item.id}-${state?.updatedAt ?? ''}`}
            id={`writing-note-${item.id}`}
            defaultValue={state?.note ?? ''}
            onBlur={(event) =>
              void onUpdateState(item.id, { note: event.target.value })
            }
            rows={2}
            className="mt-2 w-full resize-y rounded-md border border-slate-300 bg-white px-3 py-2 text-sm leading-6 text-slate-900 outline-none transition placeholder:text-slate-400 focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
            placeholder="Add a personal note..."
          />
        </div>

        <div className="mt-5 border-t border-slate-200 pt-5">
          <h3 className="text-sm font-semibold text-slate-950">
            Source context
          </h3>
          <div className="mt-3 grid gap-3">
            {getExamples(item).map(renderSource)}
          </div>
        </div>
      </div>
    );
  };

  return (
    <main className="min-h-screen bg-slate-50 text-slate-950">
      <div className="mx-auto w-full max-w-6xl px-4 py-8 sm:px-6 lg:px-8">
        <header className="flex flex-col gap-4 border-b border-slate-200 pb-6 sm:flex-row sm:items-end sm:justify-between">
          <div>
            <p className="text-sm font-medium text-cyan-700">
              AI Intensive Reading
            </p>
            <h1 className="mt-2 text-3xl font-semibold">Writing Bank</h1>
            <p className="mt-2 max-w-2xl text-sm leading-6 text-slate-600">
              Learn reusable phrases, sentence patterns, and model sentences in
              their original essay context.
            </p>
          </div>
          <button
            type="button"
            onClick={onBackToLibrary}
            className="inline-flex h-10 items-center justify-center rounded-md border border-slate-300 bg-white px-4 text-sm font-semibold text-slate-700 shadow-sm transition hover:bg-slate-100"
          >
            Back to Library
          </button>
        </header>

        {view.state === 'loading' || view.state === 'idle' ? (
          <section className="mt-5 rounded-lg border border-cyan-200 bg-cyan-50 p-5 text-sm text-cyan-900">
            Loading Writing Bank...
          </section>
        ) : null}

        {view.state === 'error' ? (
          <section className="mt-5 flex flex-col gap-3 rounded-lg border border-rose-200 bg-rose-50 p-5 text-sm text-rose-900 sm:flex-row sm:items-center sm:justify-between">
            <p>{view.message}</p>
            <button
              type="button"
              onClick={onRetry}
              className="inline-flex h-9 items-center justify-center rounded-md border border-rose-300 bg-white px-3 font-semibold text-rose-800 hover:bg-rose-100"
            >
              Retry
            </button>
          </section>
        ) : null}

        {view.state === 'ready' ? (
          <>
            <section className="mt-5 rounded-lg border border-slate-200 bg-white p-4 shadow-sm">
              <div className="flex flex-wrap gap-2" role="tablist">
                {(Object.keys(TAB_LABELS) as WritingTab[]).map((tab) => {
                  const count = items.filter((item) => item.type === tab).length;
                  return (
                    <button
                      key={tab}
                      type="button"
                      role="tab"
                      aria-selected={activeTab === tab}
                      onClick={() => handleTabChange(tab)}
                      className={`inline-flex h-10 items-center justify-center rounded-md px-4 text-sm font-semibold transition ${
                        activeTab === tab
                          ? 'bg-cyan-700 text-white shadow-sm'
                          : 'bg-slate-100 text-slate-700 hover:bg-slate-200'
                      }`}
                    >
                      {TAB_LABELS[tab]}
                      <span className="ml-2 text-xs opacity-75">{count}</span>
                    </button>
                  );
                })}
              </div>

              <div className="mt-4 flex flex-col gap-3 border-t border-slate-200 pt-4 lg:flex-row lg:items-center lg:justify-between">
                <div className="inline-flex w-fit rounded-lg border border-slate-200 bg-slate-100 p-1">
                  <button
                    type="button"
                    onClick={() => {
                      setListMode('all');
                      resetListPosition();
                    }}
                    className={`h-9 rounded-md px-4 text-sm font-semibold ${
                      listMode === 'all'
                        ? 'bg-white text-slate-950 shadow-sm'
                        : 'text-slate-600'
                    }`}
                  >
                    All
                  </button>
                  <button
                    type="button"
                    onClick={() => {
                      setListMode('focus');
                      resetListPosition();
                    }}
                    className={`h-9 rounded-md px-4 text-sm font-semibold ${
                      listMode === 'focus'
                        ? 'bg-white text-amber-800 shadow-sm'
                        : 'text-slate-600'
                    }`}
                  >
                    Focus List <span className="ml-1 text-xs">{focusCount}</span>
                  </button>
                </div>

                <div className="flex flex-1 flex-col gap-2 sm:flex-row lg:max-w-3xl">
                  <input
                    type="search"
                    value={searchQuery}
                    onChange={(event) => {
                      setSearchQuery(event.target.value);
                      resetListPosition();
                    }}
                    className="h-10 min-w-0 flex-1 rounded-md border border-slate-300 bg-white px-3 text-sm outline-none focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
                    placeholder="Search English, Chinese, or notes"
                  />
                  <select
                    value={selectedTag}
                    onChange={(event) => {
                      setSelectedTag(event.target.value);
                      resetListPosition();
                    }}
                    className="h-10 rounded-md border border-slate-300 bg-white px-3 text-sm text-slate-700 outline-none focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
                    aria-label="Filter by tag"
                  >
                    <option value="all">All tags</option>
                    {tags.map((tag) => (
                      <option key={tag} value={tag}>
                        {tag}
                      </option>
                    ))}
                  </select>
                </div>
              </div>
              <p className="mt-3 text-sm text-slate-500">
                {filteredItems.length} item(s)
                {filteredItems.length > 0
                  ? ` · showing ${(currentPage - 1) * PAGE_SIZE + 1}–${Math.min(
                      currentPage * PAGE_SIZE,
                      filteredItems.length,
                    )}`
                  : ''}
              </p>
            </section>

            <section className="mt-4">
              {paginatedItems.length > 0 ? (
                <ul className="divide-y divide-slate-200 overflow-hidden rounded-lg border border-slate-200 bg-white shadow-sm">
                  {paginatedItems.map((item) => {
                    const isExpanded = expandedItemId === item.id;
                    const isFocused =
                      stateByItemId.get(item.id)?.inFocusList ?? false;

                    return (
                      <li key={item.id}>
                        <button
                          type="button"
                          onClick={() =>
                            setExpandedItemId((current) =>
                              current === item.id ? null : item.id,
                            )
                          }
                          aria-expanded={isExpanded}
                          className="grid w-full items-center gap-2 px-4 py-3 text-left transition hover:bg-slate-50 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-cyan-500 sm:grid-cols-[minmax(0,1.1fr)_minmax(0,1.6fr)_auto] sm:gap-4"
                        >
                          <span className="min-w-0 break-words font-semibold text-slate-950">
                            {getItemTitle(item)}
                          </span>
                          <span className="min-w-0 break-words text-sm leading-5 text-slate-600">
                            {getItemSummary(item)}
                          </span>
                          <span className="flex items-center justify-between gap-2 text-sm text-slate-400 sm:justify-end">
                            {isFocused ? (
                              <span className="rounded-full bg-amber-100 px-2 py-0.5 text-[10px] font-semibold uppercase text-amber-800">
                                Focus
                              </span>
                            ) : null}
                            <span aria-hidden="true">{isExpanded ? '▾' : '▸'}</span>
                          </span>
                        </button>
                        {isExpanded ? renderDetails(item) : null}
                      </li>
                    );
                  })}
                </ul>
              ) : (
                <div className="rounded-lg border border-dashed border-slate-300 bg-white p-10 text-center text-sm text-slate-500">
                  No writing items match these filters.
                </div>
              )}
            </section>

            {pageCount > 1 ? (
              <nav className="mt-5 flex items-center justify-center gap-3">
                <button
                  type="button"
                  onClick={() => {
                    setCurrentPage((page) => Math.max(1, page - 1));
                    setExpandedItemId(null);
                  }}
                  disabled={currentPage === 1}
                  className="inline-flex h-9 items-center justify-center rounded-md border border-slate-300 bg-white px-3 text-sm font-semibold text-slate-700 shadow-sm disabled:opacity-40"
                >
                  Previous
                </button>
                <span className="min-w-28 text-center text-sm text-slate-600">
                  Page {currentPage} of {pageCount}
                </span>
                <button
                  type="button"
                  onClick={() => {
                    setCurrentPage((page) => Math.min(pageCount, page + 1));
                    setExpandedItemId(null);
                  }}
                  disabled={currentPage === pageCount}
                  className="inline-flex h-9 items-center justify-center rounded-md border border-slate-300 bg-white px-3 text-sm font-semibold text-slate-700 shadow-sm disabled:opacity-40"
                >
                  Next
                </button>
              </nav>
            ) : null}
          </>
        ) : null}
      </div>
    </main>
  );
}

export default WritingBankPage;
