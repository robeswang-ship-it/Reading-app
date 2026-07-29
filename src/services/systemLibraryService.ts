import type {
  Document,
  SystemCollection,
  SystemDocumentState,
} from '../types';
import { isDocument } from '../utils/storage';
import { supabase } from './supabaseClient';

type CollectionRow = {
  id: string;
  slug: string;
  title: string;
  description: string | null;
  sort_order: number;
};

type DocumentRow = {
  id: string;
  collection_id: string;
  title: string;
  source_text: string;
  document_data: unknown;
  sort_order: number;
  created_at: string;
};

type StateRow = {
  document_id: string;
  current_sentence_index: number;
  sentence_notes: unknown;
  updated_at: string;
};

export type SystemLibraryData = {
  collections: SystemCollection[];
  documents: Document[];
  states: SystemDocumentState[];
};

function normalizeSentenceNotes(value: unknown): Record<string, string> {
  if (typeof value !== 'object' || value === null || Array.isArray(value)) {
    return {};
  }

  return Object.fromEntries(
    Object.entries(value).filter(
      (entry): entry is [string, string] => typeof entry[1] === 'string',
    ),
  );
}

function getMissingSchemaMessage(message: string) {
  return message.includes('system_collections') ||
    message.includes('system_documents') ||
    message.includes('user_system_document_states')
    ? 'System Library is not set up yet. Run the Supabase system-library migration.'
    : message;
}

async function fetchRows<T>(
  promise: PromiseLike<{ data: T[] | null; error: { message: string } | null }>,
) {
  const { data, error } = await promise;

  if (error) {
    throw new Error(getMissingSchemaMessage(error.message));
  }

  return data ?? [];
}

export async function fetchSystemLibrary(
  userId: string,
): Promise<SystemLibraryData> {
  const [collectionRows, documentRows, stateRows] = await Promise.all([
      fetchRows<CollectionRow>(
        supabase
          .from('system_collections')
          .select('id, slug, title, description, sort_order')
          .order('sort_order')
          .order('title'),
      ),
      fetchRows<DocumentRow>(
        supabase
          .from('system_documents')
          .select(
            'id, collection_id, title, source_text, document_data, sort_order, created_at',
          )
          .order('sort_order')
          .order('created_at'),
      ),
      fetchRows<StateRow>(
        supabase
          .from('user_system_document_states')
          .select(
            'document_id, current_sentence_index, sentence_notes, updated_at',
          )
          .eq('user_id', userId),
      ),
    ]);

  const collections = collectionRows.map((row) => ({
    id: row.id,
    slug: row.slug,
    title: row.title,
    description: row.description ?? undefined,
    sortOrder: row.sort_order,
  }));
  const states = stateRows.map((row) => ({
    documentId: row.document_id,
    currentSentenceIndex: row.current_sentence_index,
    sentenceNotes: normalizeSentenceNotes(row.sentence_notes),
    updatedAt: row.updated_at,
  }));
  const stateByDocumentId = new Map(
    states.map((state) => [state.documentId, state]),
  );
  const documents = documentRows.flatMap((row) => {
    if (!isDocument(row.document_data)) {
      return [];
    }

    const state = stateByDocumentId.get(row.id);
    const sentences = row.document_data.sentences.map((sentence) => ({
      id: sentence.id,
      text: sentence.text,
      italicRanges: sentence.italicRanges,
      userNote: state?.sentenceNotes[sentence.id],
      aiStatus: 'idle' as const,
    }));
    const sentenceById = new Map(
      sentences.map((sentence) => [sentence.id, sentence]),
    );

    return [
      {
        ...row.document_data,
        id: row.id,
        title: row.title,
        sourceText: row.source_text,
        createdAt: row.created_at,
        sentences,
        paragraphs: row.document_data.paragraphs?.map((paragraph) => ({
          ...paragraph,
          sentences: paragraph.sentences
            .map((sentence) => sentenceById.get(sentence.id))
            .filter((sentence) => sentence !== undefined),
        })),
        currentSentenceIndex: Math.min(
          state?.currentSentenceIndex ?? 0,
          Math.max(sentences.length - 1, 0),
        ),
        folderId: undefined,
        origin: 'system' as const,
        systemCollectionId: row.collection_id,
      },
    ];
  });

  return { collections, documents, states };
}

export async function saveSystemDocumentState(
  userId: string,
  state: SystemDocumentState,
) {
  const { error } = await supabase.from('user_system_document_states').upsert(
    {
      user_id: userId,
      document_id: state.documentId,
      current_sentence_index: state.currentSentenceIndex,
      sentence_notes: state.sentenceNotes,
    },
    { onConflict: 'user_id,document_id' },
  );

  if (error) {
    throw new Error(error.message);
  }
}
