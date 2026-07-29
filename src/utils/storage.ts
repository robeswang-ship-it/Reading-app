import type {
  Document,
  FavoriteSentence,
  Folder,
  LibraryExport,
  LibraryExportV3,
  Paragraph,
  Sentence,
  VocabularyItem,
} from '../types';
import { splitIntoParagraphTexts, splitIntoSentences } from './sentenceSplitter';

const DOCUMENTS_KEY = 'ai-intensive-reading:documents';
const FOLDERS_KEY = 'ai-intensive-reading:folders';
const VOCABULARY_KEY = 'ai-intensive-reading:vocabulary-items';
const FAVORITES_KEY = 'ai-intensive-reading:favorite-sentences';

export function generateDocumentId() {
  return window.crypto?.randomUUID?.() ?? `${Date.now()}-${Math.random()}`;
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === 'object' && value !== null && !Array.isArray(value);
}

function readJsonArray<T>(
  storageKey: string,
  guard: (value: unknown) => value is T,
): T[] {
  const rawValue = window.localStorage.getItem(storageKey);

  if (!rawValue) {
    return [];
  }

  try {
    const parsedValue: unknown = JSON.parse(rawValue);
    return Array.isArray(parsedValue) ? parsedValue.filter(guard) : [];
  } catch {
    return [];
  }
}

function writeJsonArray<T>(storageKey: string, values: T[]) {
  window.localStorage.setItem(storageKey, JSON.stringify(values));
}

function isSentence(value: unknown): value is Sentence {
  if (!isRecord(value)) {
    return false;
  }

  return (
    typeof value.id === 'string' &&
    typeof value.text === 'string' &&
    (value.translation === undefined ||
      typeof value.translation === 'string') &&
    (value.grammar === undefined || typeof value.grammar === 'string') &&
    (value.keyPhrases === undefined ||
      (Array.isArray(value.keyPhrases) &&
        value.keyPhrases.every(
          (item) =>
            isRecord(item) &&
            typeof item.phrase === 'string' &&
            typeof item.explanation === 'string',
        ))) &&
    (value.advancedVocabulary === undefined ||
      (Array.isArray(value.advancedVocabulary) &&
        value.advancedVocabulary.every(
          (item) =>
            isRecord(item) &&
            typeof item.word === 'string' &&
            typeof item.meaning === 'string' &&
            typeof item.explanation === 'string',
        ))) &&
    (value.userNote === undefined || typeof value.userNote === 'string') &&
    (value.aiStatus === undefined ||
      value.aiStatus === 'idle' ||
      value.aiStatus === 'loading' ||
      value.aiStatus === 'done' ||
      value.aiStatus === 'error')
  );
}

function isParagraph(value: unknown): value is Paragraph {
  return (
    isRecord(value) &&
    typeof value.id === 'string' &&
    Array.isArray(value.sentences) &&
    value.sentences.every(isSentence)
  );
}

export function isDocument(value: unknown): value is Document {
  if (!isRecord(value)) {
    return false;
  }

  return (
    typeof value.id === 'string' &&
    typeof value.title === 'string' &&
    typeof value.createdAt === 'string' &&
    typeof value.sourceText === 'string' &&
    Array.isArray(value.sentences) &&
    value.sentences.every(isSentence) &&
    (value.paragraphs === undefined ||
      (Array.isArray(value.paragraphs) && value.paragraphs.every(isParagraph))) &&
    typeof value.currentSentenceIndex === 'number' &&
    Number.isInteger(value.currentSentenceIndex) &&
    (value.folderId === undefined || typeof value.folderId === 'string')
  );
}

function isFolder(value: unknown): value is Folder {
  if (!isRecord(value)) {
    return false;
  }

  return (
    typeof value.id === 'string' &&
    typeof value.name === 'string' &&
    typeof value.createdAt === 'string'
  );
}

