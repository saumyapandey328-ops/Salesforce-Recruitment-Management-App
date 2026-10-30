import { LightningElement,wire } from 'lwc';
import getJobOpenings from '@salesforce/apex/JobOpeningController.getJobOpenings';
import { NavigationMixin } from 'lightning/navigation';
import createJobApplication from '@salesforce/apex/JobOpeningController.createJobApplication';
export default class JobOpeningCards extends NavigationMixin(LightningElement) {
jobOpenings;
 @wire(getJobOpenings)
 wiredJobOpenings({data,error}){
    if(data){
        this.jobOpenings=data;
    }else if(error){
        console.error('Error loading job openings:',error);
    }
 }
handleViewDetails(event) {
    const recordId = event.currentTarget.dataset.id;

    this[NavigationMixin.Navigate]({
        type: 'standard__recordPage',
        attributes: {
            recordId: recordId,
            objectApiName: 'Job_opening__c',
            actionName: 'view'
        }
    });
}

showApplicationForm = false;
selectedJobId;

handleApplyNow(event) {
    this.selectedJobId = event.currentTarget.dataset.id;
    this.showApplicationForm = true;

    console.log('Selected Job ID:', this.selectedJobId);
    console.log('Form visibility:', this.showApplicationForm);
}
handleCloseForm() {
    this.showApplicationForm = false;
}
candidateType = 'existing';

candidateTypeOptions = [
    { label: 'Existing Candidate', value: 'existing' },
    { label: 'New Candidate', value: 'new' }
];
handleCandidateTypeChange(event) {
    this.candidateType = event.detail.value;
    console.log('Selected Candidate Type:', this.candidateType);
}
get isNewCandidate() {
    return this.candidateType === 'new';
}
get isExistingCandidate() {
    return this.candidateType === 'existing';
}
candidateName = '';
candidateEmail = '';

handleInputChange(event) {
    const fieldName = event.target.name;
    const fieldValue = event.target.value;

    if (fieldName === 'candidateName') {
        this.candidateName = fieldValue;
    } else if (fieldName === 'candidateEmail') {
        this.candidateEmail = fieldValue;
    }

    console.log('Candidate Name:', this.candidateName);
    console.log('Candidate Email:', this.candidateEmail);
}


async handleSaveApplication() {
    try {
        const applicationId = await createJobApplication({
            candidateId: null,
            jobOpeningId: this.selectedJobId,
            candidateName: this.candidateName,
            candidateEmail: this.candidateEmail,
            candidateType: this.candidateType
        });

        console.log('Application created:', applicationId);
        alert('Job application saved successfully!');
    } catch (error) {
        console.error('Error creating application:', error);

        alert(
            error?.body?.message ||
            'Unable to save application. Please check the Console.'
        );
    }
}
}