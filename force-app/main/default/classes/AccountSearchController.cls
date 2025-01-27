public class AccountSearchController {
    public String searchKey { get; set; }
    public transient Account account { get; set; }
    public transient Boolean hasResults { get; private set; }
    public transient Boolean hasNoResults { get; private set; }
    public transient Component.Apex.PageBlock dynamicAccountComponent { get; private set; }
    
    public AccountSearchController() {
        searchKey = '';
        hasResults = false;
        hasNoResults = false;
        dynamicAccountComponent = null;
    }
    
    public void searchAccount() {
        // query for Account and its related Contacts
        List<Account> accounts = [
            SELECT Name, Industry, Phone, (SELECT Name FROM Contacts)
            FROM Account
            WHERE Name = :searchKey
            LIMIT 1
        ];
        
        if (!accounts.isEmpty()) {
            account = accounts[0];
            hasResults = true;
            hasNoResults = false;
            
            // dynamic PageBlock to display results
            dynamicAccountComponent = new Component.Apex.PageBlock();
            dynamicAccountComponent.title = 'Account Details';
            
            // Acc details
            dynamicAccountComponent.childComponents.add(createOutputField(account.Name, 'Account Name'));
            dynamicAccountComponent.childComponents.add(createOutputField(account.Industry, 'Industry'));
            dynamicAccountComponent.childComponents.add(createOutputField(account.Phone, 'Phone'));
            
            // if there're related Contacts, add them
            if (account.Contacts != null && !account.Contacts.isEmpty()) {
                Component.Apex.PageBlockSection contactsSection = new Component.Apex.PageBlockSection();
                contactsSection.title = 'Related Contacts';
                
                for (Contact contact : account.Contacts) {
                    Component.Apex.OutputText contactNameField = new Component.Apex.OutputText();
                    contactNameField.value = contact.Name;
                    contactsSection.childComponents.add(contactNameField);
                }
                dynamicAccountComponent.childComponents.add(contactsSection);
            }
        } else {
            account = null;
            hasResults = false;
            hasNoResults = true;
            dynamicAccountComponent = null;
        }
    }
    
    // Helper: create output fields
    private Component.Apex.OutputField createOutputField(Object value, String label) {
        Component.Apex.OutputField field = new Component.Apex.OutputField();
        field.value = value;
        field.label = label;
        return field;
    }
}