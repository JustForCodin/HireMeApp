/**
 * Created by odrozd on 10/7/22.
 */

@IsTest
private class AssignInterviewServiceTest {
    @IsTest
    static void testUpdateRelatedVacancies() {
        List<Interview__c> interviews = [SELECT Id, Name FROM Interview__c];
        AssignInterviewService.updateRelatedVacancies(interviews);
    }

    @IsTest
    static void testUpdateVacancyStatus() {
        List<Id> vacancies = new List<Id>();
        List<Vacancy__c> allVacancies = [SELECT Id FROM Vacancy__c];
        for (Vacancy__c v : allVacancies) {
            vacancies.add(v.Id);
        }
        AssignInterviewService.updateVacancyStatus(vacancies, true);
    }

    @IsTest
    static void checkInterviewsNumber() {
        List<Interview__c> interviews = [SELECT Id, Name FROM Interview__c];
        AssignInterviewService.checkInterviewsNumber(interviews);
    }

    @IsTest
    static void testCreateJobOffer() {
        List<Interview__c> interviews = [SELECT Id, Name FROM Interview__c];
        AssignInterviewService.createJobOffer(interviews);
    }
}