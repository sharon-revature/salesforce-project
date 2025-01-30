public with sharing class contactHelper {
    public contactHelper() {
        
    }
    @AuraEnabled(cacheable=true)
    public static Contact getContactInfo(Id contactId) {
        return [SELECT Id, FirstName, LastName, Email, Phone FROM Contact WHERE Id = :contactId LIMIT 1];
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> searchContacts(String searchTerm) {
        if (String.isBlank(searchTerm)) {
            return new List<Contact>();
        }
        
        // Search for contacts where the name, email, or title contains the search term
        String query = '%' + searchTerm + '%';
        List<Contact> contacts = [SELECT Id, FirstName, LastName, Email, Phone 
                                  FROM Contact 
                                  WHERE (Name LIKE :query OR Email LIKE :query)
                                  LIMIT 10];
        return contacts;
    }
}