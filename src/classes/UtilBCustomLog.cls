global class UtilBCustomLog implements Database.Batchable<sObject> {
//global class UtilBCustomLog implements Database.Batchable<sObject>, Database.AllowsCallouts {
    public integer vResult = 0;
    public integer iResult = 0;
    public string vContext;
    public string query;
    public boolean bSendEmail;
    
    //global UtilBCustomLog(string query) {
    //    this.query = query;
    //}
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        checktmp('Ok','start','the job was started');
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        checktmp('Ok','execute','the job is running');
        if (vContext == 'AccountChild') {
        	list<accountchild__c> lac = new list<accountchild__c>();
            for (sObject so: scope) {
                accountchild__c ac = (accountchild__c)so;
                ac.Description__c = 'a'+vResult;
                lac.add(ac);
                iResult++;
            }
            update lac;
            checktmp('Ok','execute','The job is running on AccountChild and updated records: '+vResult);
                
        } else if (vContext == 'DeleteCustomLog') {
            system.debug('DeleteCustomLog');
            list<customlog__c> cc = (list<customlog__c>)scope;
            delete cc;
            checktmp('Ok','execute','The job is running on DeleteCustomLog and deleted records: '+cc.size()); 
        } else {
            checktmp('Error','execute','Did not understand the context of the batach'); 
        }
        
    }
        
    global void finish(Database.BatchableContext BC){
        
		AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
      	TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id = :BC.getJobId()];
        
        if (bSendEmail) {
        	Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            string email = 'mauriziobella@gmail.com';
            mail.setToAddresses(new String[] {email});
            mail.setReplyTo('mauriziobella@gmail.com');
            mail.setSenderDisplayName('Batch Processing');
            mail.setSubject('Batch Process Completed');
            mail.setPlainTextBody('The batch Apex: '+vResult+' job processed ' + a.TotalJobItems + ' batches with '+ a.NumberOfErrors + ' failures.');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });    
        } else {
            checktmp('Ok','finish','The batch Apex: '+vResult+' job processed ' + a.TotalJobItems + ' batches with '+ a.NumberOfErrors + ' failures.'); 
        }
        
        //insert a check if there is one more batch running.
        integer iCount = [SELECT count() FROM CronTrigger where CronJobDetail.name = 'Job Daily DeleteCustomLog'];
        if (iCount > 0) {
            checktmp('Error','finish','Was not possible to execute one more job due to another one on CronTrigger queue'); 
        } else {
        	UtilBCustomLog utilb = new UtilBCustomLog();
            utilb.query = 'select id from customlog__c where createddate < TODAY'; 
            utilb.vContext = 'DeleteCustomLog';
            utilb.bSendEmail = false;
            String ac06bcronID = System.scheduleBatch(utilb, 'Job Daily DeleteCustomLog', 1440,10); //start 1 day after (1440min) with 10 like scope    
            checktmp('Ok','finish','One more job was scheduled in the future'); 
        }
        
        
        
        
    }
    
    private void checktmp (string status, string statuscode, string description) {
        list<customlog__c> lcl = new list<customlog__c>();
        lcl.add(new customlog__c(
                    Apex_Class__c='UtilBCustomLog', 
                    Description__c=description, 
                    //Fields__c = null, //err.getFields()
                    //Record_ID__c=vInputRecordID,
                    Status__c='Ok',
                    StatusCode__c = statuscode, //getStatusCode()
                    Category__c = 'NoCategory')
                );
        insert lcl;
    }

}


//class01.retryAllFieldsObject('customlog__c');
//list<customlog__c> lc = [select id from customlog__c]; delete lc;

/* System.scheduleBatch
UtilBCustomLog utilb = new UtilBCustomLog();
//utilb.query = 'select id from customlog__c where createddate < TODAY'; 
utilb.query = 'select id from customlog__c'; 
utilb.vContext = 'DeleteCustomLog';
utilb.bSendEmail = false;
String ac06bcronID = System.scheduleBatch(utilb, 'Job Daily DeleteCustomLog', 1,10); //start 1 minute after with 10 like scope
CronTrigger ac06bct = class01.checkAsyncSchedulableJob (ac06bcronID);
system.debug('ac06bct ==> '+ac06bct);
*/        

/* Database.executeBatch
UtilBCustomLog utilb = new UtilBCustomLog();
//utilb.query = 'select id from customlog__c where createddate < TODAY'; 
utilb.query = 'select id from customlog__c'; 
utilb.vContext = 'DeleteCustomLog';
utilb.bSendEmail = false;
Id ac06bId = Database.executeBatch(utilb, 200);
AsyncApexJob ac06bJobinfo = class01.checkAsyncApexJob(ac06bId);
system.debug('ac06bJobinfo ==> '+ac06bJobinfo);
*/