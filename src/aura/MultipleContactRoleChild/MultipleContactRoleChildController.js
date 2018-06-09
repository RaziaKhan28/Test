({
     doInit: function(component, event, helper) {
      // var cmpTarget = component.find('Modalbox');
      //  var cmpBack = component.find('Modalbackdrop');
      //  $A.util.addClass(cmpTarget, 'slds-fade-in-open');
       //$A.util.addClass(cmpBack, 'slds-backdrop--open'); 
      
      helper.fetchPickListVal(component, 'Role', 'teamRole');
    },
    
    onSelectChange : function(component, event, helper) {
       var selectedTeamRole = component.find("teamRole").get("v.value");
       component.set("v.selectedTeamRole", selectedTeamRole);
       console.log('inside onSelectChange selectedTeamRole >>> ' + selectedTeamRole);
        
       var selectedRecordId = component.get("v.selectedRecordId");
       console.log("inside onSelectChange selectedRecordIdvalue is: " + selectedRecordId);
        
        var isDefinedRecord = !$A.util.isUndefined(component.get("v.selectedRecordId"));
		console.log("isDefinedRecord " + isDefinedRecord);
        if(!isDefinedRecord){
         selectedRecordId = '';  
        }
        
       var isDefinedTeamRole = !$A.util.isUndefined(component.get("v.selectedTeamRole"));
		console.log("isDefinedTeamRole " + isDefinedTeamRole);
        if(!isDefinedTeamRole){
         selectedTeamRole = '';  
        }
       selectedRecordId = selectedRecordId + "=" + selectedTeamRole;
       console.log("inside onSelectChange selectedRecordId" + selectedRecordId) ;
       component.set("v.selectedRecordIdList", ''); 
       component.set("v.selectedRecordIdList", selectedRecordId ); 
   },
	   onfocus : function(component, event, helper){
       $A.util.addClass(component.find("mySpinner"), "slds-show");
       var forOpen = component.find("searchRes");
       $A.util.addClass(forOpen, 'slds-is-open');
       $A.util.removeClass(forOpen, 'slds-is-close');
       
       // Get Default 5 Records order by createdDate DESC  
       var getInputkeyWord = '';
       helper.searchHelper(component, event, getInputkeyWord);
    },
    
    onblur : function(component, event, helper){       
        component.set("v.listOfSearchRecords", null );
        var forclose = component.find("searchRes");
        $A.util.addClass(forclose, 'slds-is-close');
        $A.util.removeClass(forclose, 'slds-is-open');
    },
    
    keyPressController : function(component, event, helper) {
        //get the search Input keyword   
        var getInputkeyWord = component.get("v.SearchKeyWord");
        console.log("getInputkeyWord from keyPressController is:  " + getInputkeyWord);
        //check if getInputKeyWord size id more then 0 then open the lookup result List and 
        //call the helper 
        //else close the lookup result List part.   
        if( getInputkeyWord.length > 0 ){
            var forOpen = component.find("searchRes");
            $A.util.addClass(forOpen, 'slds-is-open');
            $A.util.removeClass(forOpen, 'slds-is-close');
            helper.searchHelper(component, event, getInputkeyWord);
        }
        else{  
             component.set("v.listOfSearchRecords", null ); 
             var forclose = component.find("searchRes");
             $A.util.addClass(forclose, 'slds-is-close');
             $A.util.removeClass(forclose, 'slds-is-open');
          }
	},
    
    //function for clear the record selection 
    clear: function(component, event, helper){
        	
         var selectedRecordId = component.get("v.selectedRecordId");
         console.log("inside clear selectedRecordIdvalue is: " + selectedRecordId);
         component.set("v.selectedRecordId", null ); 
        
         var team = component.get("v.selectedTeamRole");
         console.log('inside clear teamrole is' + team);
        
         var list = component.get("v.selectedRecordIdList");
         console.log('inside clear list is' + list);
        
         component.set("v.selectedRecordIdList", ''); 
                 
         team = '' + "=" + team;
         component.set("v.selectedRecordIdList", team ); 
         console.log('inside clear new list is' + component.get("v.selectedRecordIdList"));
                
         var pillTarget = component.find("lookup-pill");
         var lookUpTarget = component.find("lookupField"); 
        
         $A.util.addClass(pillTarget, 'slds-hide');
         $A.util.removeClass(pillTarget, 'slds-show');
        
         $A.util.addClass(lookUpTarget, 'slds-show');
         $A.util.removeClass(lookUpTarget, 'slds-hide');
      
         component.set("v.SearchKeyWord", null);
         component.set("v.listOfSearchRecords", null );
         component.set("v.selectedRecord", {} );
        
    },
    
    //This function call when the end user select any record from the result list.   
    handleComponentEvent : function(component, event, helper) {
      console.log("inside handleComponentEvent");
      // get the selected Contact record from the COMPONENT event 	 
      var selectedContactGetFromEvent = event.getParam("recordByEvent");
             
	  var selectedContactId = event.getParam("recordByEventId");
      var selectedRecordList = component.get("v.selectedRecordIdList");
      var recordList = component.get("v.tempRecordList");
          
	  component.set("v.selectedRecord" , selectedContactGetFromEvent); 
      component.set("v.selectedRecordId" , selectedContactId); 
      console.log('selectedRecordId is' +  component.get("v.selectedRecordId"));
      
      var teamRole = component.get("v.selectedTeamRole");
      console.log("selected teamRole is :" + teamRole);
      
       if(teamRole==='undefined'){
           teamRole ='' ;
        }
      component.set("v.selectedRecordIdList", '');
        
      selectedContactId = selectedContactId + "=" + teamRole;
      console.log("concatenated " + selectedContactId);
      //Adding the selected contact in the list
      component.set("v.selectedRecordIdList", selectedContactId); 
    
      var forclose = component.find("lookup-pill");
           $A.util.addClass(forclose, 'slds-show');
           $A.util.removeClass(forclose, 'slds-hide');
  
      var forclose = component.find("searchRes");
           $A.util.addClass(forclose, 'slds-is-close');
           $A.util.removeClass(forclose, 'slds-is-open');
        
      var lookUpTarget = component.find("lookupField");
            $A.util.addClass(lookUpTarget, 'slds-hide');
            $A.util.removeClass(lookUpTarget, 'slds-show');  
      
	},
})