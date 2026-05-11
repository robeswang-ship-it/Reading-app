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
- Optional DeepSeek sentence and word analysis
- No backend and no authentication

## Environment Variables

Create a local `.env` file from `.env.example`:

```bash
cp .env.example .env
```

Set the optional DeepSeek API key:

```text
VITE_DEEPSEEK_API_KEY=your_deepseek_api_key
```

If this variable is empty, the app falls back to mock AI responses.

## Data Storage

Documents are stored in browser `localStorage` under the key:

```text
ai-intensive-reading:documents
```

Each document contains the original source text, generated sentence records,
creation time, and `currentSentenceIndex`. The app updates that index whenever a
reader selects a sentence, so opening the document later resumes from the saved
position.

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

4. Add `VITE_DEEPSEEK_API_KEY` in `.env` if you want real DeepSeek analysis.
5. Start the development server:

   ```bash
   npm run dev
   ```

6. Open the local URL printed by Vite, usually:

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
4. In Vercel Project Settings, add the environment variable:

   ```text
   VITE_DEEPSEEK_API_KEY
   ```

5. Deploy.

The app is frontend-only. User library data is stored in each browser's
`localStorage`, so deployments do not require a database or server.
