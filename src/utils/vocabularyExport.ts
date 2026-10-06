import JSZip from 'jszip';
import type { VocabularyItem } from '../types';

type ExportEntry = {
  word: string;
  meaning: string;
};

type ExerciseDirection = 'en-zh' | 'zh-en';

const DOCX_MIME =
  'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
const XLSX_MIME =
  'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';

function escapeXml(value: string) {
  return value
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&apos;');
}

function getMainChineseMeaning(meaning: string | undefined) {
  const trimmed = meaning?.trim();

  if (!trimmed || !/[\u3400-\u9fff]/.test(trimmed)) {
    return '待补充中文释义';
  }

  return trimmed;
}

function toExportEntries(items: VocabularyItem[]): ExportEntry[] {
  return items.map((item) => ({
    word: item.word.trim(),
    meaning: getMainChineseMeaning(item.meaning),
  }));
}

function seededShuffle<T>(values: T[], seed: number) {
  let state = seed >>> 0;
  const shuffled = [...values];

  const next = () => {
    state = (1664525 * state + 1013904223) >>> 0;
    return state / 0x100000000;
  };

  for (let index = shuffled.length - 1; index > 0; index -= 1) {
    const swapIndex = Math.floor(next() * (index + 1));
    [shuffled[index], shuffled[swapIndex]] = [
      shuffled[swapIndex],
      shuffled[index],
    ];
  }

  return shuffled;
}

function chunkValues<T>(values: T[], size: number) {
  const chunks: T[][] = [];

  for (let index = 0; index < values.length; index += size) {
    chunks.push(values.slice(index, index + size));
  }

  return chunks;
}

function runXml(text: string, options?: { bold?: boolean; size?: number }) {
  const size = options?.size ?? 18;
  const bold = options?.bold ? '<w:b/>' : '';

  return `<w:r><w:rPr><w:rFonts w:ascii="Arial Unicode MS" w:hAnsi="Arial Unicode MS" w:eastAsia="Arial Unicode MS"/>${bold}<w:sz w:val="${size}"/><w:szCs w:val="${size}"/><w:color w:val="000000"/></w:rPr><w:t xml:space="preserve">${escapeXml(text)}</w:t></w:r>`;
}

function paragraphXml(
  text: string,
  options?: {
    align?: 'left' | 'center' | 'right';
    bold?: boolean;
    size?: number;
    before?: number;
    after?: number;
    pageBreakBefore?: boolean;
  },
) {
  const alignment = options?.align
    ? `<w:jc w:val="${options.align}"/>`
    : '';
  const pageBreakBefore = options?.pageBreakBefore
    ? '<w:pageBreakBefore/>'
    : '';

  return `<w:p><w:pPr>${alignment}${pageBreakBefore}<w:spacing w:before="${options?.before ?? 0}" w:after="${options?.after ?? 0}" w:line="240" w:lineRule="auto"/></w:pPr>${runXml(text, options)}</w:p>`;
}

function pageBreakXml() {
  return '<w:p><w:r><w:br w:type="page"/></w:r></w:p>';
}

function tableCellXml(text: string, width: number, bold = false) {
  return `<w:tc><w:tcPr><w:tcW w:w="${width}" w:type="dxa"/><w:vAlign w:val="center"/><w:tcMar><w:top w:w="28" w:type="dxa"/><w:start w:w="85" w:type="dxa"/><w:bottom w:w="28" w:type="dxa"/><w:end w:w="85" w:type="dxa"/></w:tcMar></w:tcPr>${paragraphXml(text, { align: bold ? 'center' : 'left', bold, size: 18 })}</w:tc>`;
}

