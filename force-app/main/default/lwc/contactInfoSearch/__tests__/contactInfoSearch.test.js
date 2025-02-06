import { createElement } from 'lwc';
import ContactInfoSearch from 'c/contactInfoSearch';
import { searchContacts } from '@salesforce/apex/contactHelper.searchContacts'; 

//having issues with calling searchContacts with mock data

describe('c-contact-info-search', () => {
    afterEach(() => {
        // Reset the DOM after each test case
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    async function flushPromises() {
        return Promise.resolve();
    }

    it('displays contacts when search term matches', async () => {
        const element = createElement('c-contact-info-search', {
            is: ContactInfoSearch
        });
        document.body.appendChild(element);

        const mockContacts = [
            { Id: '003E100000feZkcIAE', FirstName: 'John', LastName: 'Doe', Email: 'johndoe@example.com', Phone: '123-456-7890' },
            { Id: '003E100000feZkdABC', FirstName: 'Jane', LastName: 'Doe', Email: 'janedoe@example.com', Phone: '987-654-3210' }
        ];

        // Simulate the apex method being called and resolving the mock data 
        searchContacts.mockResolvedValue(mockContacts);

        element.searchTerm = 'Doe'; 
        const searchButton = element.shadowRoot.querySelector('lightning-button');
        searchButton.click();

        // Wait for any asynchronous DOM updates
        await flushPromises();

        // Select all the <p> tags and validate the rendered output
        const pEls = element.shadowRoot.querySelectorAll('p');
        
        expect(pEls.length).toBe(8);  

        expect(pEls[0].textContent).toBe('First Name: John');
        expect(pEls[1].textContent).toBe('Last Name: Doe');
        expect(pEls[2].textContent).toBe('Email: johndoe@example.com');
        expect(pEls[3].textContent).toBe('Phone: 123-456-7890');

        expect(pEls[4].textContent).toBe('First Name: Jane');
        expect(pEls[5].textContent).toBe('Last Name: Doe');
        expect(pEls[6].textContent).toBe('Email: janedoe@example.com');
        expect(pEls[7].textContent).toBe('Phone: 987-654-3210');
    });

    it('displays error message when no contacts are found', async () => {
        // Create component
        const element = createElement('c-contact-info-search', {
            is: ContactInfoSearch
        });
        document.body.appendChild(element);

        // Mock empty response for no contacts found
        searchContacts.mockResolvedValue([]); 

        element.searchTerm = 'NonExisting';
        const searchButton = element.shadowRoot.querySelector('lightning-button');
        searchButton.click();

        // Wait for any asynchronous DOM updates
        await flushPromises();

        const errorEl = element.shadowRoot.querySelector('.slds-text-color_error');
        expect(errorEl).not.toBeNull();
        expect(errorEl.textContent).toBe('No contacts found');
    });
});
