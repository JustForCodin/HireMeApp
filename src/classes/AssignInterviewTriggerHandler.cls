/**
 * Created by odrozd on 9/30/22.
 */

public with sharing class AssignInterviewTriggerHandler {
    public static void handle(List<Interview__c> interviews, System.TriggerOperation triggerOperation)
    {
        switch on triggerOperation{
            when AFTER_UPDATE, AFTER_INSERT{
                AssignInterviewService.updateRelatedVacancies(interviews);
                AssignInterviewService.checkInterviewsNumber(interviews);
            }
        }
    }
}