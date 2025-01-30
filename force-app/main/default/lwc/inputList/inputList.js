import { LightningElement, track } from 'lwc';

export default class InputList extends LightningElement {
    @track items = [];

    addItemToList() {
        const inputValue = this.refs.input.value;
        if (inputValue) {
            this.items.push(inputValue);
            this.refs.input.value = ''; 
        }
    }
}
