global class SharingRecalculationAccountChild implements Database.Batchable<sObject> {
    utilCustomLog uc = new utilCustomLog();
    list<customlog__c> lCl = new list<customlog__c>();

    global Database.QueryLocator start(Database.BatchableContext BC){
    	return Database.getQueryLocator([SELECT Id, ShareWith__c FROM AccountChild__c]);
    }
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        
        Map<ID, AccountChild__c> aChildMap = new Map<ID, AccountChild__c>((List<AccountChild__c>)scope); // Create a map for the chunk of records passed into method.
        List<AccountChild__Share> newaChildShrs = new List<AccountChild__Share>(); // Create a list of Job__Share objects to be inserted.
        List<AccountChild__Share> oldaChildShrs = [SELECT Id FROM AccountChild__Share WHERE ParentId IN
        :aChildMap.keySet() AND RowCause = :Schema.AccountChild__Share.rowCause.ApexSharing__c]; // Only records using an Apex sharing reason for this app should be returned.
        // Construct new sharing records for the hiring manager and recruiter on each Job record.
        for(AccountChild__c aChild : aChildMap.values()){
        	AccountChild__Share uac = new AccountChild__Share();
                uac.AccessLevel = 'Read';
                uac.ParentId = aChild.id;
                uac.UserOrGroupId = aChild.ShareWith__c;
                uac.RowCause = Schema.AccountChild__share.RowCause.ApexSharing__c;
                newaChildShrs.add(uac);
        }
        try {
            delete oldaChildShrs;
            uc.DBSave(newaChildShrs, 'SharingRecalculationAccountChild');
        } catch (dmlexception e) {
			lCl.add(new customlog__c(
                    Apex_Class__c='SharingRecalculationAccountChild', 
                    Description__c=string.valueof(e), 
                    //Fields__c = null, //err.getFields()
                    //Record_ID__c='',
                    Status__c='Error',
                    //StatusCode__c = null, //getStatusCode()
                    Category__c = 'NoCategory'));
        }
        
        
    }
    global void finish(Database.BatchableContext BC){
        lCl.add(new customlog__c(
                    Apex_Class__c='SharingRecalculationAccountChild', 
                    Description__c='Operation was successful', 
                    //Fields__c = null, //err.getFields()
                    //Record_ID__c='',
                    Status__c='Ok',
                    //StatusCode__c = null, //getStatusCode()
                    Category__c = 'NoCategory'));
        uc.WriteLog(lCl);
    }

}