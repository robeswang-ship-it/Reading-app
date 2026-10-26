export type Sentence = {
  id: string;
  text: string;
  italicRanges?: Array<{
    start: number;
    end: number;
  }>;
  translation?: string;
  grammar?: string;
  keyPhrases?: Array<{
    phrase: string;
    explanation: string;
  }>;
  advancedVocabulary?: Array<{
    word: string;
    meaning: string;
    explanation: string;
  }>;
  userNote?: string;
  aiStatus?: 'idle' | 'loading' | 'done' | 'error';
};

export type Paragraph = {
  id: string;
  sentences: Sentence[];
};

export type Document = {
  id: string;
  title: string;
  createdAt: string;
  sourceText: string;
  paragraphs?: Paragraph[];
  sentences: Sentence[];
  currentSentenceIndex: number;
  folderId?: string;
  readCount?: number;
  lastOpenedAt?: string;
  origin?: 'personal' | 'system';
  systemCollectionId?: string;
};

export type Folder = {
  id: string;
  name: string;
  createdAt: string;
  parentId?: string;
  sortOrder?: number;
};

export type SystemCollection = {
  id: string;
  slug: string;
  title: string;
  description?: string;
  sortOrder: number;
};

export type SystemDocumentState = {
  documentId: string;
  currentSentenceIndex: number;
  sentenceNotes: Record<string, string>;
  readCount: number;
  lastOpenedAt?: string;
  updatedAt?: string;
};

export type VocabularyItem = {
  id: string;
  word: string;
  entryType?: 'word' | 'phrase';
  originalForm?: string;
  documentId: string;
  documentTitle: string;
  sentenceId: string;
  sentenceText: string;
  createdAt: string;
  reviewCount: number;
  lastReviewedAt?: string;
  familiarity: number;
  inDirtyBasket?: boolean;
  meaning?: string;
  partOfSpeech?: string;
  englishExplanation?: string;
  inflectionExplanation?: string;
  phonetic?: string;
  example?: string;
  note?: string;
};

export type FavoriteSentence = {
  id: string;
  documentId: string;
  documentTitle: string;
  sentenceId: string;
  sentenceText: string;
  createdAt: string;
  note?: string;
};

export type WritingItemType =
  | 'phrase'
  | 'sentence_pattern'
  | 'example_sentence';

export type WritingExampleReference = {
  essayId: string;
  sentenceId: string;
  sentenceText: string;
  translation: string;
  bindings?: Record<string, string>;
};

export type WritingPhrase = {
  id: string;
  type: 'phrase';
  text: string;
  phraseType: 'verb_phrase' | 'noun_phrase' | 'other_phrase';
  meaning: string;
  optionalEnglishExplanation?: string;
  tags: string[];
  priority: 'P1' | 'P2' | 'P3';
  usageNote?: string;
  examples: WritingExampleReference[];
};

export type WritingSentencePattern = {
  id: string;
  type: 'sentence_pattern';
  pattern: string;
  function: string;
  tags: string[];
  grammarNote?: string;
  usageNote?: string;
  examples: WritingExampleReference[];
};

export type WritingExampleSentence = {
  id: string;
  type: 'example_sentence';
  text: string;
  translation: string;
  tags: string[];
  essayId: string;
  sentenceId: string;
  shortNote?: string;
  relatedPhraseIds: string[];
  relatedPatternIds: string[];
};

export type WritingItem =
  | WritingPhrase
  | WritingSentencePattern
  | WritingExampleSentence;

export type WritingItemState = {
  itemId: string;
  inFocusList: boolean;
  note?: string;
  updatedAt?: string;
};

export type LibraryExportV1 = {
  version: 1;
  exportedAt: string;
  documents: Document[];
};

export type LibraryExportV2 = {
  version: 2;
  exportedAt: string;
  documents: Document[];
  folders: Folder[];
  vocabularyItems: VocabularyItem[];
  favoriteSentences: FavoriteSentence[];
};

export type LibraryExportV3 = {
  version: 3;
  exportedAt: string;
  documents: Document[];
  folders: Folder[];
  vocabularyItems: VocabularyItem[];
  favoriteSentences: FavoriteSentence[];
};

export type LibraryExportV4 = {
  version: 4;
  exportedAt: string;
  documents: Document[];
  folders: Folder[];
  vocabularyItems: VocabularyItem[];
  favoriteSentences: FavoriteSentence[];
  unfiledName?: string;
};

export type LibraryExport =
  | LibraryExportV1
  | LibraryExportV2
  | LibraryExportV3
  | LibraryExportV4;
