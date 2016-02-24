public class UtilCustomLog {
    // Script made by ...
    // version number
    // is still missing: 
    	// custom settings to set the right log level
    	// visualforce page to access to log
    	// class batch to delete the old logs

//SELECT id, ownerid, isdeleted, name, createddate, createdbyid, lastmodifieddate, lastmodifiedbyid, systemmodstamp, lastactivitydate, description__c, apex_class__c, record_id__c, statuscode__c, fields__c, status__c, category__c FROM customlog__c order by name desc
    //////// HELP //////////
//list<utilcustomlog.scustomlog> lcl = new list<utilcustomlog.scustomlog>();
//lcl.add(new utilcustomlog.scustomlog('apex','description', null,'getid','Error','geststatuscode','NoCategory'));
//utilcustomlog.writelog(lcl);  
    
    public UtilCustomLog (){
        system.debug('UtilCustomLog constructor with parameters');
        UtilCustomLogCustomSet__c  Utilcs = UtilCustomLogCustomSet__c.getValues('Default');
        if (Utilcs.Log_Level__c == 2) {
            system.debug('log level: '+Utilcs.Log_Level__c);
        }
    }
    
    public class sCustomLog {
        public string clApex_Class;
        public string clDescription;
        public string clFields;
        public string clRecord_ID;
        public string clStatus;
        public string clStatusCode;
        public string clCategory;
        
        public sCustomLog(string clApex_Class,string clDescription,string clFields,string clRecord_ID,string clStatus,string clStatusCode,string clCategory){
            this.clApex_Class = clApex_Class;
            this.clDescription = clDescription;
            this.clFields = clFields;
            this.clRecord_ID = clRecord_ID;
            this.clStatus = clStatus;
            this.clStatusCode = clStatusCode;
            this.clCategory = clCategory;
        }
        public sCustomLog() {
            this.clApex_Class = clApex_Class;
            this.clDescription = clDescription;
            this.clFields = clFields;
            this.clRecord_ID = clRecord_ID;
            this.clStatus = clStatus;
            this.clStatusCode = clStatusCode;
            this.clCategory = clCategory;
        }
    } 
    
    // Method to insert all the data into the DB
    public void DBSave(list<sObject> acctList, string vApexClass, string vAction) {
        map<Database.SaveResult, string> mapDBsave = new map<Database.SaveResult, string>();
        Database.SaveResult[] srList;
        if (vAction =='Insert') {
        	srList = Database.insert(acctList, false);    
        } else if (vAction =='Update') {
            srList = Database.update(acctList, false);
        }
        for (Database.SaveResult dsadd: srList) {
        	mapDBsave.put(dsadd, vApexClass);    
        }
        DBSaveResult(mapDBsave);
    }
    
    // method to handle the database.saveresult
    public void DBSaveResult(map<Database.SaveResult, string> mapDBsave) {
		list<scustomlog> lcl = new list<scustomlog>();
        //list<customlog__c> lcl = new list<customlog__c>();
        for (Database.SaveResult sr : mapDBsave.keySet()) {
            if (sr.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted account. Account ID: ' + sr.getId());
                lcl.add(new scustomlog(mapDBsave.get(sr),'Operation was successful', null,sr.getId(),'Ok',null,'NoCategory'));
            }
            else {
                // Operation failed, so get all errors
                for(Database.Error err : sr.getErrors()) {
                    System.debug('The following error has occurred.');
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Account fields that affected this error: ' + err.getFields());
                    string vField;
                    for (string field: err.getFields()) {
                        vField += '|'+field; //Returns an array of one or more field names. Identifies which fields in the object, if any, affected the error condition
                    }
                    
                    lcl.add(new scustomlog(mapDBsave.get(sr),err.getMessage(), null,sr.getId(),'Error',string.valueof(err.getStatusCode()),'NoCategory'));
                }
            }
        }
        if (lcl.size()>0) {WriteLog(lcl);}
        
    }
    
/*    if(so instanceof AccountChild__Share) {
                AccountChild__Share vas = (AccountChild__Share)so;
                lAs.add(vas);
  */      
    
    public static void WriteLog(List<sCustomLog> tempcl) {
        list<customlog__c> sObjWriteLog = new list<customlog__c>();        

        for (sCustomLog sc: tempcl) {
            customlog__c sObjcl = new customlog__c();
            sObjcl.Apex_Class__c = sc.clApex_Class;
            sObjcl.Description__c= sc.clDescription;
            sObjcl.Fields__c = sc.clFields;
            sObjcl.Record_ID__c=sc.clRecord_ID;
            sObjcl.Status__c=sc.clStatus;
            sObjcl.StatusCode__c = sc.clStatusCode;
            sObjcl.Category__c = sc.clCategory;
            sObjWriteLog.add(sObjcl);
        }

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
    
    public static void getPiclistValues() {
        Schema.DescribeFieldResult fieldResult = CustomLog__c.Category__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
    }
    
}