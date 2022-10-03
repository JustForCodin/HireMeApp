/**
 * Created by odrozd on 10/3/22.
 */

trigger AssignInterview on Interview__c (after insert, after update) {
    AssignInterviewTriggerHandler.handle(Trigger.new, Trigger.operationType);
}