function exerciseTableXml(
  entries: ExportEntry[],
  direction: ExerciseDirection,
) {
  const isEnglishToChinese = direction === 'en-zh';
  const headers = isEnglishToChinese
    ? ['英文', '中文（手写）', '英文', '中文（手写）']
    : ['中文释义', '英文（手写）', '中文释义', '英文（手写）'];
  const widths = isEnglishToChinese
    ? [1800, 3150, 1800, 3150]
    : [3000, 1950, 3000, 1950];
  const splitIndex = Math.ceil(entries.length / 2);
  const leftEntries = entries.slice(0, splitIndex);
  const rightEntries = entries.slice(splitIndex);
  const border =
    '<w:top w:val="single" w:sz="5" w:color="000000"/><w:left w:val="single" w:sz="5" w:color="000000"/><w:bottom w:val="single" w:sz="5" w:color="000000"/><w:right w:val="single" w:sz="5" w:color="000000"/><w:insideH w:val="single" w:sz="5" w:color="000000"/><w:insideV w:val="single" w:sz="5" w:color="000000"/>';
  const headerRow = `<w:tr><w:trPr><w:tblHeader/><w:cantSplit/></w:trPr>${headers
    .map((header, index) => tableCellXml(header, widths[index], true))
    .join('')}</w:tr>`;
  const bodyRows = leftEntries
    .map((leftEntry, index) => {
      const rightEntry = rightEntries[index];
      const leftPrompt = isEnglishToChinese
        ? leftEntry.word
        : leftEntry.meaning;
      const rightPrompt = rightEntry
        ? isEnglishToChinese
          ? rightEntry.word
          : rightEntry.meaning
        : '';

      return `<w:tr><w:trPr><w:cantSplit/></w:trPr>${tableCellXml(leftPrompt, widths[0])}${tableCellXml('', widths[1])}${tableCellXml(rightPrompt, widths[2])}${tableCellXml('', widths[3])}</w:tr>`;
    })
    .join('');

  return `<w:tbl><w:tblPr><w:tblW w:w="9900" w:type="dxa"/><w:tblInd w:w="120" w:type="dxa"/><w:tblLayout w:type="fixed"/><w:tblBorders>${border}</w:tblBorders></w:tblPr><w:tblGrid>${widths.map((width) => `<w:gridCol w:w="${width}"/>`).join('')}</w:tblGrid>${headerRow}${bodyRows}</w:tbl>`;
}

function exercisePartXml(
  title: string,
  instruction: string,
  entries: ExportEntry[],
  direction: ExerciseDirection,
  addBreakBefore: boolean,
) {
  const pages = chunkValues(entries, 50);
  let xml = addBreakBefore ? pageBreakXml() : '';

  pages.forEach((pageEntries, index) => {
    if (index > 0) {
      xml += pageBreakXml();
    }

    if (index === 0) {
      xml += paragraphXml(title, { bold: true, size: 31, after: 20 });
      xml += paragraphXml(`${instruction}\u3000共 ${entries.length} 词`, {
        size: 18,
        after: 80,
      });
    }

    xml += exerciseTableXml(pageEntries, direction);
  });

  return xml;
}

function shortBookletBodyXml(
  parts: Array<{
    title: string;
    instruction: string;
    entries: ExportEntry[];
    direction: ExerciseDirection;
  }>,
) {
  let xml = '';

  parts.forEach((part, index) => {
    if (index === 2) {
      xml += pageBreakXml();
    }

    xml += paragraphXml(part.title, {
      bold: true,
      size: 28,
      before: index % 2 === 1 ? 100 : 0,
      after: 10,
    });
    xml += paragraphXml(`${part.instruction}\u3000共 ${part.entries.length} 词`, {
      size: 17,
      after: 40,
    });
    xml += exerciseTableXml(part.entries, part.direction);
  });

  return xml;
}

