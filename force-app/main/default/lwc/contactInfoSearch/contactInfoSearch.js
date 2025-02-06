import { LightningElement, api, track } from 'lwc';
import searchContacts from '@salesforce/apex/contactHelper.searchContacts';

export default class ContactInfoSearch extends LightningElement {
    @api searchTerm = '';   // public for testing
    @track contacts = [];   // still reactive - no need to expose to tests
    @api error;             // public for testing

    handleSearchTermChange(event) {
        this.searchTerm = event.target.value;
    }

    handleSearchClick() {
        if (this.searchTerm) {
            this.fetchContacts(this.searchTerm);
        }
    }

    fetchContacts(searchTerm) {
        searchContacts({ searchTerm: searchTerm })
            .then(result => {
                this.contacts = result;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error.body.message;
                this.contacts = [];
            });
    }
}
