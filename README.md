# AI Intensive Reading

A React + TypeScript + Vite + Tailwind CSS English intensive reading app with a local document library, reading modes, vocabulary/favorites, review flows, and optional DeepSeek-powered analysis.

## Features

- Local document library stored in `localStorage`
- Create documents with a title and English source text
- Rule-based sentence splitting
- Persistent last-read sentence position per document
- Continuous full-text reader with extensive and intensive modes
- Vocabulary book, favorite sentences, and review pages
- Import/export library JSON and batch TXT import
- Supabase email/password authentication
- Password recovery with an in-app new-password form
- Optional DeepSeek sentence and word analysis
- No database tables or cloud sync yet

## Environment Variables

Create a local `.env` file from `.env.example`:

```bash
cp .env.example .env
```

Set the required Supabase Auth variables:

```text
VITE_SUPABASE_URL=your_supabase_project_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
```

Set the optional DeepSeek API key:

```text
VITE_DEEPSEEK_API_KEY=your_deepseek_api_key
```

If `VITE_DEEPSEEK_API_KEY` is empty, the app falls back to mock AI responses.

## Data Storage

The app uses Supabase Auth and supports an optional Supabase cloud library.
Browser `localStorage` remains as a local cache and offline-safe fallback.

Local documents are stored under the key:

```text
ai-intensive-reading:documents
```

Each document contains the original source text, generated sentence records,
creation time, and `currentSentenceIndex`. The app updates that index whenever a
reader selects a sentence, so opening the document later resumes from the saved
position.

## Supabase Cloud Library Setup

1. Open the Supabase SQL Editor for the existing project.
2. Run:

   ```text
   supabase/migrations/20260729_cloud_library.sql
   ```

3. Reload the app while logged in.
4. The first device uploads its existing local library when no cloud copy
   exists.
5. A new device with an empty local cache downloads the cloud copy.
6. If both locations already contain data and their relationship is unknown,
   the app stops and asks which copy to keep.

The migration creates `public.reading_libraries` with Row Level Security. Each
authenticated account can read and write only the row whose `user_id` matches
its Supabase Auth user id.

## Shared System Library Setup

Run this additional migration in the Supabase SQL Editor:

```text
supabase/migrations/20260729_system_library.sql
```

It creates:

- `system_collections`: published read-only collections shared by all users
- `system_documents`: one shared copy of each source document and its sentence structure
- `user_system_document_states`: per-user progress and personal sentence notes

Authenticated users can only read published system content. They cannot create,
edit, or delete shared content. Each user can read and write only their own
progress and notes. Shared documents are never included in the per-user cloud
library snapshot. Translation, grammar, phrases, and vocabulary analysis are
generated only when a user requests them and are not stored in Supabase.

The curated 2024 English I sample is stored in:

```text
content/system-library/english-one/2024.json
```

To regenerate and load its idempotent seed migration:

```bash
node scripts/build-system-library-seed.mjs \
  content/system-library/english-one/2024.json \
  > supabase/migrations/20260729_english_one_2024_sample.sql
```

Then run `supabase/migrations/20260729_english_one_2024_sample.sql` in the
Supabase SQL Editor. Re-running it updates the same six shared documents instead
of creating duplicates.

## Local Development

1. Install Node.js `20.19.0` or newer.
2. Install dependencies:

   ```bash
   npm install
   ```

3. Create `.env`:

   ```bash
   cp .env.example .env
   ```

4. Add `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY` in `.env`.
5. Add `VITE_DEEPSEEK_API_KEY` if you want real DeepSeek analysis.
6. Start the development server:

   ```bash
   npm run dev
   ```

7. Open the local URL printed by Vite, usually:

   ```text
   http://localhost:5173
   ```

## Production Build

```bash
npm run build
```

Preview the production build:

```bash
npm run preview
```

## Vercel Deployment

1. Push the project to a Git repository.
2. Import the repository in Vercel.
3. Use the default Vite settings:
   - Framework Preset: `Vite`
   - Build Command: `npm run build`
   - Output Directory: `dist`
4. In Vercel Project Settings, add the environment variables:

   ```text
   VITE_SUPABASE_URL
   VITE_SUPABASE_ANON_KEY
   VITE_DEEPSEEK_API_KEY
   ```

5. Deploy.

The app is frontend-only. Supabase is used for authentication only right now.
User library data is still stored in each browser's `localStorage`, so this
deployment does not require database tables or cloud sync.
