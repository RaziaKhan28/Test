public with sharing class MultipleContactRoleHandler {
    
    @AuraEnabled
    public static List < sObject > fetchLookUpValues(String searchKeyWord, String ObjectName) {
        system.debug('ObjectName-->' + ObjectName);
        String searchKey = searchKeyWord + '%';
        List < sObject > returnList = new List < sObject > ();
      
        // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5   
        String sQuery =  'select id, Name from ' + ObjectName + ' where Name LIKE: searchKey order by createdDate DESC limit 5';
        List <sObject> lstOfRecords = Database.query(sQuery);
        
        for (sObject obj: lstOfRecords) {
            returnList.add(obj);
        }
        system.debug('returnList: '+ returnList);
        return returnList;
    }
    
    @AuraEnabled 
    public static void saveOpportunityContactRole(String recordId, String cr1,String cr2,String cr3,String cr4){
      System.debug('inside saveOpportunityContactRole >>cr1 is '+ cr1 +'cr2>>'+ cr2+ 'cr3>>'+cr3 +'cr4>>' + cr4);
       recordId = recordId.replace('\\"', '\'');
       System.debug('record id is ' + '\''+recordId + '\'');
    
       String query = 'select id,name from opportunity where id =' + '\''+recordId + '\'';
       System.debug('Query is' + query);
        
       Opportunity opp = Database.query(query);
       System.debug('opp is ' + opp); 
       List<String> listOfContactRole = new List<String>();
       listOfContactRole.add(cr1);
       listOfContactRole.add(cr2);
       listOfContactRole.add(cr3);
       listOfContactRole.add(cr4);
       system.debug('listOfContactRole is ' + listOfContactRole) ;
            
       List<OpportunityContactRole> newContactRoleList = new List<OpportunityContactRole>();
	   //Creating new Contact Role
       for(String selectedObj: listOfContactRole){
         if(selectedObj != null){
             String selectedContact = selectedObj;
             String [] contactArr = selectedContact.split('\\=');
             selectedContact = contactArr[0];
             String selectedTeamRole = contactArr[1];
             System.debug('selectedContact is >>' + selectedContact + '>>selectedTeamRole is >>' + selectedTeamRole);
             if((selectedContact!=null && selectedContact.trim().length()!=0 ) 
                && (selectedTeamRole!=null && selectedTeamRole.trim().length()!=0) 
                && !selectedTeamRole.equals('undefined')){
               System.debug('inside insert' + selectedContact.trim().length());
               newContactRoleList.add(
               new OpportunityContactRole(ContactId=selectedContact,
                                              OpportunityId=opp.Id,
                                              Role=selectedTeamRole,
                                              IsPrimary=true));
            }
          } 
       }
       insert newContactRoleList;
     }
    
    @AuraEnabled
    public static List < String > getselectOptions(sObject objInfo, string fieldName) {
      system.debug('objInfo --->' + objInfo);
      system.debug('fieldName --->' + fieldName);
      List < String > allOpts = new list < String > ();
      // Get the object type of the SObject.
      Schema.sObjectType objType = objInfo.getSObjectType();
     
      // Describe the SObject using its object type.
      Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
     
      // Get a map of fields for the SObject
      map < String, Schema.SObjectField > fieldMap = objDescribe.fields.getMap();
     
      // Get the list of picklist values for this field.
      list < Schema.PicklistEntry > values =
       fieldMap.get(fieldName).getDescribe().getPickListValues();
     
      // Add these values to the selectoption list.
      for (Schema.PicklistEntry a: values) {
       allOpts.add(a.getValue());
      }
        
      system.debug('allOpts ---->' + allOpts);
      allOpts.sort();
      return allOpts;
    }
   
}