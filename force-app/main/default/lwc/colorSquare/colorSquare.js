import { LightningElement } from 'lwc';

export default class ColorSquare extends LightningElement {
    squareClass = 'square';


    changeColorToRed() {
        this.squareClass = 'square red'; 
    }

    changeColorToGreen() {
        this.squareClass = 'square green'; 
    }

    changeColorToBlue() {
        this.squareClass = 'square blue'; 
    }
}
