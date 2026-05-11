import { FormEvent, useState } from 'react';

type TextImporterProps = {
  onCancel: () => void;
  onCreateDocument: (title: string, sourceText: string) => string | null;
};

function TextImporter({ onCancel, onCreateDocument }: TextImporterProps) {
  const [title, setTitle] = useState('');
  const [text, setText] = useState('');
  const [error, setError] = useState('');

  const handleSubmit = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();

    if (!title.trim()) {
      setError('Please enter a title for this document.');
      return;
    }

    if (!text.trim()) {
      setError('Please paste English text before starting.');
      return;
    }

    setError('');
    const creationError = onCreateDocument(title, text);

    if (creationError) {
      setError(creationError);
    }
  };

  return (
    <main className="min-h-screen bg-slate-50 text-slate-950">
      <div className="mx-auto flex min-h-screen w-full max-w-5xl flex-col justify-center px-4 py-8 sm:px-6 lg:px-8">
        <div className="mb-8">
          <p className="text-sm font-medium text-cyan-700">
            AI Intensive Reading
          </p>
          <h1 className="mt-3 text-4xl font-semibold text-slate-950 sm:text-5xl">
            Create a new reading document.
          </h1>
          <p className="mt-4 max-w-2xl text-base leading-7 text-slate-600">
            Add a title and paste the English content. The app will split it
            into sentences, save it locally, and open the reader.
          </p>
        </div>

        <form
          onSubmit={handleSubmit}
          className="rounded-lg border border-slate-200 bg-white p-4 shadow-sm sm:p-6"
        >
          <label
            htmlFor="document-title"
            className="text-sm font-semibold text-slate-800"
          >
            Title
          </label>
          <input
            id="document-title"
            type="text"
            value={title}
            onChange={(event) => setTitle(event.target.value)}
            className="mt-3 h-11 w-full rounded-md border border-slate-300 bg-white px-4 text-base text-slate-900 outline-none transition placeholder:text-slate-400 focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
            placeholder="e.g. The Future of Reading"
          />

          <label
            htmlFor="reading-text"
            className="mt-5 block text-sm font-semibold text-slate-800"
          >
            English text
          </label>
          <textarea
            id="reading-text"
            value={text}
            onChange={(event) => setText(event.target.value)}
            rows={14}
            className="mt-3 min-h-72 w-full resize-y rounded-md border border-slate-300 bg-white px-4 py-3 text-base leading-7 text-slate-900 outline-none transition placeholder:text-slate-400 focus:border-cyan-500 focus:ring-4 focus:ring-cyan-100"
            placeholder="Paste English text here..."
          />
          <div className="mt-4 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
            <p className="min-h-5 text-sm text-rose-600" role="alert">
              {error}
            </p>
            <button
              type="submit"
              className="inline-flex h-11 items-center justify-center rounded-md bg-cyan-700 px-5 text-sm font-semibold text-white shadow-sm transition hover:bg-cyan-800 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
            >
              Start Reading
            </button>
            <button
              type="button"
              onClick={onCancel}
              className="inline-flex h-11 items-center justify-center rounded-md border border-slate-300 bg-white px-5 text-sm font-semibold text-slate-700 shadow-sm transition hover:border-slate-400 hover:bg-slate-100 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2"
            >
              Back to Library
            </button>
          </div>
        </form>
      </div>
    </main>
  );
}

export default TextImporter;
