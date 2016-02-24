global class AggregateResultTaskBatch implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT id, whoid, whatid, subject, description FROM Task limit 10';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<task> scope) {
        list<utilcustomlog.scustomlog> lcl = new list<utilcustomlog.scustomlog>();
        list<task> lth = new list<task>();
        for (task a: scope) {
			lth.add(a);
            if (a.WhoId != null) {
                Attachment atth = new Attachment();
                atth.ParentId = a.WhoId;
                if (a.subject != null) {
                	atth.Name = a.subject + Date.Today();    
                } else {
                    atth.Name = 'General' + Date.Today();    
                }
                atth.ContentType = 'text/plain';
                atth.Body = Blob.valueOf(a.description);
                insert atth;
                lcl.add(new utilcustomlog.scustomlog('AggregateResultTaskBatch','New Attachment on: '+a.WhoId, null,atth.id,'Ok',null,'NoCategory'));
            }
        }
        if (lth.size()>0) {
            delete lth;
        	lcl.add(new utilcustomlog.scustomlog('AggregateResultTaskBatch','delete: '+lth.size(), null,string.valueof(lth),'Ok',null,'NoCategory'));

        }
        utilcustomlog.writelog(lcl);

    }

    global void finish(Database.BatchableContext BC) {
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