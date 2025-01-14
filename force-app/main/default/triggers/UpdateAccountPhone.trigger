trigger UpdateAccountPhone on Contact (after update) {
    // list to store Accounts that need to be updated
    List<Account> accountsToUpdate = new List<Account>();
    
    // iterate through each updated Contact
    for (Contact con : Trigger.new) {
        // check if Phone field was changed
        if (con.Phone != Trigger.oldMap.get(con.Id).Phone) {
            // retrieve related Account for the Contact
            Account relatedAccount = [SELECT Id, Phone FROM Account WHERE Id = :con.AccountId LIMIT 1];
            
            // update Phone field of the related Account to match the Contact's Phone
            relatedAccount.Phone = con.Phone;
            
            // add Account to the list of accounts to be updated
            accountsToUpdate.add(relatedAccount);
        }
    }
    
    // update the Accounts with new Phone value
    if (!accountsToUpdate.isEmpty()) {
        update accountsToUpdate;
    }
}