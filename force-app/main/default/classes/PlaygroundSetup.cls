public with sharing class PlaygroundSetup {
    
    // Helper: generate accounts
    public static List<Account> createAccounts(Integer numAcc){
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < numAcc; i++) {
            // unique account name by index
            Account acc = new Account(name = 'Account ' + i);
            // random annual revenue (AR) between 1,0000 and 3,000,000
            // need math.floor() and intValue() to ensure that AR is an integer value
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
        // return accounts to use in other functions
        return accounts;
    }
    
    // Helper: generate Contacts
    public static List<Contact> createContacts(List<Account> accounts){
        List<Contact> contacts = new List<Contact>();
        List<String> firstNames = new List<String> {'Rose', 'Martha', 'Donna', 'Amy', 'Rory', 'Clara', 'Bill', 'Yasmin', 'Ryan', 'Graham', 'Dan', 'Ruby'};
        List<String> lastNames = new List<String> {'Tyler', 'Jones', 'Noble', 'Pond', 'Williams', 'Oswald', 'Potts', 'Khan', 'Sinclair', 'Cole', 'Lewis', 'Sunday'};
        // assign n number of contacts to each account
        for (Account acc : accounts) {
            // generate random number of contacts 0 - 4
            Integer numContacts = Math.floor(Math.random() * 5).intValue();
            for (Integer i = 0; i < numContacts; i++) {
                // get a random index
                Integer nameIndex = Math.floor(Math.random()* firstNames.size()).intValue();
                String firstName = firstNames[nameIndex];
                String lastName = lastNames[nameIndex];
                Contact con = new Contact(
                    FirstName = firstName,
                LastName = lastName,
                Email = firstName + lastName + '@' + acc.Name + '.com');
                // set accountID of contact
                con.accountId = acc.id;
                contacts.add(con);
            }
        }
        insert contacts;
        return contacts;
    }
    
    // Helper: generate Leads
    public static List<Lead> createLeads(List<Account> accounts, List<Contact> contacts, Integer numLeads) {
        List<Lead> leads = new List<Lead>();
        for (Contact con : contacts) {
            for (Integer i = 0; i < numLeads; i++) {
                Lead l = new Lead(FirstName = con.FirstName, LastName = con.LastName, Company = con.Account.Name, Email = con.Email);
                leads.add(l);
            }
        }
        insert leads;
        return leads;
    }
    
    // Helper: generate products
    public static List<Product2> createProducts(Integer numProd) {
        List<Product2> products = new List<Product2>();
        for (Integer i = 0; i < numProd; i++) {
            Product2 prod = new Product2(Name = 'Product ' + i, ProductCode = 'Prod-' + i, isActive = true);
            products.add(prod);
        }
        insert products;
        
        // add each product to the Standard Pricebook with a random price
        List<PricebookEntry> pricebookEntries = new List<PricebookEntry>();
        for (Product2 prod : products) {
            PricebookEntry entry = new PricebookEntry(Pricebook2Id = '01sRK000003coi1YAA', Product2Id = prod.Id, UnitPrice = Math.random() * 100, isActive = true);
            pricebookEntries.add(entry);
        }
        insert products;
        return products;
    }
    
    public static void SetUp(Integer numRecords) {
        List<Account> accounts = createAccounts(numRecords);
        List<Contact> contacts = createContacts(accounts);
        createLeads(accounts, contacts, numRecords);
        createProducts(numRecords / 2);
    }
}