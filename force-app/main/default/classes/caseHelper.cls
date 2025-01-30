public with sharing class caseHelper {
    public caseHelper() {
        
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Case> getHighPriorityCases() {
        return [
                SELECT AccountId, ContactId, Subject
                FROM Case
                WHERE IsEscalated = true AND Priority = 'High'
            ];
    }
    
    @AuraEnabled
    public static void createCase(String origin, String status){
        Case c = new Case(Origin = origin, Status = status, IsEscalated = true, Priority = 'High');
        insert c;
    }
    
}