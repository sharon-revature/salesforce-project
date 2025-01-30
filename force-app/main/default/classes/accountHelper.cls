public with sharing class accountHelper {
    @AuraEnabled(cacheable=true)
    public static List<Account> getHotAccounts() {
        return [
            SELECT Id, Name, Industry, AnnualRevenue 
            FROM Account 
            WHERE AnnualRevenue > 1000000 // custom threshold for hot accounts
            ORDER BY AnnualRevenue DESC
        ];
    }
    
    @AuraEnabled
    public static Account createAccount(String name, String rating, String industry, Decimal revenue) {
        Account acc = new Account(
            Name = name,
        Rating = rating,
        Industry = industry,
        AnnualRevenue = revenue
            );
        insert acc;
        return acc;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name, AnnualRevenue FROM Account];
    }
    
    @AuraEnabled
    public static void deleteAccount(String id) {
        try {
            delete [SELECT Id FROM Account WHERE Id = :id];
        } catch (Exception e) {
            throw new AuraHandledException('Error deleting record: ' + e.getMessage());
        }
    }
}