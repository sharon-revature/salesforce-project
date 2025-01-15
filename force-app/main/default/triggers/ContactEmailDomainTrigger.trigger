trigger ContactEmailDomainTrigger on Contact (before insert, before update) {
    // map for Account IDs (key) and associated email domains (value)
    Map<Id, Set<String>> accountEmailDomains = new Map<Id, Set<String>>();
    
    // iterate through contacts to gather email domains by Account
    for (Contact c : Trigger.new) {
        // skip empty email fields
        if (String.isNotBlank(c.Email)) {
            // domain name should be after '@' in email
            String emailDomain = c.Email.substring(c.Email.indexOf('@') + 1);
            // if map doesn't have this accountid yet aka this account hasn't been encountered
            // add the accountid to the map
            if (!accountEmailDomains.containsKey(c.AccountId)) {
                accountEmailDomains.put(c.AccountId, new Set<String>());
            }
            // add associated emailsomain of that accountid to the map
            accountEmailDomains.get(c.AccountId).add(emailDomain);
        }
    }
    
    // check if email domain matches for all Contacts under the same Account
    for (Contact c : Trigger.new) {
        if (c.AccountId != null && String.isNotBlank(c.Email)) {
            String currentEmailDomain = c.Email.substring(c.Email.indexOf('@') + 1);
            Set<String> accountDomains = accountEmailDomains.get(c.AccountId);
            // if the domain doesn't match the others, prevent save
            if (accountDomains.size() > 1 && !accountDomains.contains(currentEmailDomain)) {
                c.addError('The email domain must match the domain of other contacts within the same Account.');
            }
        }
    }
}