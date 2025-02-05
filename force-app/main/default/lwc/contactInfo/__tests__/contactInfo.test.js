import { createElement } from 'lwc';
import ContactInfo from 'c/contactInfo';
import { getRecord } from 'lightning/uiRecordApi';

const mockGetRecord = {
    "apiName": "Contact",
    "childRelationships": {},
    "fields": {
        "FirstName": { "displayValue": null, "value": "John" },
        "LastName": { "displayValue": null, "value": "Doe" },
        "Email": { "displayValue": null, "value": "johndoe@example.com" },
        "Phone": { "displayValue": null, "value": "123-456-7890" }
    }
};

describe('c-contact-Info', () => {
    afterEach(() => {
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    async function flushPromises() {
        return Promise.resolve();
    }

    it('renders the record values correctly in the p tags', async () => {
        const element = createElement('c-contact-Info', {
            is: ContactInfo
        });

        document.body.appendChild(element);

        // emit data from @wire
        getRecord.emit(mockGetRecord);

        await flushPromises();

        const pEls = element.shadowRoot.querySelectorAll('p');
        
        expect(`Name: ${mockGetRecord.fields.FirstName.value} ${mockGetRecord.fields.LastName.value}`).toEqual(pEls[0].textContent.trim());
        expect(`Email: ${mockGetRecord.fields.Email.value}`).toEqual(pEls[1].textContent.trim());
        expect(`Phone: ${mockGetRecord.fields.Phone.value}`).toEqual(pEls[2].textContent.trim());
    });
});
