trigger ShareRecordTrigger on AccountChild__c (after update) {

/* Anonymous Script
//list<customlog__c> lcc = [select id from customlog__c]; delete lcc;
//list<accountchild__share> deleteAc = [select id from accountchild__share where UserOrGroupId = '00524000001rjwVAAQ']; delete deleteAc;
list<accountchild__c> ac = [select id,description__c from accountchild__c limit 2];
//for (accountchild__c acup1: ac) {acup1.description__c = 'TEST123';}
for (accountchild__c acup1: ac) {
    acup1.description__c = 'A';
    acup1.sharewith__c = '00524000001rjwVAAQ';
    acup1.batch__c=false;
}
update ac;
*/
    list<utilcustomlog.scustomlog> lcl = new list<utilcustomlog.scustomlog>();
    UtilCustomLog uc = new UtilCustomLog();
    map<id, string> mID = new map<id, string>();
    String vInputRecordID;
    for (id ac : trigger.newmap.keySet()) {
        if (trigger.newmap.get(ac).batch__c == false) {
            mID.put(ac,trigger.newmap.get(ac).ShareWith__c);
        }
        vInputRecordID+='|'+ac;
    }
    
    //if(trigger.isafter) {
    //    return;
    //}
    
    if (mID.size()>0) {
        lcl.add(new utilcustomlog.scustomlog('ShareRecordTrigger','Operation was successful', null,vInputRecordID,'Ok',null,'NoCategory'));
        ShareRecordAddcls classSRA = new ShareRecordAddcls('AccountChild__c', mID);        
    } else {
		lcl.add(new utilcustomlog.scustomlog('ShareRecordTrigger','No Sharing rules added to these records', null,vInputRecordID,'Ok',null,'NoCategory'));
    }
    utilcustomlog.WriteLog(lcl);
}