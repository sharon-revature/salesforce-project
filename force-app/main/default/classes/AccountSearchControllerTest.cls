/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 *
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
public class AccountSearchControllerTest {
    
    // test data setup
    private static void setupTestData() {
        // Account with Contacts
        Account acc1 = new Account(Name = 'Test Account 1', Industry = 'Technology', Phone = '1234567890');
        insert acc1;
        
        Contact contact1 = new Contact(LastName = 'Contact 1', AccountId = acc1.Id);
        Contact contact2 = new Contact(LastName = 'Contact 2', AccountId = acc1.Id);
        insert new List<Contact>{contact1, contact2};
        
        // Account without Contacts
        Account acc2 = new Account(Name = 'Test Account 2', Industry = 'Finance', Phone = '0987654321');
        insert acc2;
    }
    
    @isTest
    static void testSearchAccountWithResults() {
        setupTestData();
        
        // instantiate the controller
        AccountSearchController controller = new AccountSearchController();
        controller.searchKey = 'Test Account 1';
        
        controller.searchAccount();
        
        System.assert(controller.hasResults, 'Expected hasResults to be true.');
        System.assert(!controller.hasNoResults, 'Expected hasNoResults to be false.');
        System.assertEquals('Test Account 1', controller.account.Name, 'Account name mismatch.');
    }
    
    @isTest
    static void testSearchAccountWithoutResults() {
        setupTestData();
        
        AccountSearchController controller = new AccountSearchController();
        controller.searchKey = 'Nonexistent Account';
        
        controller.searchAccount();
        
        System.assert(!controller.hasResults, 'Expected hasResults to be false.');
        System.assert(controller.hasNoResults, 'Expected hasNoResults to be true.');
    }
    
    @isTest
    static void testSearchAccountWithNoContacts() {
        setupTestData();
        
        AccountSearchController controller = new AccountSearchController();
        controller.searchKey = 'Test Account 2';
        
        controller.searchAccount();
        
        System.assert(controller.hasResults, 'Expected hasResults to be true.');
        System.assert(!controller.hasNoResults, 'Expected hasNoResults to be false.');
        System.assertEquals('Test Account 2', controller.account.Name, 'Account name mismatch.');
    }
    
    @isTest
    static void testNullSearchKey() {
        setupTestData();
        
        AccountSearchController controller = new AccountSearchController();
        // edge case: Null search key
        controller.searchKey = null;
        
        Test.startTest();
        controller.searchAccount();
        Test.stopTest();
        
        System.assert(!controller.hasResults, 'Expected hasResults to be false.');
        System.assert(controller.hasNoResults, 'Expected hasNoResults to be true.');
    }
    
    @isTest
    static void testEmptySearchKey() {
        setupTestData();
        
        AccountSearchController controller = new AccountSearchController();
        // edge case: Empty string
        controller.searchKey = '';
        
        Test.startTest();
        controller.searchAccount();
        Test.stopTest();
        
        System.assert(!controller.hasResults, 'Expected hasResults to be false.');
    System.assert(controller.hasNoResults, 'Expected hasNoResults to be true.');    }
    
}