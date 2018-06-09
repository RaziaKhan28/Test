({
	selectChange : function(component, event, helper) {
        // first get the div element. by using aura:id
      var changeElement = component.find("DivID");
        // by using $A.util.toggleClass add-remove slds-hide class
      $A.util.toggleClass(changeElement, "slds-hide");
	  },
})