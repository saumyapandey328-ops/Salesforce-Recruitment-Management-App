public class JobApplicationTriggerHandler {
    public static void preventDuplicateApplications(List<job_Application__c>jobList){
        
        Set<Id> candidateIds = new Set<Id>();
        Set<Id> jobOpeningIds = new Set<Id>();

        // Step 1: Collect Candidate and Job Opening IDs
        for (job_Application__c job : jobList) {
            if (job.Candidate__c != null &&
                job.Job_Opening__c != null) {

                candidateIds.add(job.Candidate__c);
                jobOpeningIds.add(job.Job_Opening__c);
            }
        }

        if (candidateIds.isEmpty() || jobOpeningIds.isEmpty()) {
            return;
        }

        // Step 2: Find existing applications
        Map<String, Id> existingApplications = new Map<String, Id>();

        for (job_Application__c job : [
            SELECT Id, Candidate__c, Job_Opening__c
            FROM Job_Application__c
            WHERE Candidate__c IN :candidateIds
            AND Job_Opening__c IN :jobOpeningIds
        ]) {
            String key = String.valueOf(job.Candidate__c) + '-' +
                         String.valueOf(job.Job_Opening__c);

            existingApplications.put(key, job.Id);
        }

        // Step 3: Check incoming applications
        for (Job_Application__c job : jobList) {
            if (job.Candidate__c == null ||
                job.Job_Opening__c == null) {
                continue;
            }

            String key = String.valueOf(job.Candidate__c) + '-' +
                         String.valueOf(job.Job_Opening__c);

            if (existingApplications.containsKey(key)) {
                job.addError(
                    'Duplicate Application! This candidate has already applied for this job opening.'
                );
            } else {
                existingApplications.put(key, job.Id);
            }
        }
    } 
         public static void updateCandidate(List<job_Application__c>jobList,MAP<Id,job_Application__c>appOldMap) {
        List<Candidate__c>cList=new List<Candidate__c>();
        Set<id>candidateId=new Set<id>();
        
        for(job_Application__c job:jobList){
            if(job.Candidate__c!=null&&job.Status__c=='Selected'&&appOldMap.get(job.Id).Status__c!='Selected'){
                
              candidateId.add(job.Candidate__c); }
          }
         for(Candidate__c cd:[Select id,Status__c from Candidate__c where id in: candidateId]){
            cd.Status__c='Selected';
            cList.add(cd);
        }
        update cList;
        
        
        
        
        
        
        
        
        
        
    }   
        
    }