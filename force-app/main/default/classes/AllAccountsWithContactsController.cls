public class AllAccountsWithContactsController {
    public List<Account> accounts { get; set; }
    
    public AllAccountsWithContactsController() {
        accounts = [SELECT Name, Industry, Phone, 
                           (SELECT Name FROM Contacts) 
                    FROM Account];
    }
    
    public String getContactsAsString(Account account) {
        List<String> contactNames = new List<String>();
        
        if (account.Contacts != null) {
            for (Contact c : account.Contacts) {
                contactNames.add(c.Name);
            }
        }
        
        return String.join(contactNames, ', ');
    }
}