function isVocabularyItem(value: unknown): value is VocabularyItem {
  if (!isRecord(value)) {
    return false;
  }

  return (
    typeof value.id === 'string' &&
    typeof value.word === 'string' &&
    typeof value.documentId === 'string' &&
    typeof value.documentTitle === 'string' &&
    typeof value.sentenceId === 'string' &&
    typeof value.sentenceText === 'string' &&
    typeof value.createdAt === 'string' &&
    (value.reviewCount === undefined ||
      (typeof value.reviewCount === 'number' &&
        Number.isInteger(value.reviewCount))) &&
    (value.lastReviewedAt === undefined ||
      typeof value.lastReviewedAt === 'string') &&
    (value.familiarity === undefined ||
      typeof value.familiarity === 'number') &&
    (value.meaning === undefined || typeof value.meaning === 'string') &&
    (value.phonetic === undefined || typeof value.phonetic === 'string') &&
    (value.example === undefined || typeof value.example === 'string') &&
    (value.note === undefined || typeof value.note === 'string')
  );
}

function isFavoriteSentence(value: unknown): value is FavoriteSentence {
  if (!isRecord(value)) {
    return false;
  }

  return (
    typeof value.id === 'string' &&
    typeof value.documentId === 'string' &&
    typeof value.documentTitle === 'string' &&
    typeof value.sentenceId === 'string' &&
    typeof value.sentenceText === 'string' &&
    typeof value.createdAt === 'string' &&
    (value.note === undefined || typeof value.note === 'string')
  );
}

export function isLibraryExport(value: unknown): value is LibraryExport {
  if (!isRecord(value)) {
    return false;
  }

  if (value.version === 1) {
    return Array.isArray(value.documents) && value.documents.every(isDocument);
  }

  if (value.version === 2 || value.version === 3) {
    return (
      Array.isArray(value.documents) &&
      value.documents.every(isDocument) &&
      Array.isArray(value.folders) &&
      value.folders.every(isFolder) &&
      Array.isArray(value.vocabularyItems) &&
      value.vocabularyItems.every(isVocabularyItem) &&
      Array.isArray(value.favoriteSentences) &&
      value.favoriteSentences.every(isFavoriteSentence)
    );
  }

  return false;
}

function normalizeSentence(sentence: Sentence): Sentence {
  return {
    ...sentence,
    translation: sentence.translation?.trim() || undefined,
    grammar: sentence.grammar?.trim() || undefined,
    keyPhrases: sentence.keyPhrases
      ?.map((item) => ({
        phrase: item.phrase.trim(),
        explanation: item.explanation.trim(),
      }))
      .filter((item) => item.phrase && item.explanation),
    advancedVocabulary: sentence.advancedVocabulary
      ?.map((item) => ({
        word: item.word.trim(),
        meaning: item.meaning.trim(),
        explanation: item.explanation.trim(),
      }))
      .filter((item) => item.word && item.meaning && item.explanation),
    userNote: sentence.userNote?.trim() || undefined,
    aiStatus: sentence.aiStatus ?? 'idle',
  };
}

function buildParagraphsFromSource(
  sourceText: string,
  sentences: Sentence[],
): Paragraph[] {
  const paragraphTexts = splitIntoParagraphTexts(sourceText);

  if (paragraphTexts.length === 0) {
    return sentences.length > 0
      ? [{ id: generateDocumentId(), sentences }]
      : [];
  }

  const paragraphs: Paragraph[] = [];
  let sentenceCursor = 0;

  for (const paragraphText of paragraphTexts) {
    const sentenceCount = splitIntoSentences(paragraphText).length;
    const paragraphSentences = sentences.slice(
      sentenceCursor,
      sentenceCursor + sentenceCount,
    );

    if (paragraphSentences.length > 0) {
      paragraphs.push({
        id: generateDocumentId(),
        sentences: paragraphSentences,
      });
    }

    sentenceCursor += sentenceCount;
  }

  if (sentenceCursor < sentences.length) {
    paragraphs.push({
      id: generateDocumentId(),
      sentences: sentences.slice(sentenceCursor),
    });
  }

  return paragraphs.length > 0
    ? paragraphs
    : [{ id: generateDocumentId(), sentences }];
}

