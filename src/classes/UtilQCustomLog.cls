public class UtilQCustomLog implements Queueable {
    List<CustomLog__c> sObjWriteLog;
    public UtilQCustomLog(List<CustomLog__c> sObjWriteLog) {
        this.sObjWriteLog = sObjWriteLog;
    }
    public void execute(QueueableContext context) {
		Database.DMLOptions dmlOptions = new Database.DMLOptions();
        dmlOptions.allowFieldTruncation = true; // truncate in case the value is too large
        dmlOptions.assignmentRuleHeader.useDefaultRule = false; //The Database.DMLOptions object supports assignment rules for cases and leads, but not for accounts or territory management
        dmlOptions.DuplicateRuleHeader.AllowSave = true; //part of the Duplicate Management feature.
        dmlOptions.EmailHeader.triggerAutoResponseEmail = false; // specify whether or not to send an email when the following events occurs
        dmlOptions.EmailHeader.triggerOtherEmail = false; //
        dmlOptions.EmailHeader.triggerUserEmail = false; //
        //dmlOptions.localeOptions = en_GB;
        dmlOptions.optAllOrNone = false;

        List<Database.SaveResult> sr = Database.insert(sObjWriteLog, dmlOptions);

        for(Database.SaveResult vResult : sr ) {
            if(vResult.issuccess()){
				system.debug('WriteLog sObjectID: '+vResult.getId());
            } else {
                for(Database.Error err : vResult.getErrors()) {
                    System.debug('The following error has occurred.');
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Fields that affected this error: ' + err.getFields());
                }
            }
        }        
    }
}