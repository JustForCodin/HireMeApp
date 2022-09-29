/**
 * Created by odrozd on 9/29/22.
 */

public with sharing class InterviewsListController {
    @AuraEnabled(Cacheable=true)
    public static List<Interview__c> showInterviews(Id recordId) {
        return [SELECT Name, CompanyId__c FROM Interview__c WHERE CompanyId__c =:recordId];
    }
}