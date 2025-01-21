public class AccountSearchController {
    public String searchKey { get; set; }
    public Account account { get; set; }
    public Boolean hasResults { get; set; }
    public Boolean hasNoResults { get; set; }
    
    public AccountSearchController() {
        searchKey = '';
        hasResults = false;
        hasNoResults = false;
    }
    
    public void searchAccount() {
        List<Account> accounts = [SELECT Name, Industry, Phone FROM Account WHERE Name = :searchKey LIMIT 1];
        
        if (!accounts.isEmpty()) {
            account = accounts[0];
            hasResults = true;
            hasNoResults = false;
        } else {
            account = null;
            hasResults = false;
            hasNoResults = true;
        }
    }
}