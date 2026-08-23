import type {
    CheckboxForm,
    Form,
    FormCommand,
    FormGroup,
    FormPage,
    InputForm,
    RadioForm,
    RadioOption,
} from './type.ts';

const indent = (content: string, spaces = 2): string => {
    const prefix = ' '.repeat(spaces);
    return content
        .split('\n')
        .map((line) => `${prefix}${line}`)
        .join('\n');
};

const comment = (content: string): string => content
    .split('\n')
    .map((line) => line.length === 0 ? '@REM' : `@REM ${line}`)
    .join('\n');

export const escapeHtml = (value: string): string => value
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&#39;');

export const renderPageTitle = (title: string): string =>
    `<legend>${escapeHtml(title)}</legend>`;

export const renderCheckbox = (form: CheckboxForm): string => {
    const checked = form.checked ? ['    checked'] : [];

    return [
        '<label>',
        '  <input',
        '    type="checkbox"',
        `    name="Edgeless.${escapeHtml(form.key)}"`,
        '    class="opt_item"',
        ...checked,
        '  />',
        `  ${escapeHtml(form.label)}`,
        '</label>',
    ].join('\n');
};

export const renderInput = (form: InputForm): string => {
    const value = form.defaultValue === undefined
        ? ''
        : ` value="${escapeHtml(form.defaultValue)}"`;

    return [
        `<label class="left_label">${escapeHtml(form.label)}:</label><br/>`,
        `<input type="text" name="Edgeless.${escapeHtml(form.key)}" class="right_val opt_item"${value}/>`
    ].join('\n');
};

const renderRadioOption = (
    form: RadioForm,
    option: RadioOption,
): string => {
    const checked = option.value === form.defaultValue ? ' checked' : '';

    return [
        '<label>',
        `  <input type="radio" class="opt_item" name="Edgeless.${escapeHtml(form.key)}" value="${escapeHtml(option.value)}"${checked} />`,
        `  ${escapeHtml(option.label)}`,
        '</label>',
    ].join('\n');
};

export const renderRadio = (form: RadioForm): string =>
    form.options.map((option) => renderRadioOption(form, option)).join('\n<br />\n');

export const renderForm = (form: Form): string => {
    switch (form.type) {
        case 'checkbox':
            return renderCheckbox(form);
        case 'input':
            return renderInput(form);
        case 'radio':
            return renderRadio(form);
    }
};

const renderGroupChild = (child: Form | FormGroup): string =>
    child.type === 'group' ? renderGroup(child) : renderForm(child);

export const renderGroup = (group: FormGroup): string => {
    const children = group.children.map(renderGroupChild).join('\n');

    if (group.label === undefined) {
        return children;
    }

    return [
        '<fieldset>',
        `  <legend>${escapeHtml(group.label)}</legend>`,
        indent(children),
        '</fieldset>',
    ].join('\n');
};

export const renderPage = (page: FormPage): string => [
    renderPageTitle(page.title),
    ...page.groups.map(renderGroup),
    '',
].join('\n');

export const renderCommandBody = (
    formCommand: FormCommand,
    value: string,
): string => {
    const output = formCommand.command({ val: value });
    return Array.isArray(output) ? output.join('\n') : output;
};

const renderCondition = (
    condition: string,
    body: string,
    commented?: boolean,
): string => {
    const result = [
        `if ${condition} (`,
        indent(body),
        ')',
    ].join('\n');

    return commented ? comment(result) : result;
};

export const renderCheckboxCommand = (
    key: string,
    formCommand: FormCommand,
): string => {
    const value = `%opt[${key}]%`;
    const body = renderCommandBody(formCommand, value);
    return renderCondition(`"x${value}"=="xtrue"`, body, formCommand.commented);
};

export const renderInputCommand = (
    key: string,
    formCommand: FormCommand,
): string => {
    const value = `%opt[${key}]%`;
    const body = renderCommandBody(formCommand, value);
    return formCommand.commented ? comment(body) : body;
};

export const renderRadioCommand = (
    key: string,
    option: RadioOption,
    formCommand: FormCommand,
): string => {
    const value = `%opt[${key}]%`;
    const body = renderCommandBody(formCommand, value);
    return renderCondition(
        `"x${value}"=="x${option.value}"`,
        body,
        formCommand.commented,
    );
};

export const renderBatchSection = (
    title: string,
    commands: string[],
): string => [
    `::${title}`,
    commands.join('\n\n'),
].join('\n');

export const renderBatchTemplate = (
    template: string,
    commands: string,
): string => template.replace('{{commands}}', commands);
