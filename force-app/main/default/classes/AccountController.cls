public with sharing class AccountController {  //Accouunt controller
  
    @AuraEnabled( cacheable = true )  
    public static List< Account > fetchAccounts( String searchKey ) {  
      
        String strKey = '%' + searchKey + '%';  
        return [ SELECT Id, Name, Industry FROM Account WHERE Name LIKE: strKey LIMIT 10 ];  
          
    }
    @AuraEnabled(cacheable = true)
    public static List<Account> getAccountNames(){
        return [select name from Account limit 10];

    }  
      
}