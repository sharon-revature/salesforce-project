import { api, LightningElement, wire } from 'lwc';
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import FNAME_FIELD from "@salesforce/schema/Contact.FirstName";
import LNAME_FIELD from "@salesforce/schema/Contact.LastName";
import EMAIL_FIELD from "@salesforce/schema/Contact.Email";
import PHONE_FIELD from "@salesforce/schema/Contact.Phone";

export default class contactInfo extends LightningElement {
    @api recordId;

    @wire(getRecord, {
        recordId: "$recordId",
        fields: [FNAME_FIELD, LNAME_FIELD, EMAIL_FIELD, PHONE_FIELD]
    })
    contact;

    renderedCallback(){
        console.log('CONTACT: ' + JSON.stringify(this.contact));
    }

    get firstName() {
        return getFieldValue(this.contact.data, FNAME_FIELD);
    }

    get lastName() {
        return getFieldValue(this.contact.data, LNAME_FIELD);
    }

    get email() {
        return getFieldValue(this.contact.data, EMAIL_FIELD);
    }

    get phone() {
        return getFieldValue(this.contact.data, PHONE_FIELD);
    }

    get fullName() {
        return `${this.firstName} ${this.lastName}`;
    }
}
