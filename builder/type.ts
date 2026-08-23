// Command
export interface FormCtx {
    val: string;
}

export interface FormCommand {
    command: (ctx: FormCtx) => string | string[];
    commented?: boolean;
}

// Form
interface BasicForm {
    key: string;
    label: string;
}

export interface CheckboxForm extends BasicForm {
    type: 'checkbox';
    checked?: boolean;
    command: FormCommand;
}

export interface InputForm extends BasicForm {
    type: 'input';
    defaultValue?: string;
    command: FormCommand;
}

export interface RadioOption {
    label: string;
    value: string;
    command?: FormCommand;
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
    title: string;
    groups: FormGroup[];
}
