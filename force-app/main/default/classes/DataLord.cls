public class DataLord {
    // return number of Accounts that exist in org
    public static Integer NumAccounts() {
        return [SELECT COUNT() FROM Account];
    }
    
    // return number of Accounts with a Rating of Hot
    public static Integer NumHot() {
        return [SELECT COUNT() FROM Account WHERE Rating = 'Hot'];
    }
    
    // return Accounts with '&' in Name
    public static Integer NumComplex() {
        return [SELECT COUNT() FROM Account WHERE Name LIKE '%&%'];
    }
    
    // return top 5 Accounts in terms of Annual Revenue
    public static List<Account> BigFive() {
        return [SELECT Name, AnnualRevenue 
                FROM Account 
                ORDER BY AnnualRevenue DESC 
                NULLS LAST 
                LIMIT 5];
    }
    
    // return the Opportunity with most recent Close Date that had Amount over $100K
    public static Opportunity LastBigOpportunity() {
        return [SELECT Name, Amount, CloseDate
                FROM Opportunity 
                WHERE Amount > 100000 
                ORDER BY CloseDate DESC 
                NULLS LAST 
                LIMIT 1];
    }
    
    // return all Contacts that are associated to an Account with Rating Hot
    public static List<Contact> MajorPlayers() {
        return [SELECT Name, Account.Rating FROM Contact WHERE Account.Rating = 'Hot'];
    }
    
    // return Account Name with the most associated Contacts
    public static List<AggregateResult> MostPopularAccount() {
        List<AggregateResult> popularAccount = [SELECT Account.Name, 
                                                COUNT(Id) FROM Contact
                                                GROUP BY Account.Name
                                                ORDER BY COUNT(Id) DESC
                                                LIMIT 1];
        return popularAccount;
    }
    
    // return top 5 Lead Sources most likely to close - ignore case with blank Lead Source
    // how likely? need Einstein rating so ima skip
    public static List<AggregateResult> TopLeadSourcesClosedWon() {
        List<AggregateResult> topFive = [
            SELECT LeadSource, COUNT(Id)
            FROM Opportunity
            WHERE StageName = 'Closed Won' AND LeadSource != NULL
            GROUP BY LeadSource
            ORDER BY COUNT(Id) DESC
            LIMIT 5
        ];
        return topFive;
    }
    
    
    // SOSL
    // Return all Contacts and Leads named Tom
    public static List<List<SObject>> searchName() {
        List<List<SObject>> result = [FIND 'Tom'
            IN NAME FIELDS
            RETURNING Contact(Name), Lead(Name)];
        return result;
    }
    
    
    //return Accounts with 'a' and 'o' in one of their fields
    public static List<List<SObject>> searchAccount() {
        List<List<SObject>> result = [FIND 'a* AND o*'
            RETURNING Account(Name), Contact(Name)];
        return result;
    }
    
    // return an Account or Contact or Lead Name that has a phone number ends in 1000 in any field
    public static List<List<SObject>> searchPhone() {
        List<List<SObject>> result = [FIND '*1000'
            IN PHONE FIELDS
            RETURNING Account(Name), Contact(Name), Lead(Name)];
        return result;
    }
    
    //DML
    // create and insert 200 uniquely named Contacts into the database
    public static void SpawnContacts() {
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i <= 200; i++) {
            Contact con = new Contact(LastName = 'LastName ' + i);
            contacts.add(con);
        }
        insert contacts;
    }
    
    // create and insert 3 uniquely Accounts into the database
    public static void CreateHomes() {
        List<Account> homes = new List<Account>();
        for (Integer i = 0; i < 3; i++) {
            Account home = new Account(Name = 'Name ' + i);
        }
        insert homes;
    }
    
    // delete 50 most recent Contacts in the database
    public static void Relocate() {
        List<Contact> recentContacts = [SELECT Id FROM Contact ORDER BY CreatedDate LIMIT 50];
        delete recentContacts;
    }
    
    //Relates all Contacts (from SpawnContacts) to the 3 Accounts (from CreateHomes) randomly
    public static void AssignHomes() {
        List<Account> newHomes = [SELECT Id FROM Account ORDER BY CreatedDate LIMIT 3];
        List<Contact> newContacts = [SELECT Id FROM Contact ORDER BY CreatedDate LIMIT 50];
        if (newHomes.isEmpty() || newContacts.isEmpty()) {
            System.debug('No contact or account found to assign.');
            return;
        }
        
        for (Integer i = 0; i < newContacts.size(); i++) {
            Integer homeIdx = Integer.valueOf(Math.random() * newHomes.size());
            newContacts[i].AccountId = newHomes[homeIdx].Id;
        }
        update newContacts;
    }
    
    // set a savepoint, call the methods from DML challeneges, collect statistics, then roll back to the savepoint
    public static void Play() {
        // Save initial state of database
        Savepoint sp = Database.setSavepoint();
        
        // initial counts of Contact and Account records
        System.debug('Initial Contact Count: ' + [SELECT COUNT() FROM Contact]);
        System.debug('Initial Account Count: ' + [SELECT COUNT() FROM Account]);
        
        // Challenge methods
        SpawnContacts();
        CreateHomes();
        Relocate();
        AssignHomes();
        
        // current counts of Contact and Account records
        System.debug('Current Contact Count: ' + [SELECT COUNT() FROM Contact]);
        System.debug('Current Account Count: ' + [SELECT COUNT() FROM Account]);
        // number of related contacts for each account
        List<Account> accounts = [SELECT Id, (SELECT Id FROM Contacts) FROM Account ORDER BY CreatedDate LIMIT 3];
        for (Account acc : accounts) {
            System.debug('Related contacts: ' + acc.Contacts.size());
        }
        
        // Rollback to initial state
        Database.rollback(sp);
    }
}