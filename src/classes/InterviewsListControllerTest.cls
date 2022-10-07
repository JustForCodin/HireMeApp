/**
 * Created by odrozd on 10/7/22.
 */

@IsTest
private class InterviewsListControllerTest {
    @IsTest
    static void testShowInterviews() {
        InterviewsListController.showInterviews('0017Q00000bOEcuQAG');
    }

    @IsTest
    static void testGetWeekNumber() {
        InterviewsListController.getWeekNumber(Date.today());
    }

    @IsTest
    static void testGetInterviewsPerWeek() {
        List<Interview__c> interviews = [SELECT Id, Name FROM Interview__c];
        InterviewsListController.getInterviewsPerWeek(interviews);
        for (Interview__c interview : interviews) {
            System.assertNotEquals(interview.Conducted_Date__c, null);
            System.assertEquals(
                    InterviewsListController.getWeekNumber(interview.Conducted_Date__c),
                    InterviewsListController.getWeekNumber(Date.today())
            );
        }
    }
}