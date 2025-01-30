import { LightningElement, wire } from 'lwc';
import getHighPriorityCases from '@salesforce/apex/caseHelper.getHighPriorityCases';
import { refreshApex} from '@salesforce/apex';

export default class HighPriortyCases extends LightningElement {
    @wire(getHighPriorityCases)
    caseList;
    columns = [
        {label: 'Subject', fieldName:'Subject', type:'text'},
        {label: 'Account', fieldName:'AccountID', type:'text'},
        {label: 'Contact', fieldName:'ContactID', type:'text'}
    ];
    
}