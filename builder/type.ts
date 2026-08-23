// Form
interface FormCtx {
    val:string;
}

interface BasicForm {
    key:string;
    label:string;
    command: (ctx:FormCtx)=>string;
}

export interface CheckboxForm extends BasicForm {
    type:'checkbox';
    checked?:boolean;
}

export interface InputForm extends BasicForm {
    type:'input';
    defaultValue?:string;
}

// Structure
export interface FormGroup {
    label:string;
    forms:BasicForm[];
}
export interface FormPage {
    page:string;
    title:string;
    groups:FormGroup[];
}