trigger RestrictContactByName on Contact (before insert, before update, after update) {
    if(system.isFuture()) {
        system.debug('isFuture');
        return;
    }

    if(trigger.isBefore) {
        return;
    }
    
    //list<Contact> vLContactOld = new list<Contact>(trigger.old);
    //map<id, Contact> vLContactOldMap = new map<id, Contact>(trigger.oldMap);
    //list<Contact> vLContactNew = new list<Contact>(trigger.new);    
    map<id, Contact> vLContactNewMap = new map<id, Contact>(trigger.newMap);    
    //system.debug('vLContactOld ==>'+vLContactOld);
    //system.debug('vLContactOldMap ==>'+vLContactOldMap);    
    //system.debug('vLContactNew ==>'+vLContactNew);    
    //system.debug('vLContactNewMap ==>'+vLContactNewMap);
    string vId;
    for (id vl: vLContactNewMap.keySet() ) {
        vId+='|'+vl;
    }
	system.debug('vId ==> '+vId);

    customlog__c lc = new customlog__c(
    	record_id__c = vId
    );
    insert lc;
    
    
}