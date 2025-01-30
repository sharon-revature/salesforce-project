import { LightningElement } from 'lwc';

export default class ParentLwc extends LightningElement {
    isChallenge1Visible = false;
    handleToggleVisibility() {
         this.isChallenge1Visible = !this.isChallenge1Visible;
    }
}