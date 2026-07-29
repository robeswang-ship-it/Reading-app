import type { LibraryExportV3 } from '../types';
import {
  exportDocuments,
  getLocalLibraryModifiedAt,
  hasLocalLibraryData,
  isLibraryExport,
  replaceLibrary,
} from '../utils/storage';
import { supabase } from './supabaseClient';

const SYNC_METADATA_PREFIX = 'ai-intensive-reading:cloud-sync:';
const LOCAL_LIBRARY_OWNER_KEY = 'ai-intensive-reading:local-owner-id';

type CloudLibraryRow = {
  library_data: unknown;
  revision: number;
  updated_at: string;
};

type SyncMetadata = {
  lastSyncedAt: string;
  remoteUpdatedAt: string;
  remoteRevision: number;
};

export type CloudLibrary = {
  library: LibraryExportV3;
  revision: number;
  updatedAt: string;
};

export type InitialSyncDecision =
  | { kind: 'uploaded'; cloud: CloudLibrary }
  | { kind: 'downloaded'; cloud: CloudLibrary }
  | { kind: 'synced'; cloud: CloudLibrary }
  | { kind: 'conflict'; cloud: CloudLibrary };

export class CloudLibraryError extends Error {
  code?: string;

  constructor(message: string, code?: string) {
    super(message);
    this.name = 'CloudLibraryError';
    this.code = code;
  }
}

function getSyncMetadataKey(userId: string) {
  return `${SYNC_METADATA_PREFIX}${userId}`;
}

function readSyncMetadata(userId: string): SyncMetadata | null {
  const rawValue = window.localStorage.getItem(getSyncMetadataKey(userId));

  if (!rawValue) {
    return null;
  }

  try {
    const value: unknown = JSON.parse(rawValue);

    if (
      typeof value === 'object' &&
      value !== null &&
      'lastSyncedAt' in value &&
      'remoteUpdatedAt' in value &&
      'remoteRevision' in value &&
      typeof value.lastSyncedAt === 'string' &&
      typeof value.remoteUpdatedAt === 'string' &&
      typeof value.remoteRevision === 'number'
    ) {
      return value as SyncMetadata;
    }
  } catch {
    return null;
  }

  return null;
}

function writeSyncMetadata(userId: string, cloud: CloudLibrary) {
  const metadata: SyncMetadata = {
    lastSyncedAt: new Date().toISOString(),
    remoteUpdatedAt: cloud.updatedAt,
    remoteRevision: cloud.revision,
  };

  window.localStorage.setItem(
    getSyncMetadataKey(userId),
    JSON.stringify(metadata),
  );
  window.localStorage.setItem(LOCAL_LIBRARY_OWNER_KEY, userId);
}

function getLocalLibraryOwner() {
  return window.localStorage.getItem(LOCAL_LIBRARY_OWNER_KEY);
}

function createEmptyLibrary(): LibraryExportV3 {
  return {
    version: 3,
    exportedAt: new Date().toISOString(),
    documents: [],
    folders: [],
    vocabularyItems: [],
    favoriteSentences: [],
  };
}

function parseCloudLibrary(row: CloudLibraryRow): CloudLibrary {
  if (!isLibraryExport(row.library_data) || row.library_data.version !== 3) {
    throw new CloudLibraryError(
      'Cloud library data is invalid or uses an unsupported version.',
      'INVALID_CLOUD_DATA',
    );
  }

  return {
    library: row.library_data,
    revision: row.revision,
    updatedAt: row.updated_at,
  };
}

function throwCloudError(error: { code?: string; message: string }) {
  const isMissingTable =
    error.code === '42P01' ||
    error.code === 'PGRST205' ||
    error.message.includes('reading_libraries');

  throw new CloudLibraryError(
    isMissingTable
      ? 'Cloud storage is not set up yet. Run the Supabase migration first.'
      : error.message,
    isMissingTable ? 'SCHEMA_MISSING' : error.code,
  );
}

