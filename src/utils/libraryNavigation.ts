import type { Document, Folder } from '../types';

const SYSTEM_PREFIX = 'system:';

export type ParsedSystemView = {
  collectionId: string;
  year?: string;
  group?: SystemDocumentGroup;
};

export type SystemDocumentGroup = 'mock-small' | 'mock-large';

const MOCK_SMALL_DOCUMENT_IDS = new Set([
  'f0d0b9fd-98a5-45a0-a3c0-975d19c157c3',
  '6ffa395b-fa36-4f0f-bdd7-94fed6aad69e',
  '3bc4eb7a-23f5-414b-834b-fd401d2c998f',
  'a88f5192-a71f-476f-9489-167c8f5e6a77',
  'fc9add84-5993-49c7-818b-5e0d0f47fd1c',
  '9249c547-0b6a-41c9-a5db-623a0d74d889',
]);

const MOCK_LARGE_DOCUMENT_IDS = new Set([
  'bc901145-82a5-4138-8975-70015d8f3a35',
  'f850c265-1c5d-4508-b90b-4da0bff2406a',
  'c42827eb-d0a1-4b40-85ed-b010a2a056e6',
  'f78915da-57e5-4dbe-a103-7dab0b654f96',
  '015a7c73-e695-455e-91f2-614330c31d4c',
  '94930d76-65b4-4990-9abc-895b541b4f53',
  '46d1cf0d-aca3-4777-8752-fc928fa8a615',
  '55f5ba9e-8e81-4bfd-9432-e82ed8b4304f',
  '8703cbe6-ec03-4368-8967-1c45b1ca5703',
  '4ab57fd9-5d91-43a1-a5e4-a8af331a4a32',
]);

export function getSystemDocumentYear(document: Document) {
  return document.title.match(/(?:^|\D)((?:19|20)\d{2})(?:\D|$)/)?.[1];
}

export function getSystemDocumentGroup(
  document: Document,
): SystemDocumentGroup | undefined {
  if (document.systemGroup) {
    return document.systemGroup;
  }

  if (MOCK_SMALL_DOCUMENT_IDS.has(document.id)) {
    return 'mock-small';
  }

  if (MOCK_LARGE_DOCUMENT_IDS.has(document.id)) {
    return 'mock-large';
  }

  return undefined;
}

export function getSystemCollectionView(collectionId: string) {
  return `${SYSTEM_PREFIX}${collectionId}`;
}

export function getSystemYearView(collectionId: string, year: string) {
  return `${SYSTEM_PREFIX}${collectionId}:year:${year}`;
}

export function getSystemGroupView(
  collectionId: string,
  group: SystemDocumentGroup,
) {
  return `${SYSTEM_PREFIX}${collectionId}:group:${group}`;
}

export function parseSystemView(view: string): ParsedSystemView | null {
  if (!view.startsWith(SYSTEM_PREFIX)) {
    return null;
  }

  const [collectionId, marker, value] = view
    .slice(SYSTEM_PREFIX.length)
    .split(':');

  if (!collectionId) {
    return null;
  }

  return {
    collectionId,
    year: marker === 'year' && value ? value : undefined,
    group:
      marker === 'group' &&
      (value === 'mock-small' || value === 'mock-large')
        ? value
        : undefined,
  };
}

export function getDocumentReturnView(document: Document) {
  if (document.origin === 'system' && document.systemCollectionId) {
    const year = getSystemDocumentYear(document);
    if (year) {
      return getSystemYearView(document.systemCollectionId, year);
    }

    const group = getSystemDocumentGroup(document);
    return group
      ? getSystemGroupView(document.systemCollectionId, group)
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
