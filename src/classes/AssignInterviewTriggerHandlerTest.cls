/**
 * Created by odrozd on 10/7/22.
 */

@IsTest
private class AssignInterviewTriggerHandlerTest {
    @IsTest
    static void testHandle() {
        List<Interview__c> interviews = [SELECT Id, Name FROM Interview__c];
        AssignInterviewTriggerHandler.handle(interviews, TriggerOperation.AFTER_INSERT);
    }
}