async function buildVocabularyDocx(
  entries: ExportEntry[],
  bookNumber: number,
  startNumber: number,
) {
  const endNumber = startNumber + entries.length - 1;
  const randomEnglish = seededShuffle(entries, 20260825 + bookNumber * 10);
  const randomChinese = seededShuffle(entries, 20260826 + bookNumber * 10);
  const parts = [
    {
      title: '第一部分 正序英译中',
      instruction: '看到英文后，在右侧空格手写中文意思。',
      entries,
      direction: 'en-zh' as const,
    },
    {
      title: '第二部分 正序中译英',
      instruction: '根据中文释义，在右侧空格默写英文。',
      entries,
      direction: 'zh-en' as const,
    },
    {
      title: '第三部分 乱序英译中',
      instruction: '本册词序已随机打乱，手写中文意思。',
      entries: randomEnglish,
      direction: 'en-zh' as const,
    },
    {
      title: '第四部分 乱序中译英',
      instruction: '采用另一套乱序，根据中文释义默写英文。',
      entries: randomChinese,
      direction: 'zh-en' as const,
    },
  ];
  const bodyXml =
    entries.length <= 25
      ? shortBookletBodyXml(parts)
      : parts
          .map((part, index) =>
            exercisePartXml(
              part.title,
              part.instruction,
              part.entries,
              part.direction,
              index > 0,
            ),
          )
          .join('');
  const runningLabel = `第${bookNumber}册 · 第${startNumber}–${endNumber}词`;
  const zip = new JSZip();

  zip.file(
    '[Content_Types].xml',
    `<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="xml" ContentType="application/xml"/><Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/><Override PartName="/word/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml"/><Override PartName="/word/settings.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.settings+xml"/><Override PartName="/word/header1.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.header+xml"/><Override PartName="/word/footer1.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.footer+xml"/><Override PartName="/docProps/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/><Override PartName="/docProps/app.xml" ContentType="application/vnd.openxmlformats-officedocument.extended-properties+xml"/></Types>`,
  );
  zip.file(
    '_rels/.rels',
    `<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/><Relationship Id="rId2" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties" Target="docProps/core.xml"/><Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties" Target="docProps/app.xml"/></Relationships>`,
  );
  zip.file(
    'word/_rels/document.xml.rels',
    `<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/header" Target="header1.xml"/><Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/footer" Target="footer1.xml"/></Relationships>`,
  );
  zip.file(
    'word/document.xml',
    `<?xml version="1.0" encoding="UTF-8" standalone="yes"?><w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"><w:body>${bodyXml}<w:sectPr><w:headerReference w:type="default" r:id="rId1"/><w:footerReference w:type="default" r:id="rId2"/><w:pgSz w:w="11906" w:h="16838"/><w:pgMar w:top="835" w:right="936" w:bottom="835" w:left="936" w:header="360" w:footer="400" w:gutter="0"/></w:sectPr></w:body></w:document>`,
  );
  zip.file(
    'word/styles.xml',
    `<?xml version="1.0" encoding="UTF-8" standalone="yes"?><w:styles xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"><w:docDefaults><w:rPrDefault><w:rPr><w:rFonts w:ascii="Arial Unicode MS" w:hAnsi="Arial Unicode MS" w:eastAsia="Arial Unicode MS"/><w:sz w:val="21"/><w:szCs w:val="21"/></w:rPr></w:rPrDefault><w:pPrDefault><w:pPr><w:spacing w:after="100" w:line="276" w:lineRule="auto"/></w:pPr></w:pPrDefault></w:docDefaults><w:style w:type="paragraph" w:default="1" w:styleId="Normal"><w:name w:val="Normal"/></w:style></w:styles>`,
  );
  zip.file(
    'word/settings.xml',
    `<?xml version="1.0" encoding="UTF-8" standalone="yes"?><w:settings xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"><w:zoom w:percent="100"/><w:defaultTabStop w:val="720"/></w:settings>`,
  );
  zip.file(
    'word/header1.xml',
    `<?xml version="1.0" encoding="UTF-8" standalone="yes"?><w:hdr xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">${paragraphXml(runningLabel, { align: 'right', size: 17 })}</w:hdr>`,
  );
  zip.file(
    'word/footer1.xml',
    `<?xml version="1.0" encoding="UTF-8" standalone="yes"?><w:ftr xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"><w:p><w:pPr><w:jc w:val="center"/></w:pPr>${runXml('词汇默写练习 · ', { size: 17 })}<w:r><w:rPr><w:rFonts w:ascii="Arial Unicode MS" w:hAnsi="Arial Unicode MS" w:eastAsia="Arial Unicode MS"/><w:sz w:val="17"/></w:rPr><w:fldChar w:fldCharType="begin"/><w:instrText xml:space="preserve"> PAGE </w:instrText><w:fldChar w:fldCharType="end"/></w:r></w:p></w:ftr>`,
  );
  zip.file(
    'docProps/core.xml',
    `<?xml version="1.0" encoding="UTF-8" standalone="yes"?><cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dcmitype="http://purl.org/dc/dcmitype/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><dc:title>${escapeXml(`词汇默写练习 第${bookNumber}册 第${startNumber}至${endNumber}词`)}</dc:title><dc:subject>正序乱序英译中与中译英打印练习</dc:subject><dc:creator>AI Intensive Reading</dc:creator><cp:keywords>考研英语 词汇 默写</cp:keywords><dcterms:created xsi:type="dcterms:W3CDTF">${new Date().toISOString()}</dcterms:created></cp:coreProperties>`,
  );
  zip.file(
    'docProps/app.xml',
    `<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties" xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes"><Application>AI Intensive Reading</Application></Properties>`,
  );

  return new Blob(
    [(await zip.generateAsync({ type: 'uint8array' })).buffer as ArrayBuffer],
    { type: DOCX_MIME },
  );
}

