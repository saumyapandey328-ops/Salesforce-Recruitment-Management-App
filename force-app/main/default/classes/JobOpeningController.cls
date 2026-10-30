public with sharing class JobOpeningController {

    @AuraEnabled(cacheable=true)
    public static List<Job_opening__c> getJobOpenings() {

        return [
            SELECT Id, Name, Maximum_Salary__c, Minimum_Salary__c
            FROM Job_opening__c
            WITH USER_MODE
            ORDER BY CreatedDate DESC
        ];
    }
    


@AuraEnabled
public static Id createJobApplication(
    Id candidateId,
    Id jobOpeningId,
    String candidateName,
    String candidateEmail,
    String candidateType
) {
    if (jobOpeningId == null) {
        throw new AuraHandledException('Please select a job opening.');
    }

    if (candidateType == 'new') {
        if (String.isBlank(candidateName) ||
            String.isBlank(candidateEmail)) {
            throw new AuraHandledException(
                'Please enter candidate name and email.'
            );
        }

        Candidate__c candidate = new Candidate__c();
        candidate.Name = candidateName;
        candidate.Email__c = candidateEmail;
        insert candidate;

        candidateId = candidate.Id;
    }

    if (candidateId == null) {
        throw new AuraHandledException(
            'Please select an existing candidate.'
        );
    }

    job_Application__c application = new job_Application__c();
    application.Candidate__c = candidateId;
    application.Job_opening__c = jobOpeningId;
    application.Status__c = 'Applied';

    insert application;

    return application.Id;
}
}