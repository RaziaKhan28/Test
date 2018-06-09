({
    //Save the contact as a Opportunity contact role.
    handleSaveContact: function(component,event){
         var contactIdList1 = component.get("v.selectedRecordIdList1");
         var contactIdList2 = component.get("v.selectedRecordIdList2");
         var contactIdList3 = component.get("v.selectedRecordIdList3");
         var contactIdList4 = component.get("v.selectedRecordIdList4");
        
         console.log("contactIdList1 is" + contactIdList1); 
         console.log("contactIdList2 is" + contactIdList2);
         console.log("contactIdList3 is" + contactIdList3);
         console.log("contactIdList4 is" + contactIdList4);
           
        var oppRecordId = component.get("v.recordId");
        console.log('contactId1 is '+ contactIdList1);
        console.log('contactId2 is '+ contactIdList2);
        console.log('contactId3 is '+ contactIdList3);
        console.log('contactId4 is '+ contactIdList4);
        //Calling the apex method to save Opportunity contact role
        var saveContactAction = component.get("c.saveOpportunityContactRole");
     
        //set the param
        saveContactAction.setParams({
            "cr1": contactIdList1,
            "cr2": contactIdList2,
            "cr3": contactIdList3,
            "cr4": contactIdList4,
            "recordId": oppRecordId
          });
     
       saveContactAction.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                // Prepare a toast UI message
                var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "title": "Success!!",
                    "message": "Opportunity contact roles has been successfully created."
                });
                    
                // Update the UI: close panel, show toast, refresh the page
                $A.get("e.force:closeQuickAction").fire();
                resultsToast.fire();
                $A.get("e.force:refreshView").fire();
            } else if (state === "ERROR") {
                console.log('Problem saving contact role, response state: ' + state);
            }
            else {
                console.log('Unknown problem, response state: ' + state);
            }
        });
        
        // Send the request to create the new contact as contact role in opportunity
        $A.enqueueAction(saveContactAction);
    },
    
    //Cancel the quick action
    handleCancel: function(component, event, helper) {
        //var cmpTarget = component.find('Modalbox');
        //var cmpBack = component.find('Modalbackdrop');
       // $A.util.removeClass(cmpBack,'slds-backdrop--open');
        //$A.util.removeClass(cmpTarget, 'slds-fade-in-open'); 
      $A.get("e.force:closeQuickAction").fire();
    },
})