function xlsxCellXml(reference: string, value: string, style: number) {
  return `<c r="${reference}" t="inlineStr" s="${style}"><is><t xml:space="preserve">${escapeXml(value)}</t></is></c>`;
}

function xlsxSheetXml(
  title: string,
  instruction: string,
  entries: ExportEntry[],
  direction: ExerciseDirection,
) {
  const isEnglishToChinese = direction === 'en-zh';
  const rows = entries
    .map((entry, index) => {
      const rowNumber = index + 5;
      const prompt = isEnglishToChinese ? entry.word : entry.meaning;
      const style = index % 2 === 0 ? 4 : 5;

      return `<row r="${rowNumber}" ht="24" customHeight="1">${xlsxCellXml(`A${rowNumber}`, prompt, style)}${xlsxCellXml(`B${rowNumber}`, '', style)}</row>`;
    })
    .join('');
  const firstHeader = isEnglishToChinese ? '英文' : '中文释义';
  const secondHeader = isEnglishToChinese ? '中文（手写）' : '英文（手写）';
  const endRow = entries.length + 4;
  const firstWidth = isEnglishToChinese ? 24 : 38;
  const secondWidth = isEnglishToChinese ? 42 : 28;

  return `<?xml version="1.0" encoding="UTF-8" standalone="yes"?><worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main"><sheetPr/><dimension ref="A1:B${endRow}"/><sheetViews><sheetView showGridLines="0" workbookViewId="0"><pane ySplit="4" topLeftCell="A5" activePane="bottomLeft" state="frozen"/><selection pane="bottomLeft" activeCell="A5" sqref="A5"/></sheetView></sheetViews><sheetFormatPr defaultRowHeight="15"/><cols><col min="1" max="1" width="${firstWidth}" customWidth="1"/><col min="2" max="2" width="${secondWidth}" customWidth="1"/></cols><sheetData><row r="1" ht="32" customHeight="1">${xlsxCellXml('A1', title, 1)}</row><row r="2" ht="24" customHeight="1">${xlsxCellXml('A2', `${instruction}\u3000共 ${entries.length} 个词条`, 2)}</row><row r="3" ht="8" customHeight="1"/><row r="4" ht="24" customHeight="1">${xlsxCellXml('A4', firstHeader, 3)}${xlsxCellXml('B4', secondHeader, 3)}</row>${rows}</sheetData><mergeCells count="2"><mergeCell ref="A1:B1"/><mergeCell ref="A2:B2"/></mergeCells><pageMargins left="0.5" right="0.5" top="0.6" bottom="0.6" header="0.3" footer="0.3"/><pageSetup orientation="portrait" fitToWidth="1" fitToHeight="0"/></worksheet>`;
}

