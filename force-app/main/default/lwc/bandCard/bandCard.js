import { LightningElement, api } from 'lwc';

export default class BandCard extends LightningElement {
    @api bandName;
    @api bandImage;
    @api bandDescription;

    handleLearnMore() {
        const event = new CustomEvent('learnmore', {
            detail: { description: this.bandDescription }
        });
        this.dispatchEvent(event);
    }
}
