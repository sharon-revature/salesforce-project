import { LightningElement, api, wire } from 'lwc';
import getContactInfo from '@salesforce/apex/contactHelper.getContactInfo';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ContactInfo extends LightningElement {
    @api recordId; 
    contact;
    error;

    @wire(getContactInfo, { contactId: '$recordId' })
    wiredContact({ error, data }) {
        if (data) {
            this.contact = data;
            this.error = undefined;
        } else if (error) {
            this.error = error.body.message;
            this.contact = undefined;
            const event = new ShowToastEvent({
                title: 'Error loading contact information',
                message: this.error,
                variant: 'error',
            });
            this.dispatchEvent(event);
        }
    }
}
