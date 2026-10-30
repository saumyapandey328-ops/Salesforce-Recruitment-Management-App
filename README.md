# Salesforce Recruitment Management App

## Project Overview

The Salesforce Recruitment Management App is designed to simplify and manage the recruitment process within an organization. It helps recruiters manage job openings, maintain candidate information, track job applications, and automate recruitment activities.

The application is developed using Salesforce declarative tools and custom development technologies.

## Technologies Used

- Salesforce CRM
- Apex Programming
- SOQL
- Lightning Web Components (LWC)
- Salesforce Flows
- Validation Rules
- Apex Triggers
- Salesforce Reports and Dashboards
- VS Code
- Salesforce CLI
- Git and GitHub

## Custom Objects

The application includes three custom objects:

1. **Job Opening**
   - Stores job details, department, location, salary range, employment type, and application deadline.

2. **Candidate**
   - Maintains candidate information such as email, phone number, skills, experience, and qualification.

3. **Job Application**
   - Tracks candidate applications, job openings, application status, interview date, expected salary, and recruiter feedback.

## Key Features

### 1. Job and Candidate Management
- Create and manage job openings.
- Maintain candidate records.
- Track applications against specific job openings.

### 2. Validation Rules
- Ensures minimum salary does not exceed maximum salary.
- Requires an interview date when application status is Interview Scheduled.

### 3. Salesforce Flows
- Automatically creates a follow-up Task when a job application status changes to Selected.
- Includes a duplicate job application prevention flow.

### 4. Apex Development
- Apex Trigger and Handler implementation.
- Prevents duplicate applications for the same candidate and job opening.
- Updates candidate status when a job application is selected.

### 5. Lightning Web Components
- Custom Job Opening Cards component.
- Displays available job openings.
- Provides an Apply option for candidates.
- Supports new and existing candidate application workflows.

### 6. Reports and Dashboards
- Recruitment application reports.
- Application status-wise reporting.
- Dashboard with visual representation of recruitment data.

## Project Structure

```text
force-app/
└── main/
    └── default/
        ├── classes/
        ├── flows/
        ├── lwc/
        │   └── jobOpeningCards/
        ├── objects/
        │   ├── Candidate__c/
        │   ├── Job_opening__c/
        │   └── job_Application__c/
        └── triggers/
```

## Tools Used

- Salesforce Developer Edition
- Visual Studio Code
- Salesforce CLI
- GitHub

## Future Enhancements

- Improve candidate search and application experience.
- Enhance recruitment dashboard and reporting.
- Add more automation and security controls.

## Author

**Naincy Pandey**

GitHub Repository: [Salesforce Recruitment Management App](https://github.com/saumyapandey328-ops/Salesforce-Recruitment-Management-App)