function normalizeParagraphs(
  document: Document,
  sentences: Sentence[],
): Paragraph[] {
  const sentenceById = new Map(sentences.map((sentence) => [sentence.id, sentence]));
  const paragraphIds = new Set<string>();
  const paragraphs =
    document.paragraphs
      ?.map((paragraph) => {
        const paragraphSentences = paragraph.sentences
          .map((sentence) => sentenceById.get(sentence.id))
          .filter((sentence): sentence is Sentence => Boolean(sentence));

        paragraphSentences.forEach((sentence) => paragraphIds.add(sentence.id));

        return {
          id: paragraph.id,
          sentences: paragraphSentences,
        };
      })
      .filter((paragraph) => paragraph.sentences.length > 0) ?? [];

  const missingSentences = sentences.filter((sentence) => !paragraphIds.has(sentence.id));

  if (paragraphs.length > 0 && missingSentences.length === 0) {
    return paragraphs;
  }

  if (paragraphs.length > 0) {
    return [
      ...paragraphs,
      {
        id: generateDocumentId(),
        sentences: missingSentences,
      },
    ];
  }

  return buildParagraphsFromSource(document.sourceText, sentences);
}

function normalizeDocument(document: Document): Document {
  const maxIndex = Math.max(document.sentences.length - 1, 0);
  const folderId = document.folderId?.trim();
  const sentences = document.sentences.map(normalizeSentence);

  return {
    ...document,
    sentences,
    paragraphs: normalizeParagraphs(document, sentences),
    title: document.title.trim() || 'Untitled Document',
    folderId: folderId || undefined,
    currentSentenceIndex: Math.min(
      Math.max(document.currentSentenceIndex, 0),
      maxIndex,
    ),
  };
}

function normalizeFolder(folder: Folder): Folder {
  return {
    ...folder,
    name: folder.name.trim() || 'Untitled Folder',
  };
}

function normalizeVocabularyItem(item: VocabularyItem): VocabularyItem {
  return {
    ...item,
    word: item.word.trim(),
    reviewCount: Math.max(item.reviewCount ?? 0, 0),
    familiarity: Math.min(Math.max(item.familiarity ?? 0, 0), 5),
    meaning: item.meaning?.trim() || undefined,
    phonetic: item.phonetic?.trim() || undefined,
    example: item.example?.trim() || undefined,
    note: item.note?.trim() || undefined,
  };
}

function sortByCreatedAtDesc<T extends { createdAt: string }>(values: T[]) {
  return [...values].sort(
    (a, b) =>
      new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime(),
  );
}

function getStoredDocuments() {
  return readJsonArray(DOCUMENTS_KEY, isDocument);
}

function getStoredFolders() {
  return readJsonArray(FOLDERS_KEY, isFolder);
}

function getStoredVocabularyItems() {
  return readJsonArray(VOCABULARY_KEY, isVocabularyItem).map(
    normalizeVocabularyItem,
  );
}

function getStoredFavoriteSentences() {
  return readJsonArray(FAVORITES_KEY, isFavoriteSentence);
}

export function getDocuments(): Document[] {
  return sortByCreatedAtDesc(getStoredDocuments().map(normalizeDocument));
}

export function saveDocument(document: Document) {
  writeJsonArray(DOCUMENTS_KEY, [normalizeDocument(document), ...getStoredDocuments()]);
}

export function updateDocument(document: Document) {
  const normalizedDocument = normalizeDocument(document);
  const nextDocuments = getStoredDocuments().map((currentDocument) =>
    currentDocument.id === document.id ? normalizedDocument : currentDocument,
  );

  writeJsonArray(DOCUMENTS_KEY, nextDocuments);
}

