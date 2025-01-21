public class AccountGreetingMsgController {
    public Account account { get; set; }
    public String greetingMessage { get; set; }
    
    public AccountGreetingMsgController() {
        // Assuming the account Id is passed as a URL parameter
        Id accountId = ApexPages.currentPage().getParameters().get('id');
        account = [SELECT Name, Industry, Phone FROM Account WHERE Id = :accountId LIMIT 1];
        greetingMessage = '';
    }
    
    public void showGreeting() {
        if (account != null) {
            greetingMessage = 'Hello, ' + account.Name + '!';
        }
    }
}