global class ExampleBatchClassIterable implements Database.Batchable<AggregateResult> {
    global Iterable<AggregateResult> start(Database.BatchableContext BC) {
        list<AggregateResult> b = [SELECT count(id) quantity, ownerid, DAY_IN_MONTH(createddate) dayinmonth FROM Task GROUP BY DAY_IN_MONTH(createddate), ownerid];
        return b;
    }
    global void execute(Database.BatchableContext BC, List<AggregateResult> bat) {
        list<utilcustomlog.scustomlog> lcl = new list<utilcustomlog.scustomlog>();
        list<taskhistory__c> lth = new list<taskhistory__c>();
        for(AggregateResult b : bat) {
            taskhistory__c th = new taskhistory__c();
            th.quantity__c = string.valueOf(b.get('quantity'));
            th.ownerid__c = string.valueOf(b.get('ownerid'));
            th.DAY_IN_MONTH__c = string.valueOf(b.get('dayinmonth'));
            lth.add(th);
            lcl.add(new utilcustomlog.scustomlog('ExampleBatchClassIterable','Quantity of records: '+string.valueOf(b.get('quantity')), null,null,'Ok',null,'NoCategory'));
        }
        if (lth.size()>0) {
          insert lth;  
            utilcustomlog.writelog(lcl);
        } 
        
    }
    global void finish(Database.BatchableContext BC) {
        
        String ac06bcronID = System.scheduleBatch(new AggregateResultTaskBatch(), 'Job Daily AggregateResultTaskBatch', 2);
        String ac06bcronID2 = System.scheduleBatch(new ExampleBatchClassIterable(), 'Job Daily ExampleBatchClassIterable', 5);
        
		
    }
}