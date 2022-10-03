/**
 * Created by odrozd on 9/29/22.
 */

public with sharing class InterviewsListController {
    @AuraEnabled(Cacheable=true)
    public static List<Interview__c> showInterviews(Id recordId) {
        return getInterviewsPerWeek([SELECT Name, CompanyId__c FROM Interview__c WHERE CompanyId__c =:recordId]);
    }
    private static Integer getWeekNumber(Date value) {
        Integer daysSince1900_01_07 = Date.newInstance(1900, 1, 7).daysBetween(value);
        Integer dayNumber = Math.mod(daysSince1900_01_07, 7) + 1;

        Date dateForYear = value.addDays(Math.mod(8 - dayNumber, 7) - 3);
        Integer year = dateForYear.year();
        Date year_01_01 = Date.newInstance(year, 1, 1);

        Integer week = (Integer) Math.floor((year_01_01.daysBetween(value)
                + Math.mod((Math.mod(Date.newInstance(
                1900, 1, 7).daysBetween(year_01_01), 7) + 1) + 1, 7) - 3) / 7 + 1);
        return week;
    }

    private static List<Interview__c> getInterviewsPerWeek(List<Interview__c> interviews) {
        List<Interview__c> interviewsToReturn = new List<Interview__c>();
        for (Interview__c interview : interviews) {
            if (getWeekNumber(interview.Conducted_Date__c) == getWeekNumber(Date.today())) {
                interviewsToReturn.add(interview);
            }
        }
        return interviewsToReturn;
    }
}