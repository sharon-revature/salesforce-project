trigger PreventAccountDeletion on Account (before delete) {
    // list for accounts with contacts
    Set<Id> accountIdsWithContacts = new Set<Id>();
    
    // query to check if there are any related Contacts to the Accounts being deleted
    for (Account acc : Trigger.old) {
        // if the Account has any related Contacts, add it to the set
        Integer contactCount = [SELECT COUNT() FROM Contact WHERE AccountId = :acc.Id];
        if (contactCount > 0) {
            accountIdsWithContacts.add(acc.Id);
        }
    }
    
    // prevent deletion for accounts that have associated Contacts
    for (Account acc : Trigger.old) {
        if (accountIdsWithContacts.contains(acc.Id)) {
            acc.addError('This Account cannot be deleted because it has associated Contacts.');
        }
    }
}