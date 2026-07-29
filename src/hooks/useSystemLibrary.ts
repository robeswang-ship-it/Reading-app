import { useCallback, useEffect, useRef, useState } from 'react';
import {
  fetchSystemLibrary,
  saveSystemDocumentState,
} from '../services/systemLibraryService';
import type {
  Document,
  SystemCollection,
  SystemDocumentState,
} from '../types';

export type SystemLibraryView = {
  state: 'loading' | 'ready' | 'error';
  message: string;
};

export function useSystemLibrary(userId: string | undefined) {
  const [collections, setCollections] = useState<SystemCollection[]>([]);
  const [documents, setDocuments] = useState<Document[]>([]);
  const [view, setView] = useState<SystemLibraryView>({
    state: 'loading',
    message: 'Loading System Library...',
  });
  const stateByDocumentIdRef = useRef(
    new Map<string, SystemDocumentState>(),
  );
  const saveTimersRef = useRef(new Map<string, number>());

  const load = useCallback(async () => {
    if (!userId) {
      setCollections([]);
      setDocuments([]);
      return;
    }

    setView({ state: 'loading', message: 'Loading System Library...' });

    try {
      const data = await fetchSystemLibrary(userId);
      setCollections(data.collections);
      setDocuments(data.documents);
      stateByDocumentIdRef.current = new Map(
        data.states.map((state) => [state.documentId, state]),
      );
      setView({
        state: 'ready',
        message:
          data.documents.length > 0
            ? `${data.documents.length} shared document(s) available.`
            : 'System Library is ready. No shared documents are published yet.',
      });
    } catch (error) {
      setView({
        state: 'error',
        message:
          error instanceof Error
            ? error.message
            : 'System Library could not be loaded.',
      });
    }
  }, [userId]);

  useEffect(() => {
    const saveTimers = saveTimersRef.current;
    load();

    return () => {
      saveTimers.forEach((timer) => window.clearTimeout(timer));
      saveTimers.clear();
    };
  }, [load]);

  const persistState = useCallback(
    (documentId: string, nextState: SystemDocumentState) => {
      if (!userId) {
        return;
      }

      const currentTimer = saveTimersRef.current.get(documentId);

      if (currentTimer !== undefined) {
        window.clearTimeout(currentTimer);
      }

      const timer = window.setTimeout(async () => {
        try {
          await saveSystemDocumentState(userId, nextState);
          saveTimersRef.current.delete(documentId);
        } catch (error) {
          setView({
            state: 'error',
            message:
              error instanceof Error
                ? `System progress sync failed: ${error.message}`
                : 'System progress sync failed.',
          });
        }
      }, 600);

      saveTimersRef.current.set(documentId, timer);
    },
    [userId],
  );

  const updateProgress = useCallback(
    (documentId: string, currentSentenceIndex: number) => {
      const currentState = stateByDocumentIdRef.current.get(documentId) ?? {
        documentId,
        currentSentenceIndex: 0,
        sentenceNotes: {},
      };
      const nextState = { ...currentState, currentSentenceIndex };

      stateByDocumentIdRef.current.set(documentId, nextState);
      setDocuments((currentDocuments) =>
        currentDocuments.map((document) =>
          document.id === documentId
            ? { ...document, currentSentenceIndex }
            : document,
        ),
      );
      persistState(documentId, nextState);
    },
    [persistState],
  );

  const updateSentenceNote = useCallback(
    (documentId: string, sentenceId: string, note: string) => {
      const currentState = stateByDocumentIdRef.current.get(documentId) ?? {
        documentId,
        currentSentenceIndex: 0,
        sentenceNotes: {},
      };
      const sentenceNotes = { ...currentState.sentenceNotes };

      if (note.trim()) {
        sentenceNotes[sentenceId] = note.trim();
      } else {
        delete sentenceNotes[sentenceId];
      }

      const nextState = { ...currentState, sentenceNotes };
      stateByDocumentIdRef.current.set(documentId, nextState);
      setDocuments((currentDocuments) =>
        currentDocuments.map((document) =>
          document.id === documentId
            ? {
                ...document,
                sentences: document.sentences.map((sentence) =>
                  sentence.id === sentenceId
                    ? { ...sentence, userNote: note.trim() || undefined }
                    : sentence,
                ),
              }
            : document,
        ),
      );
      persistState(documentId, nextState);
    },
    [persistState],
  );

  return {
    collections,
    documents,
    view,
    reload: load,
    updateProgress,
    updateSentenceNote,
  };
}
