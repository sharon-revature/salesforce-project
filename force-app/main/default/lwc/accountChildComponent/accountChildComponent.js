import { LightningElement, api } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api account;

    handleDelete(event) {
        const recordId = event.target.dataset.recordid;
        this.dispatchEvent(new CustomEvent('delete', { detail: recordId }));
    }

    handleSuccess() {
        this.dispatchEvent(new CustomEvent('accountupdated'));
    }
}
