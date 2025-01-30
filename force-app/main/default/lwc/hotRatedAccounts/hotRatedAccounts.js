import { LightningElement, wire, track } from 'lwc';
import getHotAccounts from '@salesforce/apex/accountHelper.getHotAccounts';
import createAccount from '@salesforce/apex/accountHelper.createAccount';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class HotRatedAccounts extends LightningElement {
    @track name = '';
    @track rating = '';
    @track industry = '';
    @track annualRevenue = null;
    @track accounts = [];
    error;
    wiredAccountsResult;

    ratingOptions = [
        { label: 'Hot', value: 'Hot' },
        { label: 'Warm', value: 'Warm' },
        { label: 'Cold', value: 'Cold' }
    ];

    @wire(getHotAccounts)
    wiredHotAccounts(result) {
        this.wiredAccountsResult = result;
        if (result.data) {
            this.accounts = result.data;
            this.error = undefined;
        } else if (result.error) {
            this.error = result.error;
            this.accounts = [];
        }
    }

    handleChange(event) {
        this[event.target.dataset.field] = event.target.value;
    }

    createAccount() {
        createAccount({
            name: this.name,
            rating: this.rating,
            industry: this.industry,
            revenue: parseFloat(this.annualRevenue) || 0
        })
            .then(() => {
                this.showToast('Success', 'Account created successfully!', 'success');
                this.resetForm();
                return refreshApex(this.wiredAccountsResult);
            })
            .catch(error => {
                this.showToast('Error', error.body.message, 'error');
            });
    }

    resetForm() {
        this.name = '';
        this.rating = '';
        this.industry = '';
        this.annualRevenue = null;
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}
