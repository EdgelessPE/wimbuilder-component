import {
    mkdir,
    mkdtemp,
    readFile,
    rename,
    rm,
    writeFile,
} from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import iconv from 'iconv-lite';

import { pages } from './config.ts';
import {
    renderBatchSection,
    renderBatchTemplate,
    renderCheckboxCommand,
    renderInputCommand,
    renderPage,
    renderRadioCommand,
} from './render.ts';
import type {
    Form,
    FormCommand,
    FormCommands,
    FormGroup,
    FormPage,
    FormStage,
} from './type.ts';

interface OutputTask {
    path: string;
    content: string;
    encoding: 'gb2312' | 'utf8';
}

interface EncodedOutputTask {
    path: string;
    content: Buffer;
}

interface BatchSection {
    title: string;
    commands: string[];
}

type CollectedCommands = Map<FormStage, string[]>;

const builderDir = path.dirname(fileURLToPath(import.meta.url));
const projectDir = path.dirname(builderDir);
const distDir = path.join(projectDir, 'dist');
const templateDir = path.join(builderDir, 'templates');

const normalizeCommands = (commands: FormCommands): FormCommand[] =>
    Array.isArray(commands) ? commands : [commands];

const resolveOptionKey = (key: string): string => {
    if (key.startsWith('Edgeless.')) {
        throw new Error(`表单 key 不应包含 Edgeless. 前缀：${key}`);
    }

    return `Edgeless.${key}`;
};

