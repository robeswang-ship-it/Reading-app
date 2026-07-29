import { useCallback, useEffect, useRef, useState } from 'react';
import {
  CloudLibraryError,
  downloadCloudLibrary,
  fetchCloudLibrary,
  initializeCloudLibrary,
  uploadLocalLibrary,
} from '../services/cloudLibraryService';
import { LIBRARY_CHANGED_EVENT } from '../utils/storage';

export type CloudSyncState =
  | 'connecting'
  | 'synced'
  | 'syncing'
  | 'conflict'
  | 'schema-missing'
  | 'error';

export type CloudSyncView = {
  state: CloudSyncState;
  message: string;
  lastSyncedAt?: string;
};

const AUTO_SYNC_DELAY_MS = 2_000;

function getErrorState(error: unknown): CloudSyncView {
  if (
    error instanceof CloudLibraryError &&
    error.code === 'CLOUD_CONFLICT'
  ) {
    return {
      state: 'conflict',
      message: error.message,
    };
  }

  if (
    error instanceof CloudLibraryError &&
    error.code === 'SCHEMA_MISSING'
  ) {
    return {
      state: 'schema-missing',
      message: error.message,
    };
  }

  return {
    state: 'error',
    message:
      error instanceof Error
        ? error.message
        : 'Cloud sync failed. Local data is still safe.',
  };
}

export function useCloudLibrarySync(
  userId: string | undefined,
  onLibraryReplaced: () => void,
) {
  const [view, setView] = useState<CloudSyncView>({
    state: 'connecting',
    message: 'Connecting to cloud storage...',
  });
  const autoSyncTimerRef = useRef<number | null>(null);
  const isReadyRef = useRef(false);

  const markSynced = useCallback((message: string) => {
    setView({
      state: 'synced',
      message,
      lastSyncedAt: new Date().toISOString(),
    });
  }, []);

  const uploadThisDevice = useCallback(async () => {
    if (!userId) {
      return;
    }

    setView({ state: 'syncing', message: 'Uploading this device...' });

    try {
      await uploadLocalLibrary(userId);
      isReadyRef.current = true;
      markSynced('This device is synced to Supabase.');
    } catch (error) {
      setView(getErrorState(error));
    }
  }, [markSynced, userId]);

  const overwriteCloudWithThisDevice = useCallback(async () => {
    if (!userId) {
      return;
    }

    setView({ state: 'syncing', message: 'Replacing the cloud copy...' });

    try {
      await uploadLocalLibrary(userId, { force: true });
      isReadyRef.current = true;
      markSynced('The cloud copy was replaced by this device.');
    } catch (error) {
      setView(getErrorState(error));
    }
  }, [markSynced, userId]);

  const useCloudCopy = useCallback(async () => {
    if (!userId) {
      return;
    }

    setView({ state: 'syncing', message: 'Downloading cloud library...' });

    try {
      const cloud = await fetchCloudLibrary(userId);

      if (!cloud) {
        await uploadLocalLibrary(userId);
        markSynced('Cloud library created from this device.');
      } else {
        downloadCloudLibrary(userId, cloud);
        onLibraryReplaced();
        markSynced('Cloud library downloaded to this device.');
      }

      isReadyRef.current = true;
    } catch (error) {
      setView(getErrorState(error));
    }
  }, [markSynced, onLibraryReplaced, userId]);

  const retry = useCallback(async () => {
    if (!userId) {
      return;
    }

    isReadyRef.current = false;
    setView({ state: 'connecting', message: 'Connecting to cloud storage...' });

    try {
      const result = await initializeCloudLibrary(userId);

      if (result.kind === 'conflict') {
        setView({
          state: 'conflict',
          message:
            'Both this device and Supabase contain data. Choose which copy to keep.',
        });
        return;
      }

      if (result.kind === 'downloaded') {
        onLibraryReplaced();
      }

      isReadyRef.current = true;
      markSynced(
        result.kind === 'uploaded'
          ? 'This device was uploaded to Supabase.'
          : result.kind === 'downloaded'
            ? 'Cloud library was downloaded to this device.'
            : 'Library is synced.',
      );
    } catch (error) {
      setView(getErrorState(error));
    }
  }, [markSynced, onLibraryReplaced, userId]);

  useEffect(() => {
    if (!userId) {
      isReadyRef.current = false;
      return;
    }

    retry();

    return () => {
      isReadyRef.current = false;

      if (autoSyncTimerRef.current !== null) {
        window.clearTimeout(autoSyncTimerRef.current);
      }
    };
  }, [retry, userId]);

  useEffect(() => {
    const handleLibraryChange = () => {
      if (!userId || !isReadyRef.current) {
        return;
      }

      if (autoSyncTimerRef.current !== null) {
        window.clearTimeout(autoSyncTimerRef.current);
      }

      setView({ state: 'syncing', message: 'Saving changes to Supabase...' });
      autoSyncTimerRef.current = window.setTimeout(() => {
        uploadThisDevice();
      }, AUTO_SYNC_DELAY_MS);
    };

    window.addEventListener(LIBRARY_CHANGED_EVENT, handleLibraryChange);
    return () =>
      window.removeEventListener(LIBRARY_CHANGED_EVENT, handleLibraryChange);
  }, [uploadThisDevice, userId]);

  return {
    view,
    retry,
    uploadThisDevice,
    overwriteCloudWithThisDevice,
    useCloudCopy,
  };
}
