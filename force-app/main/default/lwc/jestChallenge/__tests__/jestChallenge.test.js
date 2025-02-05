import { createElement } from 'lwc';
import JestChallenge from 'c/jestChallenge';

describe('c-jest-challenge', () => {
    beforeEach(() => {
        // Set up the component before each test
        const element = createElement('c-jest-challenge', {
            is: JestChallenge
        });
        document.body.appendChild(element);
    });

    afterEach(() => {
        // Clean up the DOM after each test
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('updates the displayed text when button is clicked', async () => {
        // Arrange
        const element = document.querySelector('c-jest-challenge');
        const inputEl = element.shadowRoot.querySelector('lightning-input');
        const buttonEl = element.shadowRoot.querySelector('lightning-button');

        // Act: Simulate user input
        inputEl.value = 'Hello, Jest!';
        inputEl.dispatchEvent(new CustomEvent('change'));

        // Act: Simulate button click
        buttonEl.click();

        // Wait for DOM updates
        await Promise.resolve();

        // Assert: Check if paragraph contains updated text
        const pEl = element.shadowRoot.querySelector('p');
        expect(pEl.textContent).toBe('Hello, Jest!');
    });
});