export async function fetchCloudLibrary(
  userId: string,
): Promise<CloudLibrary | null> {
  const { data, error } = await supabase
    .from('reading_libraries')
    .select('library_data, revision, updated_at')
    .eq('user_id', userId)
    .maybeSingle();

  if (error) {
    throwCloudError(error);
  }

  return data ? parseCloudLibrary(data as CloudLibraryRow) : null;
}

export async function uploadLocalLibrary(
  userId: string,
  options: { force?: boolean } = {},
): Promise<CloudLibrary> {
  const currentCloud = await fetchCloudLibrary(userId);
  const metadata = readSyncMetadata(userId);

  if (
    currentCloud &&
    !options.force &&
    metadata &&
    currentCloud.revision !== metadata.remoteRevision
  ) {
    throw new CloudLibraryError(
      'The cloud library changed on another device. Choose which copy to keep.',
      'CLOUD_CONFLICT',
    );
  }

  const nextRevision = (currentCloud?.revision ?? 0) + 1;
  const library = exportDocuments();
  const values = {
    user_id: userId,
    library_data: library,
    revision: nextRevision,
  };
  const query =
    currentCloud && !options.force
      ? supabase
          .from('reading_libraries')
          .update(values)
          .eq('user_id', userId)
          .eq('revision', currentCloud.revision)
      : supabase
          .from('reading_libraries')
          .upsert(values, { onConflict: 'user_id' });
  const { data, error } = await query
    .select('library_data, revision, updated_at')
    .single();

  if (error) {
    if (error.code === 'PGRST116' || error.code === '23505') {
      throw new CloudLibraryError(
        'The cloud library changed on another device. Choose which copy to keep.',
        'CLOUD_CONFLICT',
      );
    }

    throwCloudError(error);
  }

  const cloud = parseCloudLibrary(data as CloudLibraryRow);
  writeSyncMetadata(userId, cloud);
  return cloud;
}

export function downloadCloudLibrary(userId: string, cloud: CloudLibrary) {
  replaceLibrary(cloud.library);
  writeSyncMetadata(userId, cloud);
}

export async function initializeCloudLibrary(
  userId: string,
): Promise<InitialSyncDecision> {
  const cloud = await fetchCloudLibrary(userId);
  const localOwner = getLocalLibraryOwner();

  if (localOwner && localOwner !== userId) {
    if (cloud) {
      downloadCloudLibrary(userId, cloud);
      return { kind: 'downloaded', cloud };
    }

    replaceLibrary(createEmptyLibrary());
    const uploadedCloud = await uploadLocalLibrary(userId);
    return { kind: 'uploaded', cloud: uploadedCloud };
  }

  if (!cloud) {
    const uploadedCloud = await uploadLocalLibrary(userId);
    return { kind: 'uploaded', cloud: uploadedCloud };
  }

  if (!hasLocalLibraryData()) {
    downloadCloudLibrary(userId, cloud);
    return { kind: 'downloaded', cloud };
  }

  const metadata = readSyncMetadata(userId);

  if (!metadata) {
    return { kind: 'conflict', cloud };
  }

  const localModifiedAt = getLocalLibraryModifiedAt();
  const hasUnsyncedLocalChanges =
    localModifiedAt !== null &&
    new Date(localModifiedAt).getTime() >
      new Date(metadata.lastSyncedAt).getTime();
  const cloudChanged =
    new Date(cloud.updatedAt).getTime() >
    new Date(metadata.remoteUpdatedAt).getTime();

  if (hasUnsyncedLocalChanges) {
    const uploadedCloud = await uploadLocalLibrary(userId);
    return { kind: 'uploaded', cloud: uploadedCloud };
  }

  if (cloudChanged) {
    downloadCloudLibrary(userId, cloud);
    return { kind: 'downloaded', cloud };
  }

  writeSyncMetadata(userId, cloud);
  return { kind: 'synced', cloud };
}
