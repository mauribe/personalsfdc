trigger HandleOrderUpdate on Invoice__c (after update) {
    
    set<id> sid = new set<id>();
    Map<ID, Invoice__c> oldMap = new Map<ID, Invoice__c>(Trigger.old);
    for (Invoice__c invoice: Trigger.new) {
        if (invoice.status__c == 'Closed' && oldMap.get(invoice.Id).status__c != 'Closed'){
            sid.add(invoice.id);
    	}
    }
    if (sid.size() > 0) {
        integrationHeroku.postOrder(sid,'deserialize');
    }

}