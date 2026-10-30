trigger jobApplicationTrigger on job_Application__c (before insert,after update) {
if (Trigger.isBefore && Trigger.isInsert) {
        JobApplicationTriggerHandler.preventDuplicateApplications(Trigger.new);
    }
    if (Trigger.isAfter && Trigger.isUpdate) {
        JobApplicationTriggerHandler.updateCandidate(Trigger.new,Trigger.oldMap);
    }
}