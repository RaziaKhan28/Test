<aura:application extends="force:slds">
  <!-- Create attribute to store lookup value as a sObject--> 
  <aura:attribute name="selectedLookUpRecord" type="sObject" default="{}"/>
 
  <c:customLookup1 objectAPIName="contact" IconName="standard:contact" selectedRecord="{!v.selectedLookUpRecord}" label="Contact Name12"/>
 <!-- here c: is org. namespace prefix-->
</aura:application>