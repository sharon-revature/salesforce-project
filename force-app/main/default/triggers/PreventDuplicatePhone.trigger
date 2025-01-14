trigger PreventDuplicatePhone on Contact (before insert, before update) {
    // set to hold unique phone numbers being inserted or updated
    Set<String> phoneNumbers = new Set<String>();
    
    // list for Contacts with duplicate phone numbers
    List<Contact> duplicateContacts = new List<Contact>();
    
    // iterate over contacts in Trigger.new (both insert and update)
    for (Contact con : Trigger.new) {
        if (con.Phone != null) {
            phoneNumbers.add(con.Phone);
        }
    }
    
    // query database to check for existing contacts with the same phone numbers
    List<Contact> existingContacts = [SELECT Id, Phone FROM Contact WHERE Phone IN :phoneNumbers];
    
    // iterate through the existing contacts to check for duplicates
    for (Contact existing : existingContacts) {
        // check if phone number is being used by a different Contact (not the same Contact being updated)
        for (Contact con : Trigger.new) {
            if (con.Phone != null && con.Phone == existing.Phone && con.Id != existing.Id) {
                duplicateContacts.add(con);
            }
        }
    }
    
    // if duplicates are found, add an error to the contact's Phone field
    for (Contact duplicate : duplicateContacts) {
        duplicate.Phone.addError('This phone number already exists for another contact.');
    }
}