import { readFile } from 'node:fs/promises';
import { resolve } from 'node:path';

const inputPath = resolve(
  process.argv[2] ?? 'content/writing-bank/accumulation-v2.json',
);
const source = JSON.parse(await readFile(inputPath, 'utf8'));

const expectedCounts = {
  phrases: 240,
  sentencePatterns: 40,
  exampleSentences: 100,
  essays: 50,
};

for (const [key, expectedCount] of Object.entries(expectedCounts)) {
  if (!Array.isArray(source[key]) || source[key].length !== expectedCount) {
    throw new Error(
      `${key} must contain exactly ${expectedCount} entries before publishing.`,
    );
  }
}

const essayById = new Map(source.essays.map((essay) => [essay.id, essay]));
const sentenceById = new Map();

for (const essay of source.essays) {
  for (const sentence of essay.sentences) {
    if (sentenceById.has(sentence.id)) {
      throw new Error(`Duplicate essay sentence ID: ${sentence.id}`);
    }

    sentenceById.set(sentence.id, { essay, sentence });
  }
}

function validateSourceReference(reference, label) {
  const linked = sentenceById.get(reference.sentenceId);

  if (!linked || linked.essay.id !== reference.essayId) {
    throw new Error(`${label} has a broken essay or sentence reference.`);
  }

  if (
    linked.sentence.text !== reference.sentenceText ||
    linked.sentence.translation !== reference.translation
  ) {
    throw new Error(`${label} does not match its source sentence.`);
  }
}

for (const item of [...source.phrases, ...source.sentencePatterns]) {
  if (!Array.isArray(item.examples) || item.examples.length === 0) {
    throw new Error(`${item.id} has no source examples.`);
  }

  item.examples.forEach((example) =>
    validateSourceReference(example, `Item ${item.id}`),
  );
}

const selectedExamplesByEssay = new Map();

for (const example of source.exampleSentences) {
  const linked = sentenceById.get(example.sentenceId);

  if (
    !linked ||
    linked.essay.id !== example.essayId ||
    linked.sentence.text !== example.text ||
    linked.sentence.translation !== example.translation
  ) {
    throw new Error(`Selected example ${example.id} has a broken source.`);
  }

  selectedExamplesByEssay.set(
    example.essayId,
    (selectedExamplesByEssay.get(example.essayId) ?? 0) + 1,
  );
}

for (const essayId of essayById.keys()) {
  if (selectedExamplesByEssay.get(essayId) !== 2) {
    throw new Error(`Essay ${essayId} must have exactly two selected examples.`);
  }
}

function sqlLiteral(value) {
  return `'${value.replaceAll("'", "''")}'`;
}

function buildDocument(essay, index) {
  const sentenceById = new Map(
    essay.sentences.map((sentence) => [sentence.id, sentence]),
  );
  const paragraphs = essay.paragraphs.map((paragraph) => ({
    id: paragraph.id,
    sentences: paragraph.sentenceIds.map((sentenceId) => {
      const sentence = sentenceById.get(sentenceId);

      if (!sentence) {
        throw new Error(`Missing sentence ${sentenceId} in ${essay.title}.`);
      }

      return { id: sentence.id, text: sentence.text };
    }),
  }));
  const sentences = paragraphs.flatMap((paragraph) => paragraph.sentences);
  const sourceText = paragraphs
    .map((paragraph) =>
      paragraph.sentences.map((sentence) => sentence.text).join(' '),
    )
    .join('\n\n');

  if (sentences.length !== essay.sentences.length) {
    throw new Error(`Paragraph mapping is incomplete in ${essay.title}.`);
  }

  return {
    id: essay.id,
    title: essay.title,
    sourceText,
    sortOrder: index,
    documentData: {
      id: essay.id,
      title: essay.title,
      createdAt: '2026-10-26T00:00:00.000Z',
      sourceText,
      paragraphs,
      sentences,
      currentSentenceIndex: 0,
      origin: 'system',
    },
  };
}

const documents = source.essays.map(buildDocument);
const itemGroups = [
  ['phrase', source.phrases],
  ['sentence_pattern', source.sentencePatterns],
  ['example_sentence', source.exampleSentences],
];
const items = itemGroups.flatMap(([type, entries]) =>
  entries.map((entry, index) => {
    if (entry.type !== type) {
      throw new Error(`Item ${entry.id} has mismatched type ${entry.type}.`);
    }

    return { id: entry.id, type, data: entry, sortOrder: index };
  }),
);
const allIds = [
  ...documents.map((document) => document.id),
  ...items.map((item) => item.id),
];

if (new Set(allIds).size !== allIds.length) {
  throw new Error('Writing Bank contains duplicate IDs.');
}

const documentValues = documents
  .map(
    (document) => `(
    ${sqlLiteral(document.id)}::uuid,
    (select id from collection),
    ${sqlLiteral(document.title)},
    ${sqlLiteral(document.sourceText)},
    ${sqlLiteral(JSON.stringify(document.documentData))}::jsonb,
    ${document.sortOrder},
    true
  )`,
  )
  .join(',\n');

const itemValues = items
  .map(
    (item) => `(
    ${sqlLiteral(item.id)}::uuid,
    ${sqlLiteral(item.type)},
    ${sqlLiteral(JSON.stringify(item.data))}::jsonb,
    ${item.sortOrder},
    true
  )`,
  )
  .join(',\n');

process.stdout.write(`begin;

with collection as (
  insert into public.system_collections (
    slug,
    title,
    description,
    sort_order,
    is_published
  )
  values (
    'writing-model-essays',
    '作文范文',
    '考研英语作文真题与模拟范文，共享给所有用户。',
    20,
    true
  )
  on conflict (slug) do update set
    title = excluded.title,
    description = excluded.description,
    sort_order = excluded.sort_order,
    is_published = excluded.is_published
  returning id
)
insert into public.system_documents (
  id,
  collection_id,
  title,
  source_text,
  document_data,
  sort_order,
  is_published
)
select *
from (
  values
${documentValues}
) as documents (
  id,
  collection_id,
  title,
  source_text,
  document_data,
  sort_order,
  is_published
)
on conflict (id) do update set
  collection_id = excluded.collection_id,
  title = excluded.title,
  source_text = excluded.source_text,
  document_data = excluded.document_data,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published;

insert into public.system_writing_items (
  id,
  item_type,
  item_data,
  sort_order,
  is_published
)
values
${itemValues}
on conflict (id) do update set
  item_type = excluded.item_type,
  item_data = excluded.item_data,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published;

commit;
`);
