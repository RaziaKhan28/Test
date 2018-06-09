({
	handleSave : function(component, event, helper) {
		var startDate = component.find("startDate").get("v.value");
        var endDate = component.find("endDate").get("v.value");
        var recurWeek = component.find("week").get("v.value");
        var recurWeek1 = (Number(recurWeek)+1)*7;
        var startDate1 = new Date(startDate);
        var endDate1 = new Date(endDate);
        alert("recurWeek1==="+recurWeek1);
        var selectedDays = ["","","","","","",""];
        var checkboxes=component.find("check");
        for(var c in checkboxes){
            if(checkboxes[c].get("v.checked")){
                var dayvalue = checkboxes[c].get("v.value")
                selectedDays.splice(dayvalue,1,dayvalue);  
            }
        }
        alert("startDate == "+startDate1+" endDate == "+endDate1+" recurWeek == "+recurWeek1+" selectedDays == "+selectedDays);
        var startDay = startDate1.getDay();
        var dateArray = [];
        var finaldates = [];
        var action=component.get("c.getDays");
        action.setParams({"startDate":startDate,"endDate":endDate});
        action.setCallback(component,function(response){
            if(response.getState()=="SUCCESS"){
                var noOfDays =response.getReturnValue();
                for(var i=startDay;i<noOfDays;i++){
                    if(startDay == selectedDays[i]){
                        dateArray.push(startDate1);
                    }
                    else if(i%7==selectedDays[i%7] && selectedDays[i%7]!= ""){
                        var date = new Date(startDate1.setDate(startDate1.getDate()));
                        dateArray.push(date);
                    }
                    startDate1.setDate(startDate1.getDate() + 1);
                }
            }
        });
        $A.enqueueAction(action);
	},
    
    hideShowToggle:function(component){
      var changeElement = component.find("DivID");
        // by using $A.util.toggleClass add-remove slds-hide class
      $A.util.toggleClass(changeElement, "slds-hide");

        
    }
})