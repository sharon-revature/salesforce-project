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
    
    // return top 5 Lead Sources most likely to close and how likely - ignore case with blank LS
    public static List<AggregateResult> TopLeadSources() {
        List<AggregateResult> topFive = [SELECT LeadSource, COUNT(Name)
                                         FROM Lead
                                         WHERE LeadSource != 'Closed - No Action'
                                         GROUP BY LeadSource
                                         ORDER BY COUNT(LeadSource) DESC
                                         LIMIT 5];
        return topFive;
    }
    
    //SOSL
    // return all Contacts And Leads named Tom
    public static List<List<SObject>> searchName(String name) {
        List<List<SObject>> result = [FIND 'Tom' IN NAME FIELDS
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
    
}