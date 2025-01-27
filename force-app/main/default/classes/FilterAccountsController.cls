public class FilterAccountsController {
    public String filterName { get; set; }
    public List<AllAccountsWithContactsController.AccountWrapper> filteredAccounts { get; private set; }
    
    public FilterAccountsController() {
        loadAllAccounts();
    }
    
    private void loadAllAccounts() {
        filteredAccounts = new List<AllAccountsWithContactsController.AccountWrapper>();
        List<Account> accList = [
            SELECT Id, Name,
                (SELECT Name FROM Contacts)
            FROM Account
        ];
        
        for (Account acc : accList) {
            List<Contact> relatedContacts = acc.Contacts;
            filteredAccounts.add(new AllAccountsWithContactsController.AccountWrapper(acc, relatedContacts));
        }
    }
    
    public void filterAccounts() {
        filteredAccounts = new List<AllAccountsWithContactsController.AccountWrapper>();
        
        List<Account> accList = [
            SELECT Id, Name,
                (SELECT Name FROM Contacts)
            FROM Account
            WHERE Name LIKE :('%' + filterName + '%')
        ];
        
        for (Account acc : accList) {
            List<Contact> relatedContacts = acc.Contacts;
            filteredAccounts.add(new AllAccountsWithContactsController.AccountWrapper(acc, relatedContacts));
        }
    }
}