export function updateSentenceFields(
  documentId: string,
  sentenceId: string,
  fields: Pick<Sentence, 'translation' | 'grammar' | 'userNote'>,
) {
  let updatedDocument: Document | null = null;
  const nextDocuments = getStoredDocuments().map((document) => {
    if (document.id !== documentId) {
      return document;
    }

    updatedDocument = normalizeDocument({
      ...document,
      sentences: document.sentences.map((sentence) =>
        sentence.id === sentenceId
          ? {
              ...sentence,
              translation: fields.translation?.trim() || undefined,
              grammar: fields.grammar?.trim() || undefined,
              userNote: fields.userNote?.trim() || undefined,
            }
          : sentence,
      ),
    });

    return updatedDocument;
  });

  writeJsonArray(DOCUMENTS_KEY, nextDocuments);
  return updatedDocument;
}

export function updateSentenceAiFields(
  documentId: string,
  sentenceId: string,
  fields: Pick<Sentence, 'aiStatus'> &
    Partial<
      Pick<Sentence, 'translation' | 'grammar' | 'keyPhrases' | 'advancedVocabulary'>
    > & {
      overwrite?: boolean;
    },
) {
  let updatedDocument: Document | null = null;
  const nextDocuments = getStoredDocuments().map((document) => {
    if (document.id !== documentId) {
      return document;
    }

    updatedDocument = normalizeDocument({
      ...document,
      sentences: document.sentences.map((sentence) =>
        sentence.id === sentenceId
          ? {
              ...sentence,
              translation:
                fields.translation === undefined
                  ? sentence.translation
                  : fields.overwrite
                    ? fields.translation
                    : sentence.translation || fields.translation,
              grammar:
                fields.grammar === undefined
                  ? sentence.grammar
                  : fields.overwrite
                    ? fields.grammar
                    : sentence.grammar || fields.grammar,
              keyPhrases:
                fields.keyPhrases === undefined
                  ? sentence.keyPhrases
                  : fields.overwrite
                    ? fields.keyPhrases
                    : sentence.keyPhrases?.length
                      ? sentence.keyPhrases
                      : fields.keyPhrases,
              advancedVocabulary:
                fields.advancedVocabulary === undefined
                  ? sentence.advancedVocabulary
                  : fields.overwrite
                    ? fields.advancedVocabulary
                    : sentence.advancedVocabulary?.length
                      ? sentence.advancedVocabulary
                      : fields.advancedVocabulary,
              aiStatus: fields.aiStatus,
            }
          : sentence,
      ),
    });

    return updatedDocument;
  });

  writeJsonArray(DOCUMENTS_KEY, nextDocuments);
  return updatedDocument;
}

export function deleteDocument(id: string) {
  writeJsonArray(
    DOCUMENTS_KEY,
    getStoredDocuments().filter((document) => document.id !== id),
  );
}

export function renameDocument(id: string, title: string) {
  const nextTitle = title.trim();

  if (!nextTitle) {
    return;
  }

  writeJsonArray(
    DOCUMENTS_KEY,
    getStoredDocuments().map((document) =>
      document.id === id ? normalizeDocument({ ...document, title: nextTitle }) : document,
    ),
  );
  writeJsonArray(
    VOCABULARY_KEY,
    getStoredVocabularyItems().map((item) =>
      item.documentId === id ? { ...item, documentTitle: nextTitle } : item,
    ),
  );
  writeJsonArray(
    FAVORITES_KEY,
    getStoredFavoriteSentences().map((item) =>
      item.documentId === id ? { ...item, documentTitle: nextTitle } : item,
    ),
  );
}

export function moveDocumentToFolder(id: string, folderId?: string) {
  writeJsonArray(
    DOCUMENTS_KEY,
    getStoredDocuments().map((document) =>
      document.id === id
        ? normalizeDocument({ ...document, folderId: folderId || undefined })
        : document,
    ),
  );
}

export function getFolders(): Folder[] {
  return sortByCreatedAtDesc(getStoredFolders().map(normalizeFolder));
}

export function createFolder(name: string) {
  const folder: Folder = {
    id: generateDocumentId(),
    name: name.trim() || 'Untitled Folder',
    createdAt: new Date().toISOString(),
  };

  writeJsonArray(FOLDERS_KEY, [folder, ...getStoredFolders()]);
  return folder;
}

