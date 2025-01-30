import { LightningElement, track } from 'lwc';
import searchContacts from '@salesforce/apex/contactHelper.searchContacts';

export default class ContactSearch extends LightningElement {
    searchTerm = '';        
    @track contacts = [];  
    error;

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
