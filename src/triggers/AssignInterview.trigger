/**
 * Created by odrozd on 9/30/22.
 */

trigger AssignInterview on Account (before insert, after insert) {
    List<Contact> assignedInterviews =  [SELECT Name, (SELECT Name FROM Interviews__r)
    FROM Contact
    WHERE RecordType.Name='Interviewer Account'];

    for (Contact c : assignedInterviews) {
        if (c.Interviews__r.size() >= 3) {
            Trigger.oldMap.get(c.Id).addError('Only 3 interviews per week can be assigned');
        }
    }
}