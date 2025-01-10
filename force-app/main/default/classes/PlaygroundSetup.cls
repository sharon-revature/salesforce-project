    public with sharing class PlaygroundSetup {
        List<String> firstNames = new List<String> {'Rose', 'Martha', 'Donna', 'Amy', 'Rory', 'Clara', 'Bill', 'Yasmin', 'Ryan', 'Graham', 'Dan', 'Ruby'};
        List<String> lastNames = new List<String> {'Tyler', 'Jones', 'Noble', 'Pond', 'Williams', 'Oswald', 'Potts', 'Khan', 'Sinclair', 'Cole', 'Lewis', 'Sunday'};
        
        // Helper: generate accounts
        public static List<Account> createAccounts(Integer numAcc){
            List<Account> accounts = new List<Account>();
            for (Integer i = 0; i < numAcc; i++) {
                // unique account name by index
                Account acc = new Account(name = 'Account ' + i);
                // random annual revenue (AR) between 1,0000 and 3,000,000
                acc.AnnualRevenue = Math.floor(Math.random() * (3000000 - 100000) + 100000).intValue();
                // Rating: Cold (AR < 75K), Warm (75K <= AR < 750K), Hot (750K <= AR)
                if (acc.AnnualRevenue < 75000) {
                    acc.Rating = 'Cold';
                } else if (acc.AnnualRevenue < 750000) {
                    acc.Rating = 'Warm';
                } else {
                    acc.Rating = 'Hot';
                }
                accounts.add(acc);
            }
            insert accounts;
            return accounts;
        }
        
        // Helper: generate Contacts
        public static List<Contact> createContacts(List<Account> accounts, Integer numContactsPerAccount){
            List<Contact> contacts = new List<Contact>();
            
            // need to assign contact to acc - lost train of thoughts
            for (Account acc : accounts) {
                Integer numContacts =
            }
            for (Integer i = 0; i < numContacts; i++) {
                Contact con = new Contact(
                    firstName = firstNames.get(Math.floor(Math.random() * firstNames.size()).intValue()),
                lastName = lastNames.get(Math.floor(Math.random() * lastNames.size()).intValue()),
                email = con.firstName + con.lastName + '@' + accName + '.com');
                
                contacts.add(con);
            }
        }
        public SetUp(Integer numAcc, Integer numLeads) {
            
            
            
            
            
            /* Each account with unique name
            random annual revenue (AR) between 1,0000 and 3,000,000
                Rating: Cold (AR < 75K), Warm (75K <= AR < 750K), Hot (750K <= AR)
                random numContacts 0-4
                 */
            /* Each contact - a random name from list of first and last names
            - Email: LN + FN + '@' + AccountName + '.com'
                 */
            /* Each Lead - random name from list
            random company name matched Account name
                email : LN + FN + '@' + CompanyName + '.com'
                 */
            /* Each Product - random price in standard pricebook
            - a name
                - unique product code
                 */
        }
}}