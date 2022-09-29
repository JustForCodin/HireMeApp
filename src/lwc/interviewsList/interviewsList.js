/**
 * Created by odrozd on 9/29/22.
 */

import {LightningElement, api, track, wire} from 'lwc';
import showInterviews from "@salesforce/apex/InterviewsListController.showInterviews";

export default class InterviewsList extends LightningElement {
    @api recordId;
    @track data;
    @wire(showInterviews, { recordId: "$recordId" }) data;
}