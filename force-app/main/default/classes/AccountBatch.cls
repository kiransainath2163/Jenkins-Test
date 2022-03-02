public class AccountBatch implements Database.batchable<sObject>{
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('select Id, IsUpdatedByBatchClass__c from Account');
    }

    public void execute(Database.BatchableContext BC, List<Account> accountList){
        for(Account ac : accountList){
            ac.IsUpdatedByBatchClass__c = true;
        }
        update accountList;
    }

    public void finish(Database.BatchableContext BC){
        AccountBatch acBatch = new AccountBatch();
        Database.executeBatch(acBatch, 5);
        System.debug('Batch of Account finished');
    }
}