export async function exportVocabularyExcel(items: VocabularyItem[]) {
  const entries = toExportEntries(items);
  const randomEnglish = seededShuffle(entries, 20260825);
  const randomChinese = seededShuffle(entries, 20260826);
  const sheets = [
    {
      name: '正序-英译中',
      title: '正序 英译中',
      instruction: '按照单词本顺序，在右侧空格手写中文意思。',
      entries,
      direction: 'en-zh' as const,
    },
    {
      name: '正序-中译英',
      title: '正序 中译英',
      instruction: '按照单词本顺序，根据中文释义默写英文。',
      entries,
      direction: 'zh-en' as const,
    },
    {
      name: '乱序-英译中',
      title: '乱序 英译中',
      instruction: '词序已随机打乱，在右侧空格手写中文意思。',
      entries: randomEnglish,
      direction: 'en-zh' as const,
    },
    {
      name: '乱序-中译英',
      title: '乱序 中译英',
      instruction: '采用另一套乱序，根据中文释义默写英文。',
      entries: randomChinese,
      direction: 'zh-en' as const,
    },
  ];
  const zip = new JSZip();

  zip.file(
    '[Content_Types].xml',
    `<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="xml" ContentType="application/xml"/><Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/><Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/>${sheets.map((_, index) => `<Override PartName="/xl/worksheets/sheet${index + 1}.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>`).join('')}<Override PartName="/docProps/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/><Override PartName="/docProps/app.xml" ContentType="application/vnd.openxmlformats-officedocument.extended-properties+xml"/></Types>`,
  );
  zip.file(
    '_rels/.rels',
    `<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/><Relationship Id="rId2" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties" Target="docProps/core.xml"/><Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties" Target="docProps/app.xml"/></Relationships>`,
  );
  zip.file(
    'xl/workbook.xml',
    `<?xml version="1.0" encoding="UTF-8" standalone="yes"?><workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"><bookViews><workbookView/></bookViews><sheets>${sheets.map((sheet, index) => `<sheet name="${escapeXml(sheet.name)}" sheetId="${index + 1}" r:id="rId${index + 1}"/>`).join('')}</sheets><calcPr calcId="191029"/></workbook>`,
  );
  zip.file(
    'xl/_rels/workbook.xml.rels',
    `<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">${sheets.map((_, index) => `<Relationship Id="rId${index + 1}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet${index + 1}.xml"/>`).join('')}<Relationship Id="rId${sheets.length + 1}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/></Relationships>`,
  );
  zip.file(
    'xl/styles.xml',
    `<?xml version="1.0" encoding="UTF-8" standalone="yes"?><styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main"><fonts count="5"><font><sz val="11"/><name val="Arial"/></font><font><b/><sz val="18"/><color rgb="FFFFFFFF"/><name val="Arial"/></font><font><sz val="10"/><color rgb="FF526271"/><name val="Arial"/></font><font><b/><sz val="11"/><color rgb="FF244862"/><name val="Arial"/></font><font><sz val="11"/><color rgb="FF26333D"/><name val="Arial"/></font></fonts><fills count="5"><fill><patternFill patternType="none"/></fill><fill><patternFill patternType="gray125"/></fill><fill><patternFill patternType="solid"><fgColor rgb="FF315A7D"/><bgColor indexed="64"/></patternFill></fill><fill><patternFill patternType="solid"><fgColor rgb="FFE8EEF5"/><bgColor indexed="64"/></patternFill></fill><fill><patternFill patternType="solid"><fgColor rgb="FFD8E4EE"/><bgColor indexed="64"/></patternFill></fill></fills><borders count="2"><border><left/><right/><top/><bottom/><diagonal/></border><border><left style="thin"><color rgb="FFB8C4CE"/></left><right style="thin"><color rgb="FFB8C4CE"/></right><top style="thin"><color rgb="FFB8C4CE"/></top><bottom style="thin"><color rgb="FFB8C4CE"/></bottom><diagonal/></border></borders><cellStyleXfs count="1"><xf numFmtId="0" fontId="0" fillId="0" borderId="0"/></cellStyleXfs><cellXfs count="6"><xf numFmtId="0" fontId="0" fillId="0" borderId="0" xfId="0"/><xf numFmtId="0" fontId="1" fillId="2" borderId="0" xfId="0" applyFont="1" applyFill="1" applyAlignment="1"><alignment horizontal="left" vertical="center"/></xf><xf numFmtId="0" fontId="2" fillId="3" borderId="0" xfId="0" applyFont="1" applyFill="1" applyAlignment="1"><alignment horizontal="left" vertical="center"/></xf><xf numFmtId="0" fontId="3" fillId="4" borderId="1" xfId="0" applyFont="1" applyFill="1" applyBorder="1" applyAlignment="1"><alignment horizontal="center" vertical="center" wrapText="1"/></xf><xf numFmtId="0" fontId="4" fillId="0" borderId="1" xfId="0" applyFont="1" applyBorder="1" applyAlignment="1"><alignment horizontal="left" vertical="center" wrapText="1"/></xf><xf numFmtId="0" fontId="4" fillId="3" borderId="1" xfId="0" applyFont="1" applyFill="1" applyBorder="1" applyAlignment="1"><alignment horizontal="left" vertical="center" wrapText="1"/></xf></cellXfs><cellStyles count="1"><cellStyle name="Normal" xfId="0" builtinId="0"/></cellStyles></styleSheet>`,
  );
  sheets.forEach((sheet, index) => {
    zip.file(
      `xl/worksheets/sheet${index + 1}.xml`,
      xlsxSheetXml(
        sheet.title,
        sheet.instruction,
        sheet.entries,
        sheet.direction,
      ),
    );
  });
  zip.file(
    'docProps/core.xml',
    `<?xml version="1.0" encoding="UTF-8" standalone="yes"?><cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><dc:title>词汇默写练习表 正序与乱序</dc:title><dc:creator>AI Intensive Reading</dc:creator><dcterms:created xsi:type="dcterms:W3CDTF">${new Date().toISOString()}</dcterms:created></cp:coreProperties>`,
  );
  zip.file(
    'docProps/app.xml',
    `<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties" xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes"><Application>AI Intensive Reading</Application><TitlesOfParts><vt:vector size="4" baseType="lpstr">${sheets.map((sheet) => `<vt:lpstr>${escapeXml(sheet.name)}</vt:lpstr>`).join('')}</vt:vector></TitlesOfParts></Properties>`,
  );

  return new Blob(
    [(await zip.generateAsync({ type: 'uint8array' })).buffer as ArrayBuffer],
    { type: XLSX_MIME },
  );
}

export async function exportVocabularyWord(items: VocabularyItem[]) {
  const entries = toExportEntries(items);
  const books = chunkValues(entries, 100);

  if (books.length === 1) {
    return {
      blob: await buildVocabularyDocx(books[0], 1, 1),
      fileName: `词汇默写练习_第1册_第1-${entries.length}词.docx`,
    };
  }

  const zip = new JSZip();

  for (let index = 0; index < books.length; index += 1) {
    const startNumber = index * 100 + 1;
    const endNumber = startNumber + books[index].length - 1;
    const docx = await buildVocabularyDocx(
      books[index],
      index + 1,
      startNumber,
    );
    zip.file(
      `词汇默写练习_第${index + 1}册_第${startNumber}-${endNumber}词.docx`,
      await docx.arrayBuffer(),
    );
  }

  return {
    blob: new Blob(
      [(await zip.generateAsync({ type: 'uint8array' })).buffer as ArrayBuffer],
      { type: 'application/zip' },
    ),
    fileName: `词汇默写练习_共${entries.length}词.zip`,
  };
}

export function getVocabularyExcelFileName() {
  return `词汇默写练习表_正序与乱序_${new Date().toISOString().slice(0, 10)}.xlsx`;
}