export function renameFolder(id: string, name: string) {
  const nextName = name.trim();

  if (!nextName) {
    return;
  }

  writeJsonArray(
    FOLDERS_KEY,
    getStoredFolders().map((folder) =>
      folder.id === id ? normalizeFolder({ ...folder, name: nextName }) : folder,
    ),
  );
}

export function deleteFolder(id: string) {
  writeJsonArray(
    FOLDERS_KEY,
    getStoredFolders().filter((folder) => folder.id !== id),
  );
  writeJsonArray(
    DOCUMENTS_KEY,
    getStoredDocuments().map((document) =>
      document.folderId === id
        ? normalizeDocument({ ...document, folderId: undefined })
        : document,
    ),
  );
}

export function getVocabularyItems(): VocabularyItem[] {
  return sortByCreatedAtDesc(getStoredVocabularyItems());
}

export function addVocabularyItem(
  item: Omit<
    VocabularyItem,
    'id' | 'createdAt' | 'reviewCount' | 'lastReviewedAt' | 'familiarity'
  >,
) {
  const normalizedWord = item.word.trim();

  if (!normalizedWord) {
    return { added: false, item: null };
  }

  const existingItems = getStoredVocabularyItems();
  const duplicate = existingItems.find(
    (existingItem) =>
      existingItem.sentenceId === item.sentenceId &&
      existingItem.word.toLowerCase() === normalizedWord.toLowerCase(),
  );

  if (duplicate) {
    return { added: false, item: duplicate };
  }

  const nextItem: VocabularyItem = {
    ...item,
    id: generateDocumentId(),
    word: normalizedWord,
    createdAt: new Date().toISOString(),
    reviewCount: 0,
    familiarity: 0,
  };

  writeJsonArray(VOCABULARY_KEY, [nextItem, ...existingItems]);
  return { added: true, item: nextItem };
}

export function getVocabularyReviewQueue(): VocabularyItem[] {
  const now = Date.now();

  return [...getStoredVocabularyItems()].sort((a, b) => {
    const aReviewedAt = a.lastReviewedAt
      ? new Date(a.lastReviewedAt).getTime()
      : 0;
    const bReviewedAt = b.lastReviewedAt
      ? new Date(b.lastReviewedAt).getTime()
      : 0;
    const aDaysSinceReview = (now - aReviewedAt) / 86_400_000;
    const bDaysSinceReview = (now - bReviewedAt) / 86_400_000;
    const aScore = (5 - a.familiarity) * 10 + aDaysSinceReview;
    const bScore = (5 - b.familiarity) * 10 + bDaysSinceReview;

    return bScore - aScore;
  });
}

export function reviewVocabularyItem(id: string, remembered: boolean) {
  let reviewedItem: VocabularyItem | null = null;

  const nextItems = getStoredVocabularyItems().map((item) => {
    if (item.id !== id) {
      return item;
    }

    reviewedItem = {
      ...item,
      reviewCount: item.reviewCount + 1,
      lastReviewedAt: new Date().toISOString(),
      familiarity: remembered
        ? Math.min(item.familiarity + 1, 5)
        : Math.max(item.familiarity - 1, 0),
    };

    return reviewedItem;
  });

  writeJsonArray(VOCABULARY_KEY, nextItems);
  return reviewedItem;
}

export function updateVocabularyNote(id: string, note: string) {
  writeJsonArray(
    VOCABULARY_KEY,
    getStoredVocabularyItems().map((item) =>
      item.id === id ? { ...item, note: note.trim() || undefined } : item,
    ),
  );
}

export function updateVocabularyDetails(
  id: string,
  fields: Pick<VocabularyItem, 'meaning' | 'phonetic' | 'example' | 'note'>,
) {
  writeJsonArray(
    VOCABULARY_KEY,
    getStoredVocabularyItems().map((item) =>
      item.id === id
        ? normalizeVocabularyItem({
            ...item,
            meaning: fields.meaning,
            phonetic: fields.phonetic,
            example: fields.example,
            note: fields.note,
          })
        : item,
    ),
  );
}

