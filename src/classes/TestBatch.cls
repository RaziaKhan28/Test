public class TestBatch implements Database.Batchable<sObject>{

    String query;
    
    public Database.QueryLocator start(Database.BatchableContext bc){
     query = 'select id, name, industry from account';
     return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Account> scope){
        List<Account> accList = new List<Account>();
        for(Account a: scope) {
           a.Description = 'Updated in batch apex class1'; 
           accList.add(a);
        }
         update accList;
    }
    
    public void finish(Database.BatchableContext bc){
  
    }
}