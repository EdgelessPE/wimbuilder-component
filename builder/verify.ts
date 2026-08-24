import { readFile } from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import iconv from 'iconv-lite';

import { pages } from './config.ts';
import { renderPatchName } from './render.ts';

interface HtmlControl {
    type: string;
    name: string;
    value?: string;
    className?: string;
    checked: boolean;
    commented: boolean;
    label: string;
}

const builderDir = path.dirname(fileURLToPath(import.meta.url));
const projectDir = path.dirname(builderDir);
const outputDir = projectDir;

const decodeHtml = async (filePath: string): Promise<string> =>
    iconv.decode(await readFile(filePath), 'gb2312');

const readUtf16Le = async (filePath: string): Promise<Buffer> => {
    const content = await readFile(filePath);

    if (content[0] !== 0xff || content[1] !== 0xfe) {
        throw new Error(`${filePath} 必须使用 UTF-16LE BOM 编码。`);
    }

    return content;
};

const normalizeText = (content: string): string => content
    .replace(/<[^>]*>/g, ' ')
    .replaceAll('&amp;', '&')
    .replaceAll('&lt;', '<')
    .replaceAll('&gt;', '>')
    .replaceAll('&quot;', '"')
    .replaceAll('&#39;', "'")
    .replace(/\s+/g, ' ')
    .trim();

const readAttribute = (tag: string, name: string): string | undefined => {
    const match = tag.match(new RegExp(`\\b${name}\\s*=\\s*["']([^"']*)["']`, 'i'));
    return match?.[1];
};

const isCommentedAt = (content: string, offset: number): boolean => {
    const commentStart = content.lastIndexOf('<!--', offset);
    const commentEnd = content.lastIndexOf('-->', offset);
    return commentStart > commentEnd;
};

const collectControls = (content: string): HtmlControl[] => {
    const controls: HtmlControl[] = [];

    for (const match of content.matchAll(/<input\b[^>]*>/gi)) {
        const tag = match[0];
        const offset = match.index;
        const tail = content.slice(offset + tag.length);
        const labelEnd = tail.search(/<\/label\s*>/i);
        const label = labelEnd === -1
            ? ''
            : normalizeText(tail.slice(0, labelEnd));

        controls.push({
            type: readAttribute(tag, 'type') ?? '',
            name: readAttribute(tag, 'name') ?? '',
            value: readAttribute(tag, 'value'),
            className: readAttribute(tag, 'class'),
            checked: /\bchecked\b/i.test(tag),
            commented: isCommentedAt(content, offset),
            label,
        });
    }

    return controls;
};

const collectLegends = (content: string): string[] => Array.from(
    content.matchAll(/<legend\b[^>]*>([\s\S]*?)<\/legend\s*>/gi),
    (match) => normalizeText(match[1]),
).sort();

const assertEqual = (name: string, original: unknown, generated: unknown): void => {
    const expected = JSON.stringify(original);
    const actual = JSON.stringify(generated);

    if (expected !== actual) {
        throw new Error(`${name} 不一致\n原版：${expected}\n生成：${actual}`);
    }
};