const resolvePageOutput = (page: string): string => {
    const segments = page.split(/[\\/]/);

    for (const segment of segments) {
        if (/[. ]$/.test(segment)) {
            throw new Error(`页面目录不能以点或空格结尾：${page}`);
        }

        if (
            /[<>:"|?*\u0000-\u001f]/.test(segment)
            || /^(?:con|prn|aux|nul|com[1-9]|lpt[1-9])(?:\..*)?$/i.test(segment)
        ) {
            throw new Error(`页面目录包含 Windows 不支持的名称：${page}`);
        }
    }

    const pageDir = path.resolve(distDir, page);
    const relative = path.relative(distDir, pageDir);

    if (
        relative === '..'
        || relative.startsWith(`..${path.sep}`)
        || path.isAbsolute(relative)
    ) {
        throw new Error(`页面目录不能位于 dist 之外：${page}`);
    }

    return path.join(pageDir, 'main.html');
};

const collectCommands = (
    target: CollectedCommands,
    commands: FormCommands | undefined,
    render: (command: FormCommand) => string,
): void => {
    if (commands === undefined) {
        return;
    }

    for (const command of normalizeCommands(commands)) {
        const stage = command.stage ?? 'main';
        const stageCommands = target.get(stage) ?? [];
        stageCommands.push(render(command));
        target.set(stage, stageCommands);
    }
};

interface FormCommandHandler {
    type: Form['type'];
    collect: (
        form: Form,
        key: string,
        target: CollectedCommands,
    ) => void;
}

const isFormType = <Type extends Form['type']>(
    form: Form,
    type: Type,
): form is Extract<Form, { type: Type }> => form.type === type;

const defineFormCommandHandler = <Type extends Form['type']>(
    type: Type,
    collect: (
        form: Extract<Form, { type: Type }>,
        key: string,
        target: CollectedCommands,
    ) => void,
): FormCommandHandler => ({
    type,
    collect: (form, key, target) => {
        if (!isFormType(form, type)) {
            throw new Error(`表单处理器类型不匹配：${type}`);
        }

        collect(form, key, target);
    },
});

const formCommandHandlers: FormCommandHandler[] = [
    defineFormCommandHandler('checkbox', (form, key, target) => {
        collectCommands(
            target,
            form.command,
            (command) => renderCheckboxCommand(key, command),
        );
    }),
    defineFormCommandHandler('input', (form, key, target) => {
        collectCommands(
            target,
            form.command,
            (command) => renderInputCommand(key, command),
        );
    }),
    defineFormCommandHandler('radio', (form, key, target) => {
        for (const option of form.options) {
            collectCommands(
                target,
                option.command,
                (command) => renderRadioCommand(key, option, command),
            );
        }
    }),
];

const expectedFormTypes = ['checkbox', 'input', 'radio'] as const;
type MissingFormType = Exclude<Form['type'], typeof expectedFormTypes[number]>;
const allFormTypesCovered: MissingFormType extends never ? true : never = true;
void allFormTypesCovered;

const validateFormCommandHandlers = (): void => {
    const registeredTypes = new Set<Form['type']>();

    for (const handler of formCommandHandlers) {
        if (registeredTypes.has(handler.type)) {
            throw new Error(`表单命令处理器重复：${handler.type}`);
        }

        registeredTypes.add(handler.type);
    }

    for (const type of expectedFormTypes) {
        if (!registeredTypes.has(type)) {
            throw new Error(`缺少表单命令处理器：${type}`);
        }
    }
};

const validateGroup = (
    group: FormGroup,
    allKeys: Set<string>,
): void => {
    for (const child of group.children) {
        if (child.type === 'group') {
            validateGroup(child, allKeys);
            continue;
        }

        if (!/^[A-Za-z0-9_]+$/.test(child.key)) {
            throw new Error(`表单 key 只能包含英文字母、数字和下划线：${child.key}`);
        }

        resolveOptionKey(child.key);
        const comparableKey = child.key.toLocaleLowerCase('en-US');

        if (allKeys.has(comparableKey)) {
            throw new Error(`表单 key 重复：${child.key}`);
        }

        allKeys.add(comparableKey);

        if (child.type === 'radio') {
            const values = new Set<string>();

            for (const option of child.options) {
                if (values.has(option.value)) {
                    throw new Error(
                        `radio ${child.key} 的 value 重复：${option.value}`,
                    );
                }

                values.add(option.value);
            }

            if (!values.has(child.defaultValue)) {
                throw new Error(
                    `radio ${child.key} 的默认值不存在：${child.defaultValue}`,
                );
            }
        }
    }
};

const validatePages = (formPages: FormPage[]): void => {
    const allKeys = new Set<string>();

    for (const page of formPages) {
        for (const group of page.groups) {
            validateGroup(group, allKeys);
        }
    }
};

const collectFormCommands = (
    form: Form,
    target: CollectedCommands,
): void => {
    const key = resolveOptionKey(form.key);
    const handler = formCommandHandlers.find(({ type }) => type === form.type);

    if (handler === undefined) {
        throw new Error(`缺少表单命令处理器：${form.type}`);
    }

    handler.collect(form, key, target);
};

const collectGroupCommands = (
    group: FormGroup,
    target: CollectedCommands,
): void => {
    for (const child of group.children) {
        if (child.type === 'group') {
            collectGroupCommands(child, target);
        } else {
            collectFormCommands(child, target);
        }
    }
};

const collectPageCommands = (page: FormPage): Map<FormStage, string[]> => {
    const collected: CollectedCommands = new Map();

    for (const group of page.groups) {
        collectGroupCommands(group, collected);
    }

    return collected;
};

const loadBatchTemplate = async (stage: FormStage): Promise<string> => {
    const templatePath = path.join(templateDir, `${stage}.bat`);
    const template = await readFile(templatePath, 'utf8');

    const placeholderCount = template.match(/\{\{commands\}\}/g)?.length ?? 0;

    if (placeholderCount !== 1) {
        throw new Error(
            `BAT 模板必须包含且仅包含一个 {{commands}} 占位符：${templatePath}`,
        );
    }

    return template;
};

const encodeOutput = (task: OutputTask): EncodedOutputTask => {
    const content = task.content
        .replaceAll('\r\n', '\n')
        .replaceAll('\r', '\n')
        .replaceAll('\n', '\r\n');

    if (task.encoding === 'utf8') {
        return { path: task.path, content: Buffer.from(content, 'utf8') };
    }

    const encoded = iconv.encode(content, 'gb2312');
    const decoded = iconv.decode(encoded, 'gb2312');

    if (decoded !== content) {
        throw new Error(`输出包含 GB2312 无法表示的字符：${task.path}`);
    }

    return { path: task.path, content: encoded };
};

const writeOutput = async (task: EncodedOutputTask): Promise<void> => {
    await mkdir(path.dirname(task.path), { recursive: true });
    await writeFile(task.path, task.content);
};

const replaceDist = async (tasks: EncodedOutputTask[]): Promise<void> => {
    const stagingDir = await mkdtemp(path.join(projectDir, '.dist-'));
    const backupDir = path.join(projectDir, 'dist.backup');
    let oldDistMoved = false;

    try {
        await Promise.all(tasks.map((task) => {
            const relativePath = path.relative(distDir, task.path);
            return writeOutput({
                path: path.join(stagingDir, relativePath),
                content: task.content,
            });
        }));

        await rm(backupDir, { recursive: true, force: true });

        try {
            await rename(distDir, backupDir);
            oldDistMoved = true;
        } catch (error) {
            if ((error as NodeJS.ErrnoException).code !== 'ENOENT') {
                throw error;
            }
        }

        try {
            await rename(stagingDir, distDir);
        } catch (error) {
            if (oldDistMoved) {
                await rename(backupDir, distDir);
                oldDistMoved = false;
            }

            throw error;
        }

        if (oldDistMoved) {
            await rm(backupDir, { recursive: true, force: true });
        }
    } finally {
        await rm(stagingDir, { recursive: true, force: true });
    }
};

export async function main(pages: FormPage[]): Promise<void> {
    validateFormCommandHandlers();
    validatePages(pages);

    const outputTasks: OutputTask[] = [];
    const batchSections = new Map<FormStage, BatchSection[]>();
    const pageOutputs = new Set<string>();

    for (const page of pages) {
        const outputPath = resolvePageOutput(page.page);

        const comparableOutputPath = process.platform === 'win32'
            ? outputPath.toLocaleLowerCase('en-US')
            : outputPath;

        if (pageOutputs.has(comparableOutputPath)) {
            throw new Error(`页面输出路径重复：${outputPath}`);
        }

        pageOutputs.add(comparableOutputPath);
        outputTasks.push({
            path: outputPath,
            content: renderPage(page),
            encoding: 'gb2312',
        });

        for (const [stage, commands] of collectPageCommands(page)) {
            const sections = batchSections.get(stage) ?? [];
            sections.push({
                title: page.batchTitle ?? page.title ?? page.page,
                commands,
            });
            batchSections.set(stage, sections);
        }
    }

    for (const [stage, sections] of batchSections) {
        const template = await loadBatchTemplate(stage);
        const commands = sections
            .map((section) => renderBatchSection(
                section.title,
                section.commands,
            ))
            .join('\n\n');

        outputTasks.push({
            path: path.join(distDir, `${stage}.bat`),
            content: renderBatchTemplate(template, commands),
            encoding: 'utf8',
        });
    }

    const encodedTasks = outputTasks.map(encodeOutput);

    await replaceDist(encodedTasks);
}

const entryPath = process.argv[1] === undefined
    ? undefined
    : path.resolve(process.argv[1]);
const modulePath = fileURLToPath(import.meta.url);
const isEntry = entryPath !== undefined && (
    process.platform === 'win32'
        ? entryPath.toLocaleLowerCase('en-US') === modulePath.toLocaleLowerCase('en-US')
        : entryPath === modulePath
);

if (isEntry) {
    await main(pages);
}
