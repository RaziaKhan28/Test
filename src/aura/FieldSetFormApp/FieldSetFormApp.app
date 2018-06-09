<aura:application extends="force:slds">
    <aura:attribute name="opportunity" type="opportunity" default="{Name: 'opp'}"/>
    <ul>
        <li>Name: {!v.opportunity.Name}</li>
      
    </ul>

    <c:FieldSetForm fsName="TestSet" 
        typeName="opportunity" 
        record="{!v.opportunity}"
    />
    <button onclick="{!c.handleSave}">save</button>
</aura:application>