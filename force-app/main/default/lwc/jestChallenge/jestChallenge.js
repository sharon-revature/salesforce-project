import { LightningElement, track } from 'lwc';

export default class JestChallenge extends LightningElement {
    @track userInput = '';

    handleInputChange(event) {
        this.userInput = event.target.value;
    }

    handleButtonClick() {
        this.template.querySelector('p').textContent = this.userInput;
    }
}
