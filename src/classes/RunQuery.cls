global class RunQuery implements Database.Batchable<AggregateResult> { 
 
    global Iterable<AggregateResult> start(Database.BatchableContext BC){ 
    	system.debug('start');
        return new AggregateResultIterable(); 
    } 
     
    global void execute(Database.BatchableContext BC, List<sObject> scope){ 
        for(sObject s : scope){ 
        System.debug('----------' + s); 
        } 
    } 
     
    global void finish(Database.BatchableContext BC){ 
        AsyncApexJob a = 
        [Select Id, Status, NumberOfErrors, JobItemsProcessed,TotalJobItems,CreatedBy.Email FROM AsyncApexJob WHERE Id = :BC.getJobId()]; 
        System.debug('********: ' + a.Id); 
    } 
}