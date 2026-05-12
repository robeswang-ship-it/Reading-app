import * as mammoth from 'mammoth';
import { getDocument, GlobalWorkerOptions } from 'pdfjs-dist';
import pdfWorkerUrl from 'pdfjs-dist/build/pdf.worker.mjs?url';

const SCANNED_PDF_MESSAGE =
  'This PDF may be scanned or image-based. OCR is not supported yet.';

GlobalWorkerOptions.workerSrc = pdfWorkerUrl;

type PdfTextItem = {
  str: string;
  hasEOL?: boolean;
};

function isPdfTextItem(item: unknown): item is PdfTextItem {
  return (
    typeof item === 'object' &&
    item !== null &&
    'str' in item &&
    typeof item.str === 'string'
  );
}

function getPageText(items: unknown[]) {
  return items
    .filter(isPdfTextItem)
    .map((item) => `${item.str}${item.hasEOL ? '\n' : ' '}`)
    .join('')
    .replace(/[ \t]+\n/g, '\n')
    .replace(/[ \t]{2,}/g, ' ')
    .trim();
}

export async function parseTxtFile(file: File): Promise<string> {
  return file.text();
}

export async function parseDocxFile(file: File): Promise<string> {
  const arrayBuffer = await file.arrayBuffer();
  const result = await mammoth.extractRawText({ arrayBuffer });
  return result.value;
}

export async function parsePdfFile(file: File): Promise<string> {
  const arrayBuffer = await file.arrayBuffer();
  const loadingTask = getDocument({ data: new Uint8Array(arrayBuffer) });
  const pdf = await loadingTask.promise;
  const pageTexts: string[] = [];

  for (let pageNumber = 1; pageNumber <= pdf.numPages; pageNumber += 1) {
    const page = await pdf.getPage(pageNumber);
    const textContent = await page.getTextContent();
    const pageText = getPageText(textContent.items);

    if (pageText) {
      pageTexts.push(pageText);
    }
  }

  const rawText = pageTexts.join('\n\n').trim();

  if (!rawText) {
    throw new Error(SCANNED_PDF_MESSAGE);
  }

  return rawText;
}

