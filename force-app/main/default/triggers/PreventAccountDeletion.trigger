trigger PreventAccountDeletion on Account (before delete) {
    // list for Accounts with their related Contacts using soql
    List<Account> accountsWithContacts = [
        SELECT Id, (SELECT Id FROM Contacts)
        FROM Account
        WHERE Id IN :Trigger.old
    ];
    
    // iterate over the queried accounts
    for (Account acc : accountsWithContacts) {
        // check if the account has related Contacts
        if (acc.Contacts.size() > 0) {
            // error to prevent deletion
            Trigger.oldMap.get(acc.Id).addError('This Account cannot be deleted because it has associated Contacts.');
        }
    }
}