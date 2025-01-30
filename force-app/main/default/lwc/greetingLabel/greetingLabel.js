import { LightningElement } from 'lwc';
import GREETING_LABEL from '@salesforce/label/c.Greeting'; 

export default class GreetingComponent extends LightningElement {
    greeting = GREETING_LABEL;
}
