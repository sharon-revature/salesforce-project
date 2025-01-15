trigger UpdateAccountPhone on Contact (after update) {
    // map for Account IDs and updated Phone values
    Map<Id, String> accountPhoneUpdates = new Map<Id, String>();
    
    // iterate through each updated Contact
    for (Contact con : Trigger.new) {
        // check if Phone field was changed
        if (con.Phone != Trigger.oldMap.get(con.Id).Phone && con.AccountId != null) {
            // add AccountId and new Phone value to the map
            accountPhoneUpdates.put(con.AccountId, con.Phone);
        }
    }
    
    // if there are accounts to update
    if (!accountPhoneUpdates.isEmpty()) {
        // query the Accounts to be updated
        List<Account> accountsToUpdate = [SELECT Id, Phone FROM Account WHERE Id IN :accountPhoneUpdates.keySet()];
        
        // update acc's phone
        for (Account acc : accountsToUpdate) {
            acc.Phone = accountPhoneUpdates.get(acc.Id);
        }
        
        update accountsToUpdate;
    }
}