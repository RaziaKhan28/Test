global class UpdateAccountBatch implements Database.Batchable<sObject>{
    String query;
     
    global Database.querylocator start(Database.BatchableContext BC){
        Query = 'Select id,name,Description from account';   
        return Database.getQueryLocator(query);
    }
 
    global void execute(Database.BatchableContext BC, List<account> scope){
       List<Account> accList = new List<Account>();
 
       for(account s : scope){
           s.Description = 'Updated in batch apex class'; 
           accList.add(s); 
       }
 
       update accList;
    }
     
    global void finish(Database.BatchableContext BC){
           // Get the ID of the AsyncApexJob representing this batch job
   // from Database.BatchableContext.
   // Query the AsyncApexJob object to retrieve the current job's information.
   AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
      TotalJobItems, CreatedBy.Email,ApexClassId,ParentJobId,MethodName
      FROM AsyncApexJob WHERE Id =
      :BC.getJobId()];
   // Send an email to the Apex job's submitter notifying of job completion.
   Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
   String[] toAddresses = new String[] {'razia.k@tcs.com'};
   mail.setToAddresses(toAddresses);
   mail.setSubject('Apex Sharing Recalculation ' + a.Status);
   mail.setPlainTextBody
   ('The batch Apex job processed ' + a.TotalJobItems +
   ' batches with '+ a.NumberOfErrors + ' failures.'+ a.ApexClassId + ' '+ a.ParentJobId + '' + a.MethodName);
   Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });    
    
    }
}