public with sharing class CalculateNoOfDays {
	
    @AuraEnabled
    public static Integer getDays(String startDate, String endDate){
        Integer noOfDays = Date.valueOf(startDate).daysBetween(Date.valueOf(endDate));
        return noOfDays;
    }
}