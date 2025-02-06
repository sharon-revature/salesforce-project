const { jestConfig } = require('@salesforce/sfdx-lwc-jest/config');

module.exports = {
    ...jestConfig,
    modulePathIgnorePatterns: ['<rootDir>/.localdevserver'],
    moduleNameMapper: {
        '^@salesforce/apex/.+$': '<rootDir>/force-app/test/mocks/apexMock.js' 
    }
};
