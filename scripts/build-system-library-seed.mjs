import { createHash } from 'node:crypto';
import { readFile } from 'node:fs/promises';
import { resolve } from 'node:path';

const inputPath = resolve(
  process.argv[2] ??
    'content/system-library/english-one/2024.json',
);
const source = JSON.parse(await readFile(inputPath, 'utf8'));
const segmenter = new Intl.Segmenter('en', { granularity: 'sentence' });

function stableUuid(value) {
  const hash = createHash('sha256').update(value).digest('hex');
  return `${hash.slice(0, 8)}-${hash.slice(8, 12)}-4${hash.slice(
    13,
    16,
  )}-a${hash.slice(17, 20)}-${hash.slice(20, 32)}`;
}

function parseInlineItalics(value) {
  let text = '';
  let cursor = 0;
  let italicStart = null;
  const italicRanges = [];
  const tagPattern = /<\/?i>/g;

  for (const match of value.matchAll(tagPattern)) {
    text += value.slice(cursor, match.index);

    if (match[0] === '<i>') {
      if (italicStart !== null) {
        throw new Error(`Nested italic tag in: ${value}`);
      }
      italicStart = text.length;
    } else {
      if (italicStart === null) {
        throw new Error(`Unmatched italic close tag in: ${value}`);
      }
      italicRanges.push({ start: italicStart, end: text.length });
      italicStart = null;
    }

    cursor = match.index + match[0].length;
  }

  text += value.slice(cursor);

  if (italicStart !== null) {
    throw new Error(`Unclosed italic tag in: ${value}`);
  }

  return { text, italicRanges };
}

function buildDocument(entry, sortOrder) {
  const documentId = stableUuid(`system-document:${entry.slug}`);
  const paragraphs = entry.paragraphs.map((paragraph, paragraphIndex) => {
    const parsed = parseInlineItalics(paragraph);
    const sentences = Array.from(segmenter.segment(parsed.text))
      .map((segment) => ({
        text: segment.segment.trim(),
        sourceStart: segment.index,
      }))
      .filter((sentence) => sentence.text);

    return {
      id: stableUuid(`${documentId}:paragraph:${paragraphIndex}`),
      sentences: sentences.map((sentence, sentenceIndex) => {
        const leadingWhitespace =
          parsed.text.slice(sentence.sourceStart).length -
          parsed.text.slice(sentence.sourceStart).trimStart().length;
        const sentenceStart = sentence.sourceStart + leadingWhitespace;
        const sentenceEnd = sentenceStart + sentence.text.length;
        const italicRanges = parsed.italicRanges
          .map((range) => ({
            start: Math.max(range.start, sentenceStart) - sentenceStart,
            end: Math.min(range.end, sentenceEnd) - sentenceStart,
          }))
          .filter((range) => range.end > range.start);

        return {
          id: stableUuid(
            `${documentId}:paragraph:${paragraphIndex}:sentence:${sentenceIndex}`,
          ),
          text: sentence.text,
          ...(italicRanges.length > 0 ? { italicRanges } : {}),
        };
      }),
    };
  });
  const sentences = paragraphs.flatMap((paragraph) => paragraph.sentences);
  const sourceText = paragraphs
    .map((paragraph) =>
      paragraph.sentences.map((sentence) => sentence.text).join(' '),
    )
    .join('\n\n');

  if (/<\/?i>|\(\d{2}\)|【[A-D]】/.test(sourceText)) {
    throw new Error(`Unclean source text in ${entry.title}`);
  }

  return {
    id: documentId,
    title: entry.title,
    sourceText,
    sortOrder,
    documentData: {
      id: documentId,
      title: entry.title,
      createdAt: '2026-07-29T00:00:00.000Z',
      sourceText,
      paragraphs,
      sentences,
      currentSentenceIndex: 0,
      origin: 'system',
    },
  };
}

if (source.documents.length !== 6) {
  throw new Error('A yearly English I seed must contain exactly six documents.');
}

const documents = source.documents.map(buildDocument);

function sqlLiteral(value) {
  return `'${value.replaceAll("'", "''")}'`;
}

const values = documents
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

process.stdout.write(`with collection as (
  insert into public.system_collections (
    slug,
    title,
    description,
    sort_order,
    is_published
  )
  values (
    ${sqlLiteral(source.collection.slug)},
    ${sqlLiteral(source.collection.title)},
    ${sqlLiteral(source.collection.description)},
    10,
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
${values}
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
`);
