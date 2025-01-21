public class StaticAccountController {
    public Account account { get; set; }
    public StaticAccountController() {
        List<Account> accounts = [SELECT Name, Industry, Phone FROM Account WHERE Name = 'YourAccountName' LIMIT 1];
        if (!accounts.isEmpty()) {
            account = accounts[0];
        } else {
            account = new Account(Name = 'Default Account', Industry = 'N/A', Phone = 'N/A');
        }
    }
}