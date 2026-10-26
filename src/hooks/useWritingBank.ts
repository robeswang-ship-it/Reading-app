import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import {
  fetchWritingBank,
  saveWritingItemState,
} from '../services/writingBankService';
import type { WritingItem, WritingItemState } from '../types';

export type WritingBankView = {
  state: 'idle' | 'loading' | 'ready' | 'error';
  message: string;
};

export function useWritingBank(
  userId: string | undefined,
  enabled: boolean,
) {
  const [items, setItems] = useState<WritingItem[]>([]);
  const [states, setStates] = useState<WritingItemState[]>([]);
  const [view, setView] = useState<WritingBankView>({
    state: 'idle',
    message: '',
  });
  const stateByItemIdRef = useRef(new Map<string, WritingItemState>());
  const saveQueueByItemIdRef = useRef(new Map<string, Promise<void>>());

  const load = useCallback(async () => {
    if (!userId || !enabled) {
      return;
    }

    setView({ state: 'loading', message: 'Loading Writing Bank...' });

    try {
      const data = await fetchWritingBank(userId);
      setItems(data.items);
      setStates(data.states);
      stateByItemIdRef.current = new Map(
        data.states.map((state) => [state.itemId, state]),
      );
      setView({
        state: 'ready',
        message: `${data.items.length} shared writing item(s) available.`,
      });
    } catch (error) {
      setView({
        state: 'error',
        message:
          error instanceof Error
            ? error.message
            : 'Writing Bank could not be loaded.',
      });
    }
  }, [enabled, userId]);

  useEffect(() => {
    void load();
  }, [load]);

  const stateByItemId = useMemo(
    () => new Map(states.map((state) => [state.itemId, state])),
    [states],
  );

  const updateState = useCallback(
    async (itemId: string, fields: Partial<WritingItemState>) => {
      if (!userId) {
        return;
      }

      const previous = stateByItemIdRef.current.get(itemId) ?? {
          itemId,
          inFocusList: false,
        };
      const nextState: WritingItemState = {
        ...previous,
        ...fields,
        itemId,
      };
      stateByItemIdRef.current.set(itemId, nextState);

      setStates((current) => {
        const withoutCurrent = current.filter((state) => state.itemId !== itemId);
        return [...withoutCurrent, nextState];
      });

      const previousSave =
        saveQueueByItemIdRef.current.get(itemId) ?? Promise.resolve();
      const nextSave = previousSave
        .catch(() => undefined)
        .then(() => saveWritingItemState(userId, nextState));
      saveQueueByItemIdRef.current.set(itemId, nextSave);

      try {
        await nextSave;
        if (saveQueueByItemIdRef.current.get(itemId) === nextSave) {
          saveQueueByItemIdRef.current.delete(itemId);
        }
      } catch (error) {
        setView({
          state: 'error',
          message:
            error instanceof Error
              ? `Writing Bank progress was not saved: ${error.message}`
              : 'Writing Bank progress was not saved.',
        });
      }
    },
    [userId],
  );

  return {
    items,
    states,
    stateByItemId,
    view,
    reload: load,
    updateState,
  };
}
