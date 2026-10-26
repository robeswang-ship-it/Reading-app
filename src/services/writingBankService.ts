import type {
  WritingExampleReference,
  WritingExampleSentence,
  WritingItem,
  WritingItemState,
  WritingPhrase,
  WritingSentencePattern,
} from '../types';
import { supabase } from './supabaseClient';

type WritingItemRow = {
  id: string;
  item_type: WritingItem['type'];
  item_data: unknown;
};

type WritingItemStateRow = {
  item_id: string;
  in_focus_list: boolean;
  note: string | null;
  updated_at: string;
};

export type WritingBankData = {
  items: WritingItem[];
  states: WritingItemState[];
};

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === 'object' && value !== null && !Array.isArray(value);
}

function isStringArray(value: unknown): value is string[] {
  return Array.isArray(value) && value.every((entry) => typeof entry === 'string');
}

function isWritingExampleReference(
  value: unknown,
): value is WritingExampleReference {
  return (
    isRecord(value) &&
    typeof value.essayId === 'string' &&
    typeof value.sentenceId === 'string' &&
    typeof value.sentenceText === 'string' &&
    typeof value.translation === 'string'
  );
}

function hasCommonItemFields(
  value: Record<string, unknown>,
  id: string,
  type: WritingItem['type'],
) {
  return (
    value.id === id &&
    value.type === type &&
    Array.isArray(value.tags) &&
    value.tags.every((tag) => typeof tag === 'string')
  );
}

function isWritingPhrase(
  value: unknown,
  id: string,
): value is WritingPhrase {
  if (!isRecord(value) || !hasCommonItemFields(value, id, 'phrase')) {
    return false;
  }

  return (
    typeof value.text === 'string' &&
    (value.phraseType === 'verb_phrase' ||
      value.phraseType === 'noun_phrase' ||
      value.phraseType === 'other_phrase') &&
    typeof value.meaning === 'string' &&
    (value.priority === 'P1' ||
      value.priority === 'P2' ||
      value.priority === 'P3') &&
    Array.isArray(value.examples) &&
    value.examples.every(isWritingExampleReference)
  );
}

function isWritingSentencePattern(
  value: unknown,
  id: string,
): value is WritingSentencePattern {
  if (
    !isRecord(value) ||
    !hasCommonItemFields(value, id, 'sentence_pattern')
  ) {
    return false;
  }

  return (
    typeof value.pattern === 'string' &&
    typeof value.function === 'string' &&
    Array.isArray(value.examples) &&
    value.examples.every(isWritingExampleReference)
  );
}

function isWritingExampleSentence(
  value: unknown,
  id: string,
): value is WritingExampleSentence {
  if (
    !isRecord(value) ||
    !hasCommonItemFields(value, id, 'example_sentence')
  ) {
    return false;
  }

  return (
    typeof value.text === 'string' &&
    typeof value.translation === 'string' &&
    typeof value.essayId === 'string' &&
    typeof value.sentenceId === 'string' &&
    isStringArray(value.relatedPhraseIds) &&
    isStringArray(value.relatedPatternIds)
  );
}

function parseWritingItem(row: WritingItemRow): WritingItem | null {
  if (row.item_type === 'phrase' && isWritingPhrase(row.item_data, row.id)) {
    return row.item_data;
  }

  if (
    row.item_type === 'sentence_pattern' &&
    isWritingSentencePattern(row.item_data, row.id)
  ) {
    return row.item_data;
  }

  if (
    row.item_type === 'example_sentence' &&
    isWritingExampleSentence(row.item_data, row.id)
  ) {
    return row.item_data;
  }

  return null;
}

function getWritingBankError(message: string) {
  return message.includes('system_writing_items') ||
    message.includes('user_system_writing_item_states')
    ? 'Writing Bank is not set up yet. Run the Supabase writing-bank migration.'
    : message;
}

export async function fetchWritingBank(
  userId: string,
): Promise<WritingBankData> {
  const [itemsResult, statesResult] = await Promise.all([
    supabase
      .from('system_writing_items')
      .select('id, item_type, item_data')
      .eq('is_published', true)
      .order('item_type')
      .order('sort_order'),
    supabase
      .from('user_system_writing_item_states')
      .select('item_id, in_focus_list, note, updated_at')
      .eq('user_id', userId),
  ]);

  if (itemsResult.error) {
    throw new Error(getWritingBankError(itemsResult.error.message));
  }

  if (statesResult.error) {
    throw new Error(getWritingBankError(statesResult.error.message));
  }

  const rows = (itemsResult.data ?? []) as WritingItemRow[];
  const items = rows.flatMap((row) => {
    const item = parseWritingItem(row);
    return item ? [item] : [];
  });

  if (items.length !== rows.length) {
    throw new Error('Writing Bank contains invalid or unsupported content.');
  }

  const states = ((statesResult.data ?? []) as WritingItemStateRow[]).map(
    (row) => ({
      itemId: row.item_id,
      inFocusList: row.in_focus_list,
      note: row.note?.trim() || undefined,
      updatedAt: row.updated_at,
    }),
  );

  return { items, states };
}

export async function saveWritingItemState(
  userId: string,
  state: WritingItemState,
) {
  if (!state.inFocusList && !state.note?.trim()) {
    const { error } = await supabase
      .from('user_system_writing_item_states')
      .delete()
      .eq('user_id', userId)
      .eq('item_id', state.itemId);

    if (error) {
      throw new Error(getWritingBankError(error.message));
    }
    return;
  }

  const { error } = await supabase
    .from('user_system_writing_item_states')
    .upsert(
      {
        user_id: userId,
        item_id: state.itemId,
        in_focus_list: state.inFocusList,
        note: state.note?.trim() || null,
      },
      { onConflict: 'user_id,item_id' },
    );

  if (error) {
    throw new Error(getWritingBankError(error.message));
  }
}
