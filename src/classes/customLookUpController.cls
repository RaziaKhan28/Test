public class customLookUpController {
    @AuraEnabled
    public static List < sObject > fetchLookUpValues(String searchKeyWord, String ObjectName) {
        system.debug('ObjectName-->' + ObjectName);
        String searchKey = searchKeyWord + '%';
        
        List < sObject > returnList = new List < sObject > ();
      
        // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5   
        String sQuery =  'select id, Name from ' +ObjectName + ' where Name LIKE: searchKey order by createdDate DESC limit 5';
        system.debug('Query is : '+ sQuery);
        List < sObject > lstOfRecords = Database.query(sQuery);
        
        for (sObject obj: lstOfRecords) {
            returnList.add(obj);
        }
        System.debug('Result list is :' + returnList);
        return returnList;
    }
    
    @AuraEnabled 
    public static String saveOpportunityContactRole(String recordId, String selectedObjectId){
      
       recordId = recordId.replace('\\"', '\'');
       System.debug('record id is ' + '\''+recordId + '\'');
       // String recId= '\''+String.escapeSingleQuotes(recordId)+'\'';
        String query1 = 'select id,name from opportunity where id =' + '\''+recordId + '\'';
     	 System.debug('Query is' + query1);
        opportunity opp = Database.query(query1);
        System.debug('recIdd is ' + recordId);
		System.debug('opp is ' + opp); 
        
        List<OpportunityContactRole> newContactRoleList = new List<OpportunityContactRole>();
		
       
        
              //Creating new Contact Role
         newContactRoleList.add(new OpportunityContactRole(ContactId=selectedObjectId,OpportunityId=opp.Id,Role='Decision Maker',IsPrimary=true));
          
        insert newContactRoleList;
        return newContactRoleList.get(0).id;
     
    }
}