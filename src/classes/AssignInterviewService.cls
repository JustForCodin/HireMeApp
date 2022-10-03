/**
 * Created by odrozd on 9/30/22.
 */

public with sharing class AssignInterviewService {
    public static void updateRelatedVacancies(List<Interview__c> interviews) {
        List<Id> vacanciesToOpen = new List<Id>();
        List<Id> vacanciesToClose = new List<Id>();

        List<Interview__c> allInterviews = [SELECT Id, Name, Candidate_Approved__c, VacancyId__c
                                            FROM Interview__c];
        for (Interview__c interview : allInterviews) {
            if (interview.Candidate_Approved__c == true) {
                vacanciesToClose.add(interview.VacancyId__c);
            } else {
                vacanciesToOpen.add(interview.VacancyId__c);
            }
        }

        List<Vacancy__c> vacancies = new List<Vacancy__c>();
        vacancies.addAll(updateVacancyStatus(vacanciesToClose, false));
        vacancies.addAll(updateVacancyStatus(vacanciesToOpen, false));
        update vacancies;

    }

    private static List<Vacancy__c> updateVacancyStatus(List<Id> vacancies, Boolean isOpen) {
        List<Vacancy__c> vacanciesToReturn = [SELECT Id FROM Vacancy__c WHERE Id IN :vacancies];
        for (Vacancy__c vacancy : vacanciesToReturn) {
            vacancy.Is_Open__c = isOpen;
        }
        return vacanciesToReturn;
    }
}