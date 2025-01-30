import { LightningElement, wire, track } from 'lwc';
import getAccounts from '@salesforce/apex/accountHelper.getAccounts';
import deleteAccount from '@salesforce/apex/accountHelper.deleteAccount';
import { refreshApex } from '@salesforce/apex';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_REVENUE from '@salesforce/schema/Account.AnnualRevenue';

export default class ParentComponent extends LightningElement {
    @track accounts;
    
    accountName = ACCOUNT_NAME;
    accountRevenue = ACCOUNT_REVENUE;

    @wire(getAccounts)
    wiredAccounts(result) {
        this.accounts = result;
    }

    handleAccountCreated(event) {
        refreshApex(this.accounts)
            .then(() => {
                this.template.querySelectorAll('lightning-input-field').forEach(field => {
                    field.reset();
                });
            });
    }

    handleAccountDelete(event) {
        const recordId = event.detail;
        deleteAccount({ id: recordId })
            .then(() => {
                return refreshApex(this.accounts);
            })
            .catch(error => {
                console.error("Error deleting account: ", error);
            });
    }

    handleError(event) {
        console.error("Error creating account:", event.detail);
    }
}
