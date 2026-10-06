export type VocabularyImportEntry = {
  word: string;
  meaning?: string;
};

export type VocabularyImportResult = {
  entries: VocabularyImportEntry[];
  duplicateCount: number;
  invalidLines: string[];
};

const WORD_PATTERN = /^[A-Za-z][A-Za-z’'-]*(?:\s+[A-Za-z][A-Za-z’'-]*){0,3}$/;
const SINGLE_WORD_PATTERN = /^[A-Za-z][A-Za-z’'-]*$/;

function stripListMarker(line: string) {
  return line
    .replace(/^\s*(?:[-*•◦▪]\s*|\d{1,4}[.)、]\s*)/, '')
    .trim();
}

function cleanWord(value: string) {
  return value
    .trim()
    .replace(/^['"“”]|['"“”]$/g, '')
    .replace(/[.,;!?]+$/g, '')
    .trim();
}

function cleanMeaning(value: string) {
  return value.trim().replace(/^[-–—:：,，;；\s]+/, '').trim() || undefined;
}

function splitEntry(line: string): VocabularyImportEntry[] | null {
  const separatorPatterns = [
    /\t+/,
    /\s{2,}/,
    /\s*[:：]\s*/,
    /\s+[-–—]\s+/,
    /\s*[,，]\s*/,
  ];

  for (const separator of separatorPatterns) {
    const match = separator.exec(line);

    if (!match || match.index === 0) {
      continue;
    }

    const word = cleanWord(line.slice(0, match.index));
    const meaning = cleanMeaning(line.slice(match.index + match[0].length));

    if (WORD_PATTERN.test(word) && meaning) {
      return [{ word, meaning }];
    }
  }

  const wordWithMeaning = line.match(
    /^([A-Za-z][A-Za-z’'-]*(?:\s+[A-Za-z][A-Za-z’'-]*){0,3})\s+(.+)$/,
  );

  if (wordWithMeaning && /[\u3400-\u9fff]/.test(wordWithMeaning[2])) {
    return [
      {
        word: cleanWord(wordWithMeaning[1]),
        meaning: cleanMeaning(wordWithMeaning[2]),
      },
    ];
  }

  if (WORD_PATTERN.test(line)) {
    const tokens = line.split(/\s+/).map(cleanWord);

    if (tokens.length > 1 && tokens.every((token) => SINGLE_WORD_PATTERN.test(token))) {
      return tokens.map((word) => ({ word }));
    }

    return [{ word: cleanWord(line) }];
  }

  return null;
}

export function parseVocabularyText(text: string): VocabularyImportResult {
  const entriesByWord = new Map<string, VocabularyImportEntry>();
  const invalidLines: string[] = [];
  let duplicateCount = 0;

  for (const rawLine of text.replace(/\r\n?/g, '\n').split('\n')) {
    const line = stripListMarker(rawLine);

    if (!line) {
      continue;
    }

    const parsedEntries = splitEntry(line);

    if (!parsedEntries) {
      invalidLines.push(line);
      continue;
    }

    for (const entry of parsedEntries) {
      const key = entry.word.toLocaleLowerCase();
      const existing = entriesByWord.get(key);

      if (existing) {
        duplicateCount += 1;

        if (!existing.meaning && entry.meaning) {
          entriesByWord.set(key, entry);
        }
      } else {
        entriesByWord.set(key, entry);
      }
    }
  }

  return {
    entries: [...entriesByWord.values()],
    duplicateCount,
    invalidLines,
  };
}
