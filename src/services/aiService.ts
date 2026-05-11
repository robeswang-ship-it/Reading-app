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
