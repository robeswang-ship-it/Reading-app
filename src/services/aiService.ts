type SentenceAnalysis = {
  translation: string;
  grammar: string;
};

type WordLookup = {
  meaning: string;
  phonetic: string;
  example: string;
};

type DeepSeekResponse = {
  choices?: Array<{
    message?: {
      content?: string;
    };
  }>;
};

const DEEPSEEK_API_URL = 'https://api.deepseek.com/v1/chat/completions';
const DEEPSEEK_MODEL = 'deepseek-chat';
const PDF_CLEANUP_CHUNK_SIZE = 12_000;

function delay(ms: number) {
  return new Promise((resolve) => {
    window.setTimeout(resolve, ms);
  });
}

function safeParseJSON(text: string) {
  try {
    return JSON.parse(text);
  } catch {
    const match = text.match(/\{[\s\S]*\}/);
    if (match) {
      try {
        return JSON.parse(match[0]);
      } catch {
        return null;
      }
    }
    return null;
  }
}

function getDeepSeekApiKey() {
  return import.meta.env.VITE_DEEPSEEK_API_KEY as string | undefined;
}

function mockSentenceAnalysis(sentence: string): SentenceAnalysis {
  return {
    translation: `模拟翻译：${sentence}`,
    grammar:
      '模拟语法解析：这里会用中文说明主句结构、从句关系、重点短语和理解难点。',
  };
}

function mockWordLookup(word: string): WordLookup {
  return {
    meaning: `Mock meaning for "${word}".`,
    phonetic: '/mock/',
    example: `This is a mock example sentence using "${word}".`,
  };
}

function chunkText(text: string, maxChunkSize: number) {
  const chunks: string[] = [];
  const paragraphs = text
    .split(/\n{2,}/)
    .map((paragraph) => paragraph.trim())
    .filter(Boolean);
  let currentChunk = '';

  for (const paragraph of paragraphs) {
    if (paragraph.length > maxChunkSize) {
      if (currentChunk) {
        chunks.push(currentChunk);
        currentChunk = '';
      }

      for (let index = 0; index < paragraph.length; index += maxChunkSize) {
        chunks.push(paragraph.slice(index, index + maxChunkSize));
      }
      continue;
    }

    const nextChunk = currentChunk
      ? `${currentChunk}\n\n${paragraph}`
      : paragraph;

    if (nextChunk.length > maxChunkSize) {
      chunks.push(currentChunk);
      currentChunk = paragraph;
    } else {
      currentChunk = nextChunk;
    }
  }

  if (currentChunk) {
    chunks.push(currentChunk);
  }

  return chunks;
}

async function callDeepSeek(content: string) {
  const apiKey = getDeepSeekApiKey();

  if (!apiKey) {
    return null;
  }

  const response = await fetch(DEEPSEEK_API_URL, {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${apiKey}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      model: DEEPSEEK_MODEL,
      messages: [
        {
          role: 'user',
          content,
        },
      ],
    }),
  });

  if (!response.ok) {
    return null;
  }

  const data = (await response.json()) as DeepSeekResponse;
  return data.choices?.[0]?.message?.content ?? null;
}

function isSentenceAnalysis(value: unknown): value is SentenceAnalysis {
  return (
    typeof value === 'object' &&
    value !== null &&
    'translation' in value &&
    'grammar' in value &&
    typeof value.translation === 'string' &&
    typeof value.grammar === 'string'
  );
}

function isWordLookup(value: unknown): value is WordLookup {
  return (
    typeof value === 'object' &&
    value !== null &&
    'meaning' in value &&
    'phonetic' in value &&
    'example' in value &&
    typeof value.meaning === 'string' &&
    typeof value.phonetic === 'string' &&
    typeof value.example === 'string'
  );
}

export async function analyzeSentence(
  sentence: string,
): Promise<SentenceAnalysis> {
  const prompt = `You are an English intensive reading tutor for a Chinese learner.

Analyze the following English sentence.

Sentence:
"${sentence}"

Return valid JSON only:
{
  "translation": "自然流畅的中文翻译",
  "grammar": "用中文解释这个句子的语法结构、从句关系、重点短语和理解难点"
}

Rules:
- The translation must be Chinese.
- The grammar explanation must be written entirely in Chinese.
- Do not explain in English.
- Keep the grammar explanation clear and concise.
- No extra text outside JSON.
`;

  try {
    const rawContent = await callDeepSeek(prompt);

    if (!rawContent) {
      await delay(700);
      return mockSentenceAnalysis(sentence);
    }

    const parsedContent: unknown = safeParseJSON(rawContent);

    if (isSentenceAnalysis(parsedContent)) {
      return parsedContent;
    }

    return {
      translation: rawContent,
      grammar: '解析失败，请重试',
    };
  } catch {
    await delay(700);
    return mockSentenceAnalysis(sentence);
  }
}

export async function lookupWord(word: string): Promise<WordLookup> {
  const prompt = `You are an English dictionary assistant.

Explain the following word for an English learner.

Word:
"${word}"

Return valid JSON only:
{
  "meaning": "...",
  "phonetic": "...",
  "example": "..."
}

Rules:
- No extra text
- Keep explanation simple
- Example should be a natural English sentence
`;

  try {
    const rawContent = await callDeepSeek(prompt);

    if (!rawContent) {
      await delay(500);
      return mockWordLookup(word);
    }

    const parsedContent: unknown = safeParseJSON(rawContent);

    if (isWordLookup(parsedContent)) {
      return parsedContent;
    }

    return {
      meaning: rawContent,
      phonetic: '/解析失败/',
      example: '解析失败，请重试',
    };
  } catch {
    await delay(500);
    return mockWordLookup(word);
  }
}

export async function cleanExtractedPdfText(rawText: string): Promise<string> {
  const trimmedText = rawText.trim();

  if (!trimmedText) {
    return rawText;
  }

  const chunks = chunkText(trimmedText, PDF_CLEANUP_CHUNK_SIZE);
  const cleanedChunks: string[] = [];

  try {
    for (const chunk of chunks) {
      const prompt = `You clean text extracted from an English PDF for an intensive reading app.

Clean the following extracted PDF text.

Rules:
- Remove broken line breaks and restore natural paragraph flow.
- Remove obvious repeated headers, footers, and page numbers.
- Preserve the original English content.
- Do not summarize.
- Do not translate.
- Return cleaned English text only.

Extracted text:
${chunk}`;

      const cleanedChunk = await callDeepSeek(prompt);

      if (!cleanedChunk?.trim()) {
        throw new Error('PDF cleanup failed');
      }

      cleanedChunks.push(cleanedChunk.trim());
    }

    return cleanedChunks.join('\n\n').trim() || rawText;
  } catch {
    return rawText;
  }
}
