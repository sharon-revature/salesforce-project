import { LightningElement, track } from 'lwc';

export default class FavoriteBands extends LightningElement {
    @track selectedDescription = 'Click "Learn More" to see details here.';

    bands = [
        {
            id: 1,
            name: 'Twice',
            image: 'https://upload.wikimedia.org/wikipedia/commons/e/ec/Logo_of_TWICE.svg',
            description: 'Twice is a South Korean girl group formed in 2015.'
        },
        {
            id: 2,
            name: 'Stray Kids',
            image: 'https://upload.wikimedia.org/wikipedia/commons/6/64/Stray_Kids_Logo_02.png',
            description: 'Stray Kids is a South Korean boy group formed in 2017.'
        },
        {
            id: 3,
            name: 'One Ok Rock',
            image: 'https://upload.wikimedia.org/wikipedia/commons/a/ac/AMBITIONS_%28English_version%29.svg',
            description: 'One Ok Rock is a Japanese rock band formed in 2005.'
        }
    ];

    handleLearnMore(event) {
        this.selectedDescription = event.detail.description;
    }
}
