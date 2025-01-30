import { LightningElement } from 'lwc';

export default class HeaderInputToggle extends LightningElement {
    headerText = 'Initial Header Text';
    inputValue = ''; 
    isInputVisible = false;
    buttonLabel = 'Show Input'; 

    toggleInputVisibility() {
        this.isInputVisible = !this.isInputVisible;
        this.buttonLabel = this.isInputVisible ? 'Hide Input' : 'Show Input';
    }

    handleInputChange(event) {
        this.inputValue = event.target.value; 
        this.headerText = this.inputValue || 'Initial Header Text'; 
    }
}
