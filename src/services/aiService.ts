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

export type WordLookup = {
  lemma: string;
  inflectionExplanation: string;
  chineseMeaning: string;
  partOfSpeech: string;
  englishExplanation: string;
  meaning: string;
  phonetic: string;
  example: string;
};

export type PhraseReview = {
  phrase: string;
  explanation: string;
  isValid: boolean;
  feedback: string;
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
    'lemma' in value &&
    'inflectionExplanation' in value &&
    'chineseMeaning' in value &&
    'partOfSpeech' in value &&
    'englishExplanation' in value &&
    'phonetic' in value &&
    'example' in value &&
    typeof value.lemma === 'string' &&
    typeof value.inflectionExplanation === 'string' &&
    typeof value.chineseMeaning === 'string' &&
    typeof value.partOfSpeech === 'string' &&
    typeof value.englishExplanation === 'string' &&
    typeof value.phonetic === 'string' &&
    typeof value.example === 'string'
  );
}

function isPhraseReview(value: unknown): value is PhraseReview {
  return (
    typeof value === 'object' &&
    value !== null &&
    'phrase' in value &&
    'explanation' in value &&
    'isValid' in value &&
    'feedback' in value &&
    typeof value.phrase === 'string' &&
    typeof value.explanation === 'string' &&
    typeof value.isValid === 'boolean' &&
    typeof value.feedback === 'string'
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
- Every keyPhrases.phrase must be the shortest complete, reusable dictionary-style expression, not a fragment copied from the sentence.
- Remove optional context-specific subjects, objects, modifiers, purposes, reasons, times, manners, and trailing clauses.
- Replace variable people, things, and actions with sb., sth., doing sth., or do sth. when that makes a reusable pattern.
- Keep indispensable particles and prepositions that belong to the expression.
- Extract only established expressions, collocations, idioms, phrasal verbs, or useful grammar/discourse markers; omit ordinary compositional fragments such as “as a defensive move”.
- For a grammar or discourse marker such as “if only”, “even if”, “as if”, or “rather than”, return the marker itself and discard the clause or modifier that follows it.
- Never turn a removable trailing modifier into sth. merely to keep it in the phrase.
- Before returning each phrase, remove every word that is not required for the expression to remain complete and reusable.
- Examples: “if only as a defensive move” -> “if only”; “raced to add such patents” -> “race to do sth.”; “add such patents to their files” -> “add sth. to one's files”; “beat them to the punch” -> “beat sb. to the punch”.
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

export async function reviewPhrase(
  candidate: string,
  contextSentence: string,
): Promise<PhraseReview> {
  const prompt = `You edit English phrasebook entries for a Chinese learner.

Candidate phrase:
"${candidate}"

Original context sentence:
"${contextSentence}"

Return valid JSON only:
{
  "phrase": "the corrected shortest reusable dictionary-style phrase",
  "explanation": "准确、简洁的中文释义",
  "isValid": true,
  "feedback": "简短说明原输入是否正确，或你删改了什么"
}

Rules:
- Decide whether the candidate itself is a complete, reusable phrase rather than a sentence fragment.
- phrase must be the shortest form that preserves the fixed expression or useful grammatical pattern.
- Remove optional context-specific subjects, objects, modifiers, purposes, reasons, times, manners, and trailing clauses.
- Replace variable people, things, and actions with sb., sth., doing sth., or do sth. when useful.
- Keep indispensable particles and prepositions.
- First test whether a shorter expression at the beginning is independently useful. For grammar and discourse markers such as “if only”, “even if”, “as if”, and “rather than”, return the marker alone.
- Never generalize an optional trailing modifier into sb., sth., or doing sth. merely to retain it. Placeholders are only for an argument required by the head verb or fixed pattern.
- “if only as a defensive move” must return exactly “if only”, never “if only as sth.”.
- isValid is true only when the candidate already has an appropriate phrasebook form; otherwise return the corrected form and false.
- explanation must explain the returned phrase in Chinese, using the context sentence to choose the leading meaning.
- feedback must be concise and written in Chinese.
- Examples: “if only as a defensive move” -> “if only”; “raced to add such patents” -> “race to do sth.”; “beat them to the punch” -> “beat sb. to the punch”.
- No extra text outside JSON.
`;

  const rawContent = await callDeepSeek(prompt);

  if (!rawContent) {
    throw new Error('DeepSeek phrase review failed');
  }

  const parsedContent: unknown = safeParseJSON(rawContent);

  if (!isPhraseReview(parsedContent)) {
    throw new Error('DeepSeek phrase review returned invalid data');
  }

  const phrase = parsedContent.phrase.trim();
  const explanation = parsedContent.explanation.trim();

  if (!phrase || !explanation) {
    throw new Error('DeepSeek phrase review returned an empty result');
  }

  return {
    phrase,
    explanation,
    isValid: parsedContent.isValid,
    feedback: parsedContent.feedback.trim(),
  };
}

export async function lookupWord(
  word: string,
  contextSentence?: string,
  entryType: 'word' | 'phrase' = 'word',
): Promise<WordLookup> {
  const isPhrase = entryType === 'phrase';
  const prompt = `You are an English dictionary assistant.

Explain the following ${isPhrase ? 'phrase' : 'word'} for an English learner.

${isPhrase ? 'Phrase' : 'Word'}:
"${word}"

${contextSentence ? `Context sentence:\n"${contextSentence}"` : 'No context sentence is available.'}

Return valid JSON only:
{
  "lemma": "${isPhrase ? 'the phrase exactly as supplied' : 'dictionary base form of the selected word'}",
  "inflectionExplanation": "${isPhrase ? 'an empty string' : 'brief Chinese explanation of the selected form, or an empty string when it is already the base form'}",
  "chineseMeaning": "当前语境义；其他常见义项",
  "partOfSpeech": "part of speech, e.g. noun / verb / adjective",
  "englishExplanation": "learner-friendly English explanation",
  "phonetic": "/phonetic/",
  "example": "natural English example sentence"
}

Rules:
- No extra text
- ${isPhrase ? 'Keep lemma exactly equal to the supplied phrase; do not lemmatize or shorten it' : 'lemma must be the correct dictionary headword: restore plurals, comparative forms, past tense, participles, and other inflections'}
- Use the context sentence to choose the correct lemma, part of speech, and meaning
- ${isPhrase ? 'partOfSpeech must be "phrase" and inflectionExplanation must be an empty string' : 'inflectionExplanation must be Chinese, for example “过去式和过去分词”; use an empty string for an uninflected headword'}
- Chinese meaning must be written in Chinese as a semicolon-separated list using Chinese semicolons（；）
- Put the meaning used in the context sentence first, followed by 2-4 distinct, common meanings when they exist
- Do not invent extra meanings merely to reach a fixed count
- English explanation must be written in English
- Keep explanation simple and useful
- Example should be a natural English sentence
`;

  try {
    const rawContent = await callDeepSeek(prompt);

    if (!rawContent) {
      throw new Error('DeepSeek word lookup failed');
    }

    const parsedContent: unknown = safeParseJSON(rawContent);

    if (isWordLookup(parsedContent)) {
      return {
        ...parsedContent,
        meaning: parsedContent.chineseMeaning,
      };
    }

    return {
      lemma: word,
      inflectionExplanation: '',
      chineseMeaning: rawContent,
      partOfSpeech: '解析失败',
      englishExplanation: 'Parsing failed. Please try again.',
      meaning: rawContent,
      phonetic: '/解析失败/',
      example: '解析失败，请重试',
    };
  } catch (error) {
    throw error instanceof Error
      ? error
      : new Error('DeepSeek word lookup failed');
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
