import type { Paragraph, Sentence } from '../types';

export function splitIntoParagraphTexts(text: string): string[] {
  const normalizedText = text
    .replace(/\r\n?/g, '\n')
    .replace(/[ \t]+\n/g, '\n')
    .trim();

  if (!normalizedText) {
    return [];
  }

  return normalizedText
    .split(/\n\s*\n+/)
    .map((paragraph) => paragraph.replace(/\s*\n\s*/g, ' ').trim())
    .filter(Boolean);
}

export function splitIntoSentences(text: string): string[] {
  return text
    .replace(/\s+/g, ' ')
    .trim()
    .match(/[^.!?]+[.!?]+(?:["')\]]+)?|[^.!?]+$/g)
    ?.map((sentence) => sentence.trim())
    .filter(Boolean) ?? [];
}

export function createDocumentStructure(
  sourceText: string,
  createId: () => string,
): { paragraphs: Paragraph[]; sentences: Sentence[] } {
  const paragraphs = splitIntoParagraphTexts(sourceText)
    .map((paragraphText) => {
      const sentences = splitIntoSentences(paragraphText).map((text) => ({
        id: createId(),
        text,
      }));

      return {
        id: createId(),
        sentences,
      };
    })
    .filter((paragraph) => paragraph.sentences.length > 0);

  return {
    paragraphs,
    sentences: paragraphs.flatMap((paragraph) => paragraph.sentences),
  };
}
