({
	searchHelper : function(component,event,getInputkeyWord) {
	 //call the apex class method 
     var action = component.get("c.fetchLookUpValues");
     //set param to method  
     action.setParams({
            'searchKeyWord': getInputkeyWord,
            'ObjectName' : component.get("v.objectAPIName")
     });
     //set a callBack    
     action.setCallback(this, function(response) {
        $A.util.removeClass(component.find("mySpinner"), "slds-show");
        var state = response.getState();
        if (state === "SUCCESS") {
            console.log("inside searchHelper");
            var storeResponse = response.getReturnValue();
            console.log("inside searchHelper storeResponse is: " + storeResponse);
              //if storeResponse size is equal 0 ,display No Result Found... message on screen.                }
             if (storeResponse.length == 0) {
                 component.set("v.Message", 'No Result Found...');
              } else {
                 component.set("v.Message", '');
              }
              // set searchResult list with return value from server.
              component.set("v.listOfSearchRecords", storeResponse);
        }else{
             console.log("Something wentwrong inside searchHelper"); 
        }
       });
     
       //enqueue the Action  
       $A.enqueueAction(action);
  	},
    
    fetchPickListVal: function(component, fieldName, teamRole) {
        console.log("inside fetchPickListVal");
        var action = component.get("c.getselectOptions");
        action.setParams({
            "objInfo": component.get("v.objInfo"),
            "fieldName": fieldName
        });
        var opts = [];
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
 
                if (allValues != undefined && allValues.length > 0) {
                    opts.push({
                        class: "optionClass",
                        label: "--- None ---",
                        value: ""
                    });
                }
                for (var i = 0; i < allValues.length; i++) {
                    opts.push({
                        class: "optionClass",
                        label: allValues[i],
                        value: allValues[i]
                    });
                }
                component.find(teamRole).set("v.options", opts);
               
            }
        });
        $A.enqueueAction(action);
    },
})