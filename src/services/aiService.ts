type SentenceAnalysis = {
  translation: string;
  grammar: string;
  keyPhrases: Array<{
    phrase: string;
    explanation: string;
  }>;
  advancedVocabulary: Array<{
    word: string;
    meaning: string;
    explanation: string;
  }>;
};

type WordLookup = {
  chineseMeaning: string;
  partOfSpeech: string;
  englishExplanation: string;
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
    keyPhrases: [
      {
        phrase: 'mock key phrase',
        explanation: '模拟重点短语解释',
      },
    ],
    advancedVocabulary: [
      {
        word: 'intensive',
        meaning: '深入的；密集的',
        explanation: '常用于描述需要高度专注或投入的学习与训练。',
      },
    ],
  };
}

function mockWordLookup(word: string): WordLookup {
  return {
    chineseMeaning: `模拟中文释义："${word}"`,
    partOfSpeech: 'noun',
    englishExplanation: `A mock learner-friendly explanation for "${word}".`,
    meaning: `模拟中文释义："${word}"`,
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
  const record = value as Record<string, unknown>;

  return (
    typeof value === 'object' &&
    value !== null &&
    typeof record.translation === 'string' &&
    typeof record.grammar === 'string' &&
    (record.keyPhrases === undefined ||
      (Array.isArray(record.keyPhrases) &&
        record.keyPhrases.every(
          (item) =>
            typeof item === 'object' &&
            item !== null &&
            'phrase' in item &&
            'explanation' in item &&
            typeof item.phrase === 'string' &&
            typeof item.explanation === 'string',
        ))) &&
    (record.advancedVocabulary === undefined ||
      (Array.isArray(record.advancedVocabulary) &&
        record.advancedVocabulary.every(
          (item) =>
            typeof item === 'object' &&
            item !== null &&
            'word' in item &&
            'meaning' in item &&
            'explanation' in item &&
            typeof item.word === 'string' &&
            typeof item.meaning === 'string' &&
            typeof item.explanation === 'string',
        )))
  );
}

function isWordLookup(value: unknown): value is WordLookup {
  return (
    typeof value === 'object' &&
    value !== null &&
    'chineseMeaning' in value &&
    'partOfSpeech' in value &&
    'englishExplanation' in value &&
    'phonetic' in value &&
    'example' in value &&
    typeof value.chineseMeaning === 'string' &&
    typeof value.partOfSpeech === 'string' &&
    typeof value.englishExplanation === 'string' &&
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
  "grammar": "用中文解释这个句子的语法结构、从句关系和理解难点",
  "keyPhrases": [
    {
      "phrase": "原句中的动词短语、介词短语、搭配或实用语块",
      "explanation": "中文解释"
    }
  ],
  "advancedVocabulary": [
    {
      "word": "难词或高级表达",
      "meaning": "中文含义",
      "explanation": "中文简短说明"
    }
  ]
}

Rules:
- The translation must be Chinese.
- The grammar explanation must be written entirely in Chinese.
- Extract 2-5 key phrases when available. Return [] if none.
- Extract 1-5 advanced vocabulary items when available. Return [] if none.
- Phrase and vocabulary explanations must be written in Chinese.
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
      return {
        translation: parsedContent.translation,
        grammar: parsedContent.grammar,
        keyPhrases: parsedContent.keyPhrases ?? [],
        advancedVocabulary: parsedContent.advancedVocabulary ?? [],
      };
    }

    return {
      translation: rawContent,
      grammar: '解析失败，请重试',
      keyPhrases: [],
      advancedVocabulary: [],
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
  "chineseMeaning": "中文释义",
  "partOfSpeech": "part of speech, e.g. noun / verb / adjective",
  "englishExplanation": "learner-friendly English explanation",
  "phonetic": "/phonetic/",
  "example": "natural English example sentence"
}

Rules:
- No extra text
- Chinese meaning must be written in Chinese
- English explanation must be written in English
- Keep explanation simple and useful
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
      return {
        ...parsedContent,
        meaning: parsedContent.chineseMeaning,
      };
    }

    return {
      chineseMeaning: rawContent,
      partOfSpeech: '解析失败',
      englishExplanation: 'Parsing failed. Please try again.',
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
- Preserve natural paragraph breaks with a blank line between paragraphs.
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
