public class LeadBatch implements Database.Batchable<SObject>{
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'Select Id, LeadSource from Lead';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC, List<Lead> Scope){
        for(Lead l : Scope){
            l.LeadSource = 'Web';
        }
        update Scope;
    }

    public void finish(Database.BatchableContext BC){
        System.debug('Batch Class Finished');
    }
}