export function deleteVocabularyItem(id: string) {
  writeJsonArray(
    VOCABULARY_KEY,
    getStoredVocabularyItems().filter((item) => item.id !== id),
  );
}

export function getFavoriteSentences(): FavoriteSentence[] {
  return sortByCreatedAtDesc(getStoredFavoriteSentences());
}

export function addFavoriteSentence(
  item: Omit<FavoriteSentence, 'id' | 'createdAt'>,
) {
  const existingItems = getStoredFavoriteSentences();
  const duplicate = existingItems.find(
    (existingItem) => existingItem.sentenceId === item.sentenceId,
  );

  if (duplicate) {
    return { added: false, item: duplicate };
  }

  const nextItem: FavoriteSentence = {
    ...item,
    id: generateDocumentId(),
    createdAt: new Date().toISOString(),
  };

  writeJsonArray(FAVORITES_KEY, [nextItem, ...existingItems]);
  return { added: true, item: nextItem };
}

export function updateFavoriteNote(id: string, note: string) {
  writeJsonArray(
    FAVORITES_KEY,
    getStoredFavoriteSentences().map((item) =>
      item.id === id ? { ...item, note: note.trim() || undefined } : item,
    ),
  );
}

export function deleteFavoriteSentence(id: string) {
  writeJsonArray(
    FAVORITES_KEY,
    getStoredFavoriteSentences().filter((item) => item.id !== id),
  );
}

function mergeById<T extends { id: string }>(
  existing: T[],
  imported: T[],
  regenerate: (item: T) => T,
) {
  const usedIds = new Set(existing.map((item) => item.id));
  const importedItems = imported.map((item) => {
    if (!usedIds.has(item.id)) {
      usedIds.add(item.id);
      return item;
    }

    const nextItem = regenerate(item);
    usedIds.add(nextItem.id);
    return nextItem;
  });

  return [...importedItems, ...existing];
}

function mergeFoldersWithIdMap(existing: Folder[], imported: Folder[]) {
  const usedIds = new Set(existing.map((folder) => folder.id));
  const idMap = new Map<string, string>();
  const importedFolders = imported.map((folder) => {
    const normalizedFolder = normalizeFolder(folder);

    if (!usedIds.has(normalizedFolder.id)) {
      usedIds.add(normalizedFolder.id);
      idMap.set(folder.id, normalizedFolder.id);
      return normalizedFolder;
    }

    const nextId = generateDocumentId();
    usedIds.add(nextId);
    idMap.set(folder.id, nextId);

    return {
      ...normalizedFolder,
      id: nextId,
    };
  });

  return {
    folders: sortByCreatedAtDesc([...importedFolders, ...existing]),
    idMap,
  };
}

function mergeDocumentsWithIdMap(existing: Document[], imported: Document[]) {
  const usedIds = new Set(existing.map((document) => document.id));
  const idMap = new Map<string, string>();
  const sentenceIdMap = new Map<string, string>();
  const importedDocuments = imported.map((document) => {
    const normalizedDocument = normalizeDocument(document);

    if (!usedIds.has(normalizedDocument.id)) {
      usedIds.add(normalizedDocument.id);
      idMap.set(document.id, normalizedDocument.id);
      normalizedDocument.sentences.forEach((sentence) => {
        sentenceIdMap.set(sentence.id, sentence.id);
      });
      return normalizedDocument;
    }

    const nextId = generateDocumentId();
    usedIds.add(nextId);
    idMap.set(document.id, nextId);

    const sentences: Sentence[] = normalizedDocument.sentences.map((sentence) => {
      const nextSentenceId = generateDocumentId();
      sentenceIdMap.set(sentence.id, nextSentenceId);
      return {
        ...sentence,
        id: nextSentenceId,
      };
    });
    const sentenceByOldId = new Map(
      sentences.map((sentence, index) => [
        normalizedDocument.sentences[index]?.id,
        sentence,
      ]),
    );

    return {
      ...normalizedDocument,
      id: nextId,
      sentences,
      paragraphs: normalizedDocument.paragraphs?.map((paragraph) => ({
        id: generateDocumentId(),
        sentences: paragraph.sentences
          .map((sentence) => sentenceByOldId.get(sentence.id))
          .filter((sentence): sentence is Sentence => Boolean(sentence)),
      })),
    };
  });

  return {
    documents: sortByCreatedAtDesc([...importedDocuments, ...existing]),
    idMap,
    sentenceIdMap,
  };
}