const normalizeConditions = (lines: string[]): string[] => {
    const normalized: string[] = [];

    for (let index = 0; index < lines.length; index += 1) {
        const condition = lines[index].match(/^if (.+) \($/i);

        if (condition === null) {
            normalized.push(lines[index]);
            continue;
        }

        const body: string[] = [];
        index += 1;

        while (index < lines.length && lines[index] !== ')') {
            body.push(lines[index]);
            index += 1;
        }

        const command = body.join('\n');

        if (condition[1] === '"x%opt[Edgeless.Slim]%" neq "x0"') {
            normalized.push(
                `if "x%opt[Edgeless.Slim]%"=="x1" ${command}`,
                `if "x%opt[Edgeless.Slim]%"=="x2" ${command}`,
            );
        } else {
            normalized.push(`if ${condition[1]} ${command}`);
        }
    }

    return normalized;
};

const normalizeBatch = (content: string): string[] => normalizeConditions(
    content
        .replaceAll('\r\n', '\n')
        .replaceAll('\r', '\n')
        .split('\n')
        .map((line) => line.trim())
        .filter((line) => line !== '' && !line.startsWith('::'))
        .map((line) => {
            const comment = line.match(/^@?rem(?:\s+([\s\S]*))?$/i);
            return comment === null ? line : `@REM ${comment[1]?.trim() ?? ''}`;
        })
        .filter((line) => !/^@REM (?:if .+ \(|\))$/i.test(line)),
);

const normalizeBatchBlocks = (content: string): string[] =>
    normalizeBatch(content).sort();

const verifyHtml = async (): Promise<void> => {
    for (const page of pages) {
        const relativePath = path.join(page.page, 'main.html');
        const original = await decodeHtml(path.join(projectDir, relativePath));
        const generated = await decodeHtml(path.join(outputDir, relativePath));
        const generatedControls = collectControls(generated);

        if (generatedControls.some((control) => (
            control.type === 'checkbox' && control.checked
        ))) {
            throw new Error(`${relativePath} 中的 checkbox 默认状态必须为不选中。`);
        }

        assertEqual(
            `${relativePath} 的表单控件`,
            collectControls(original),
            generatedControls,
        );
        assertEqual(
            `${relativePath} 的分组标题`,
            collectLegends(original),
            collectLegends(generated),
        );
    }
};

const verifyBatch = async (): Promise<void> => {
    for (const fileName of ['main.bat', 'last.bat']) {
        const original = await readFile(path.join(projectDir, fileName), 'utf8');
        const generated = await readFile(path.join(outputDir, fileName), 'utf8');
        assertEqual(
            `${fileName} 的独立命令块`,
            normalizeBatchBlocks(original),
            normalizeBatchBlocks(generated),
        );
    }
};

const lineEndingSignature = (content: Buffer): {
    style: 'crlf' | 'lf' | 'mixed' | 'none';
    final: boolean;
} => {
    let crlfCount = 0;
    let lfCount = 0;

    for (let index = 0; index < content.length; index += 1) {
        if (content[index] !== 0x0a) {
            continue;
        }

        if (index > 0 && content[index - 1] === 0x0d) {
            crlfCount += 1;
        } else {
            lfCount += 1;
        }
    }

    return {
        style: crlfCount === 0 && lfCount === 0
            ? 'none'
            : crlfCount > 0 && lfCount > 0
                ? 'mixed'
                : crlfCount > 0
                ? 'crlf'
                : 'lf',
        final: content.length > 0
            && (content.at(-1) === 0x0a || content.at(-1) === 0x0d),
    };
};

const verifyLineEndings = async (): Promise<void> => {
    const relativePaths = [
        ...pages.map((page) => path.join(page.page, 'main.html')),
        'main.bat',
        'last.bat',
    ];

    for (const relativePath of relativePaths) {
        const original = await readFile(path.join(projectDir, relativePath));
        const generated = await readFile(path.join(outputDir, relativePath));
        assertEqual(
            `${relativePath} 的换行符`,
            lineEndingSignature(original),
            lineEndingSignature(generated),
        );
    }
};

const verifyPatchNames = async (): Promise<void> => {
    for (const page of pages) {
        if (page.patchName === undefined) {
            continue;
        }

        const relativePath = path.join(page.page, 'zh-CN.js');
        const original = await readUtf16Le(path.join(projectDir, relativePath));
        const generated = await readUtf16Le(path.join(outputDir, relativePath));
        const generatedText = iconv.decode(generated.subarray(2), 'utf16-le');

        assertEqual(
            `${relativePath} 的 patch_name`,
            renderPatchName(page.patchName),
            generatedText,
        );
        assertEqual(
            `${relativePath} 的编码和内容`,
            original.toString('hex'),
            generated.toString('hex'),
        );
    }
};

const verifySlimScript = async (): Promise<void> => {
    const filePath = path.join(
        projectDir,
        '_vendor',
        'FirPE',
        'FirPE_Slim.cmd',
    );
    const content = await readFile(filePath);

    if (content.length === 0) {
        throw new Error(`${filePath} 不能为空。`);
    }
};

await verifyHtml();
await verifyBatch();
await verifyLineEndings();
await verifyPatchNames();
await verifySlimScript();
console.log('生成文件的表单行为、BAT 命令、页面名称和换行符验证通过。');
