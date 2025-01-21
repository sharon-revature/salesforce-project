public class AccountSearchWithContactsExtension {
    public List<Contact> contacts { get; set; }
    private AccountSearchController accountSearchController;
    
    public AccountSearchWithContactsExtension(AccountSearchController controller) {
        accountSearchController = controller;
        contacts = new List<Contact>();
    }
    
    public void loadRelatedContacts() {
        if (accountSearchController.account != null) {
            // Fetch related contacts
            contacts = [SELECT Name FROM Contact WHERE AccountId = :accountSearchController.account.Id];
        } else {
            contacts.clear();
        }
    }
}