export function mergeDocuments(
  existing: Document[],
  imported: Document[],
): Document[] {
  return sortByCreatedAtDesc(
    mergeById(
      existing.map(normalizeDocument),
      imported.map(normalizeDocument),
      (document) => ({
        ...document,
        id: generateDocumentId(),
        ...(() => {
          const sentenceMap = new Map<string, Sentence>();
          const sentences = document.sentences.map((sentence) => {
            const nextSentence = {
              ...sentence,
              id: generateDocumentId(),
            };
            sentenceMap.set(sentence.id, nextSentence);
            return nextSentence;
          });

          return {
            sentences,
            paragraphs: document.paragraphs?.map((paragraph) => ({
              id: generateDocumentId(),
              sentences: paragraph.sentences
                .map((sentence) => sentenceMap.get(sentence.id))
                .filter((sentence): sentence is Sentence => Boolean(sentence)),
            })),
          };
        })(),
      }),
    ),
  );
}

export function importDocuments(documents: Document[]) {
  const nextDocuments = mergeDocuments(getStoredDocuments(), documents);
  writeJsonArray(DOCUMENTS_KEY, nextDocuments);
  return nextDocuments;
}

export function exportDocuments(): LibraryExportV3 {
  return {
    version: 3,
    exportedAt: new Date().toISOString(),
    documents: getDocuments(),
    folders: getFolders(),
    vocabularyItems: getVocabularyItems(),
    favoriteSentences: getFavoriteSentences(),
  };
}

export function importLibrary(libraryExport: LibraryExport) {
  if (libraryExport.version === 2 || libraryExport.version === 3) {
    const folderMerge = mergeFoldersWithIdMap(
      getStoredFolders(),
      libraryExport.folders,
    );
    const documentsWithMappedFolders = libraryExport.documents.map((document) =>
      normalizeDocument({
        ...document,
        folderId: document.folderId
          ? folderMerge.idMap.get(document.folderId) ?? document.folderId
          : undefined,
      }),
    );
    const documentMerge = mergeDocumentsWithIdMap(
      getStoredDocuments(),
      documentsWithMappedFolders,
    );
    const nextVocabularyItems = sortByCreatedAtDesc(
      mergeById(
        getStoredVocabularyItems(),
        libraryExport.vocabularyItems.map((item) =>
          normalizeVocabularyItem({
            ...item,
            documentId:
              documentMerge.idMap.get(item.documentId) ?? item.documentId,
            sentenceId:
              documentMerge.sentenceIdMap.get(item.sentenceId) ??
              item.sentenceId,
          }),
        ),
        (item) => ({
          ...item,
          id: generateDocumentId(),
        }),
      ),
    );
    const nextFavoriteSentences = sortByCreatedAtDesc(
      mergeById(
        getStoredFavoriteSentences(),
        libraryExport.favoriteSentences.map((item) => ({
          ...item,
          documentId: documentMerge.idMap.get(item.documentId) ?? item.documentId,
          sentenceId:
            documentMerge.sentenceIdMap.get(item.sentenceId) ?? item.sentenceId,
        })),
        (item) => ({
          ...item,
          id: generateDocumentId(),
        }),
      ),
    );

    writeJsonArray(DOCUMENTS_KEY, documentMerge.documents);
    writeJsonArray(FOLDERS_KEY, folderMerge.folders);
    writeJsonArray(VOCABULARY_KEY, nextVocabularyItems);
    writeJsonArray(FAVORITES_KEY, nextFavoriteSentences);
    return;
  }

  const nextDocuments = mergeDocuments(getStoredDocuments(), libraryExport.documents);
  writeJsonArray(DOCUMENTS_KEY, nextDocuments);
}
