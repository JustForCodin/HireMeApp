/**
 * Created by odrozd on 9/29/22.
 */

public with sharing class InterviewsListController {
    @AuraEnabled
    public static List<Interview__c> showInterviews(Id interviewId) {
        List<Interview__c> interviews = [SELECT Name FROM Interview__c WHERE Id=:interviewId];
        return interviews;
    }
}