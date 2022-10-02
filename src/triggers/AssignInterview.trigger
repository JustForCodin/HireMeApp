/**
 * Created by odrozd on 10/3/22.
 */

trigger AssignInterview on Interview__c (after update, after insert) {
    List<Interview__c> interviews = [SELECT Id FROM Interview__c];
    AssignInterviewTriggerHandler.handle(interviews, Trigger.operationType);

}