/**
 * This Class is used as a controller in component: CloningOppWithOLI.
 * It is responsible for cloning the opportunity with products(Opportunity Line Item)
 * @Author: Razia Khan(TCS)
 * Date Created: 1/31/2018
 **/

public with sharing class CloneOppWithOLIController {
	
   @AuraEnabled
    public static String cloneOppWithOLI(ID oldId){
       
       system.debug('oldId ' + oldId);
        
        // Initialize setup variables
        String objectName = 'Opportunity';  // modify as needed
        String query = 'SELECT';
        String OppAccessFields = ''; //To Control FLS
        
        //User u = [SELECT Id FROM User WHERE Id =: UserInfo.getUserId()];
     
       
        Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
        Boolean hasAccessToOpp = Opportunity.sObjectType.getDescribe().isDeletable();
        
        if(!hasAccessToOpp){
           System.debug('Insufficient access to object ' + objectName);
            // Pass error to client
            throw new System.NoAccessException(); 
        }

        // Grab all the fields of SObject to create a dynamic query with all fields(for cloning).
        for(String s : objectFields.keySet()) {
           query += ' ' + s + ', ';
           OppAccessFields += '' +'\'' + s + '\'' + ',';
        }
        
        // Manually add related object's fields that are needed.
        query += 'Account.Name '; 
        
        // Strip off the last comma if it exists.
        if (query.subString(query.Length()-1,query.Length()) == ','){
            query = query.subString(0,query.Length()-1);
        }
        
        if (OppAccessFields.subString(OppAccessFields.Length()-1,OppAccessFields.Length()) == ','){
            OppAccessFields = OppAccessFields.subString(0,OppAccessFields.Length()-1);
        }
		
        
        // Add FROM statement
        query += ' FROM ' + objectName;
        
        // Add on a WHERE/ORDER/LIMIT statement as needed
        query += ' WHERE Id =  \''+ oldId +'\'  LIMIT 1';
        system.debug(query); 
       	system.debug('List of fields which needs to be check for access' + OppAccessFields);
        
        String [] oppAccessFieldsList = new String [] {OppAccessFields};
            
        for (String fieldToCheck : oppAccessFieldsList) {
		Schema.SObjectField field = objectFields.get(fieldToCheck);
        // Check if the user has access to view field
        if (field !=null && !field.getDescribe().isAccessible() ) {
			System.debug('Insufficient access to field' + field);
            // Pass error to client
            throw new System.NoAccessException();
            // Suppress editor logs
            return null;
          }
        }
                     
        Opportunity opp = database.query(query);
        system.debug(opp);
        Opportunity newOpp = opp.clone(false, false, false, false);
        newOpp.Name = opp.Name + '_clone';
        insert newOpp;  
        
        if (opp.HasOpportunityLineItem == true) {
            List<OpportunityLineItem> products = [Select Id, OpportunityId,Quantity,UnitPrice,PricebookEntryId,Product2Id,Name 
                                   from OpportunityLineItem where OpportunityId =: opp.Id];
            
            system.debug('product List = ' +products);
    
            system.debug('newOpp Id = ' + newOpp.Id);
            List<OpportunityLineItem> newProdList = new List<OpportunityLineItem>();
            for (OpportunityLineItem prod: products) {
                OpportunityLineItem newProd = prod.clone(false, false, false, false);
                newProd.OpportunityId = newOpp.id;
                newProdList.add(newProd);
            }
            
            insert(newProdList);
            system.debug('newProdList ' + newProdList);           
        } 
       
        return newOpp.id;
    }
}