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

    @TestVisible
    private static List<Vacancy__c> updateVacancyStatus(List<Id> vacancies, Boolean isOpen) {
        List<Vacancy__c> vacanciesToReturn = [SELECT Id FROM Vacancy__c WHERE Id IN :vacancies];
        for (Vacancy__c vacancy : vacanciesToReturn) {
            vacancy.Is_Open__c = isOpen;
        }
        return vacanciesToReturn;
    }

    public static void checkInterviewsNumber(List<Interview__c> interviews) {
        List<Contact> contactsWithInterviews = [SELECT Name, (SELECT Name FROM Interviews__r)
                                                FROM Contact
                                                WHERE RecordType.Name='Interviewer Account'];
        for (Contact c : contactsWithInterviews) {
            if (c.Interviews__r.size() > 3) {
                interviews[0].addError('TEST ERROR!!!!!');
            }
        }
    }

    public static void createJobOffer(List<Interview__c> interviews) {
        List<Vacancy__c> vacancies = [SELECT Id FROM Vacancy__c WHERE Is_Open__c=FALSE];
//        List<Interview__c> interviews = [SELECT Id FROM Interview__c];
        for (Vacancy__c vacancy : vacancies) {
            for (Interview__c interview : interviews) {
                if (interview.Candidate_Approved__c == true) {
                    insert new Job_Offer__c(
                            InterviewId__c = interview.Id,
                            VacancyId__c   = vacancy.Id,
                            CompanyId__c   = interview.CompanyId__c
                    );
                }
            }
        }
    }
}