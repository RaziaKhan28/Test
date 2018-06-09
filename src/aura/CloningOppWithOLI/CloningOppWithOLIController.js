({
   handleClone : function(component, event, helper) {
        //Calling the controller method to clone  
        var action = component.get("c.cloneOppWithOLI");
        //Setting the parameters in the controller method
        action.setParams({
                "oldId" : component.get("v.recordId")
         });
          
         action.setCallback(this, function(response) {
             var state = response.getState(); 
             var responseValue = response.getReturnValue();
             if(component.isValid() && state === "SUCCESS") {
                console.log("Cloned Opportunity Id is " + responseValue);
             } else {
                console.log('Problem in response state: ' + JSON.stringify(response.error)); 
             } 
    
            // Close the action panel 
            var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
            dismissActionPanel.fire();
            
             var navEvt = $A.get("e.force:navigateToSObject");
             navEvt.setParams({
                            "recordId": responseValue,
                            });
             navEvt.fire(); 
             
             // Display toast message to indicate load status 
            var toastEvent = $A.get("e.force:showToast"); 
            if (state === 'SUCCESS'){
                toastEvent.setParams({ 
                    "title": "Success!",
                    "message": " Opportunity has been successfully cloned!!." 
                }); 
            } else {
                toastEvent.setParams({ 
                    "title": "Error!", 
                    "message": " Something has gone wrong." 
                }); 
            } 
             toastEvent.fire();
    
         }); 
            
         $A.enqueueAction(action);
    
        },
})