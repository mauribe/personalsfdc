global class class06Batchable implements Database.Batchable<sObject>{
//Up to 5 batch jobs can be queued or active concurrently
//    
    global final String Query;
    global final String Entity;
    global final String Field;
    global final String Value;
    global class06Batchable(String q, String e, String f, String v){
    	Query=q; Entity=e; Field=f;Value=v;
    }
    global Database.QueryLocator start(Database.BatchableContext BC){ //To collect the records or objects to pass to the interface method execute
	    return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        for(sobject s : scope){
            s.put(Field,Value);
            }
            update scope;
        }
    global void finish(Database.BatchableContext BC){
        AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
        	TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id = :BC.getJobId()];
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        string email = 'mauriziobella@gmail.com';
        mail.setToAddresses(new String[] {email});
        mail.setReplyTo('mauriziobella@gmail.com');
        mail.setSenderDisplayName('Batch Processing');
        mail.setSubject('Batch Process Completed');
        mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems + ' batches with '+ a.NumberOfErrors + ' failures.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	}
}