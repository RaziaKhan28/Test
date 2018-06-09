public class Oppclone {

 
    private ApexPages.StandardController controller {get; set;}
    private Opportunity OpportunityRecordQueried{get;set;}
    public Opportunity OpportunityRecord {get;set;}
 
    public Oppclone(ApexPages.StandardController controller) {
 
        this.controller = controller;
        OpportunityRecord = (Opportunity)controller.getRecord();
        OpportunityRecordQueried = [select Id,
                                Accountid,
                                Amount,
                                CloseDate,
                                Contractid,
                                Description,
                                ExpectedRevenue,
                                ForecastCategoryName,
                                LeadSource,
                                NextStep,
                                
                                Name,
                                Ownerid,
                               
                                Pricebook2id,
                                Campaignid,
                                IsPrivate,
                                Probability,
                                TotalOpportunityQuantity,
                                StageName,
                               
                                Type
                         from Opportunity
                         where id =: OpportunityRecord.Id];
    }
 
    public PageReference cloneOpportunity() {
 
         Savepoint sp = Database.setSavepoint();
         Opportunity OpportunityCloned;
         try {
             OpportunityCloned = OpportunityRecordQueried.clone(false);
             insert OpportunityCloned;
         } catch (Exception e){
            Database.rollback(sp);
            ApexPages.addMessages(e);
            return null;
         }
        return new PageReference('/'+OpportunityCloned.id);
 
    }
 

}