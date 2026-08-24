// Command
export interface FormCtx {
    val: string;
}

export type FormStage = 'main' | 'last';

export interface FormCommand {
    stage?: FormStage;
    command: (ctx: FormCtx) => string | string[];
    commented?: boolean;
}

export type FormCommands = FormCommand | FormCommand[];

// Form
interface BasicForm {
    key: string;
    label: string;
    htmlCommented?: boolean;
}

export interface CheckboxForm extends BasicForm {
    type: 'checkbox';
    checked?: boolean;
    command: FormCommands;
}

export interface InputForm extends BasicForm {
    type: 'input';
    defaultValue?: string;
    command: FormCommands;
}

export interface RadioOption {
    label: string;
    value: string;
    command?: FormCommands;
}

export interface RadioForm extends BasicForm {
    type: 'radio';
    defaultValue: string;
    options: RadioOption[];
}

export type Form = CheckboxForm | InputForm | RadioForm;

// Structure
export interface FormGroup {
    type: 'group';
    label?: string;
    children: Array<Form | FormGroup>;
}

export interface FormPage {
    page: string;
    patchName?: string;
    title?: string;
    batchTitle?: string;
    groups: FormGroup[];
}
