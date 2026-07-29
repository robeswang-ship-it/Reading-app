export type Sentence = {
  id: string;
  text: string;
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
  origin?: 'personal' | 'system';
  systemCollectionId?: string;
};

export type Folder = {
  id: string;
  name: string;
  createdAt: string;
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
  updatedAt?: string;
};

export type VocabularyItem = {
  id: string;
  word: string;
  documentId: string;
  documentTitle: string;
  sentenceId: string;
  sentenceText: string;
  createdAt: string;
  reviewCount: number;
  lastReviewedAt?: string;
  familiarity: number;
  meaning?: string;
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

export type LibraryExport = LibraryExportV1 | LibraryExportV2 | LibraryExportV3;
