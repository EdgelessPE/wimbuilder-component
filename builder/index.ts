import { mkdir, readFile, rm, writeFile } from 'node:fs/promises';
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
}

interface BatchSection {
    title: string;
    commands: string[];
}

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
    const pageDir = path.resolve(distDir, page);
    const relative = path.relative(distDir, pageDir);

    if (relative.startsWith('..') || path.isAbsolute(relative)) {
        throw new Error(`页面目录不能位于 dist 之外：${page}`);
    }

    return path.join(pageDir, 'main.html');
};

const collectCommands = (
    target: Map<FormStage, string[]>,
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
        target: Map<FormStage, string[]>,
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
        target: Map<FormStage, string[]>,
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

const collectFormCommands = (
    form: Form,
    target: Map<FormStage, string[]>,
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
    target: Map<FormStage, string[]>,
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
    const commands = new Map<FormStage, string[]>();

    for (const group of page.groups) {
        collectGroupCommands(group, commands);
    }

    return commands;
};

const loadBatchTemplate = async (stage: FormStage): Promise<string> => {
    const templatePath = path.join(templateDir, `${stage}.bat`);
    const template = await readFile(templatePath, 'utf8');

    if (!template.includes('{{commands}}')) {
        throw new Error(`BAT 模板缺少 {{commands}} 占位符：${templatePath}`);
    }

    return template;
};

const writeGb2312 = async (task: OutputTask): Promise<void> => {
    await mkdir(path.dirname(task.path), { recursive: true });
    await writeFile(task.path, iconv.encode(task.content, 'gb2312'));
};

export async function main(pages: FormPage[]): Promise<void> {
    const outputTasks: OutputTask[] = [];
    const batchSections = new Map<FormStage, BatchSection[]>();
    const pageOutputs = new Set<string>();

    for (const page of pages) {
        const outputPath = resolvePageOutput(page.page);

        if (pageOutputs.has(outputPath)) {
            throw new Error(`页面输出路径重复：${outputPath}`);
        }

        pageOutputs.add(outputPath);
        outputTasks.push({
            path: outputPath,
            content: renderPage(page),
        });

        for (const [stage, commands] of collectPageCommands(page)) {
            const sections = batchSections.get(stage) ?? [];
            sections.push({ title: page.title, commands });
            batchSections.set(stage, sections);
        }
    }

    for (const [stage, sections] of batchSections) {
        const template = await loadBatchTemplate(stage);
        const commands = sections
            .map((section) => renderBatchSection(section.title, section.commands))
            .join('\n\n');

        outputTasks.push({
            path: path.join(distDir, `${stage}.bat`),
            content: renderBatchTemplate(template, commands),
        });
    }

    await rm(distDir, { recursive: true, force: true });
    await Promise.all(outputTasks.map(writeGb2312));
}

await main(pages);
