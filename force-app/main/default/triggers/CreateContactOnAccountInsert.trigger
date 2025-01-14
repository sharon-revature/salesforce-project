trigger CreateContactOnAccountInsert on Account (after insert) {
    // list for new Contact records that will be created
    List<Contact> contactsToInsert = new List<Contact>();
    
    // iterate through each inserted Account
    for (Account acc : Trigger.new) {
        // create a new Contact for each Account
        Contact newContact = new Contact();
        
        // set default values for Contact fields
        newContact.AccountId = acc.Id;
        newContact.FirstName = 'Default';
        newContact.LastName = acc.Name;
        newContact.Email = 'default' + acc.Name + '@email.com';
        
        // add new Contact to the inserting list
        contactsToInsert.add(newContact);
    }
    
    // insert the new Contact records
    if (!contactsToInsert.isEmpty()) {
        insert contactsToInsert;
    }
}