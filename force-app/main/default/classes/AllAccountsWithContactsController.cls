public class AllAccountsWithContactsController {
    public class AccountWrapper {
        public Account account { get; set; }
        public String ContactNames { get; set; }
        
        public AccountWrapper(Account account, List<Contact> contacts) {
            this.account = account;
            
            if (contacts != null && !contacts.isEmpty()) {
                List<String> contactNamesList = new List<String>();
                for (Contact c : contacts) {
                    contactNamesList.add(c.Name);
                }
                this.ContactNames = String.join(contactNamesList, ', ');
            } else {
                this.ContactNames = '';
            }
        }
    }
    
    public List<AccountWrapper> accounts { get; private set; }
    private List<Account> updatedAccounts;
    
    public AllAccountsWithContactsController() {
        updatedAccounts = new List<Account>();
        loadAccounts();
    }
    
    // load accounts + related contacts
    private void loadAccounts() {
        List<Account> accList = [
            SELECT Id, Name,
                (SELECT Name FROM Contacts)
            FROM Account
        ];
        
        accounts = new List<AccountWrapper>();
        for (Account acc : accList) {
            List<Contact> relatedContacts = acc.Contacts;
            accounts.add(new AccountWrapper(acc, relatedContacts));
        }
    }
    
    // save a single account
    public void saveAccount() {
        for (AccountWrapper wrapper : accounts) {
            updatedAccounts.add(wrapper.account);
        }
        
        if (!updatedAccounts.isEmpty()) {
            update updatedAccounts;
            updatedAccounts.clear();
            loadAccounts();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Account saved successfully.'));
        }
    }
    
    // save all accounts
    public void saveAll() {
        for (AccountWrapper wrapper : accounts) {
            updatedAccounts.add(wrapper.account);
        }
        
        if (!updatedAccounts.isEmpty()) {
            update updatedAccounts;
            updatedAccounts.clear();
            loadAccounts();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'All accounts saved successfully.'));
        }
    }
}