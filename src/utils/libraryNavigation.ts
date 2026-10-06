import type { Document, Folder } from '../types';

const SYSTEM_PREFIX = 'system:';

export type ParsedSystemView = {
  collectionId: string;
  year?: string;
};

export function getSystemDocumentYear(document: Document) {
  return document.title.match(/(?:^|\D)((?:19|20)\d{2})(?:\D|$)/)?.[1];
}

export function getSystemCollectionView(collectionId: string) {
  return `${SYSTEM_PREFIX}${collectionId}`;
}

export function getSystemYearView(collectionId: string, year: string) {
  return `${SYSTEM_PREFIX}${collectionId}:year:${year}`;
}

export function parseSystemView(view: string): ParsedSystemView | null {
  if (!view.startsWith(SYSTEM_PREFIX)) {
    return null;
  }

  const [collectionId, marker, year] = view.slice(SYSTEM_PREFIX.length).split(':');

  if (!collectionId) {
    return null;
  }

  return {
    collectionId,
    year: marker === 'year' && year ? year : undefined,
  };
}

export function getDocumentReturnView(document: Document) {
  if (document.origin === 'system' && document.systemCollectionId) {
    const year = getSystemDocumentYear(document);
    return year
      ? getSystemYearView(document.systemCollectionId, year)
      : getSystemCollectionView(document.systemCollectionId);
  }

  return document.folderId ?? 'unfiled';
}

export function getFolderPath(folderId: string | undefined, folders: Folder[]) {
  if (!folderId) {
    return [];
  }

  const folderById = new Map(folders.map((folder) => [folder.id, folder]));
  const path: Folder[] = [];
  const visited = new Set<string>();
  let currentId: string | undefined = folderId;

  while (currentId && !visited.has(currentId)) {
    visited.add(currentId);
    const folder = folderById.get(currentId);

    if (!folder) {
      break;
    }

    path.unshift(folder);
    currentId = folder.parentId;
  }

  return path;
}
