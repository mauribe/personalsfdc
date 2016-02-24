global class class05Schedulable implements Schedulable, Database.AllowsCallouts{
//The following example uses the System.Schedule method to implement the above class.
//SELECT id, cronjobdetailid, nextfiretime, previousfiretime, state, starttime, endtime, cronexpression, timezonesidkey, ownerid, lastmodifiedbyid, createdbyid, createddate, timestriggered FROM CronTrigger where id = '08e2400000Hv3zxAAB'
    global void execute(SchedulableContext SC) {
    	//ID jobID = System.enqueueJob(new class04Queueable(1));
        map<id, account> mid = new map<id,account>([select id from account limit 1]);
        list<id> lid = new list<id>(mid.keyset());
        class01.myFutureMethod(lid);
        list<customlog__c> lcl = new list<customlog__c>();
                lcl.add(new customlog__c(
                    Apex_Class__c='class05Schedulable', 
                    Description__c='Operation was successful', 
                    //Fields__c = null, //err.getFields()
                    //Record_ID__c='',
                    Status__c='Ok',
                    //StatusCode__c = null, //getStatusCode()
                    Category__c = 'NoCategory')
                );
        ID jobID = System.enqueueJob(new UtilQCustomLog(lcl));
        
        
        
        
//You can also use the Schedulable interface with batch Apex classes        
        //batchable b = new batchable(); 
		//database.executebatch(b);
		
    }
}