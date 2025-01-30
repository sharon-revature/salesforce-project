import { LightningElement } from 'lwc';
import createCase from '@salesforce/apex/caseHelper.createCase';
import {refreshApex} from '@salesforce/apex';

export default class CaseForm extends LightningElement {

    async createCase() {
        await createCase({origin: this.refs.origin.value, status: this.refs.status.value});
        this.dispatchEvent(new CustomEvent('casecreate'));
    }
}