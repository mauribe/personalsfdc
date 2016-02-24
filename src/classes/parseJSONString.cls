public class parseJSONString {
	string jsonStr = '[{"order_number":26,"id":"0012400000T2F28AAF"},{"order_number":27,"id":"0012400000T2F27AAF"}]' ;
    
    public parseJSONString () {
    
        JSONParser parser = JSON.createParser(jsonStr);
	    system.debug(parser);
        list<invoice__c> lic = new list<invoice__c>();
        while (parser.nextToken() != null) {// Start at the array of invoices.
			if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
                while (parser.nextToken() != null) {
                    if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                        jsonClass js = (jsonClass)parser.readValueAs(jsonClass.class); // Read entire invoice object, including its array of line items.
                        system.debug('js.order_number => '+js.order_number);
                        system.debug('js.id => '+js.id);  
                        invoice__c inv = new invoice__c();                        
                        //inv.id = js.id;
                        inv.order_number__c = js.order_number;
                        lic.add(inv);
                    }
                }
            }
        }
        system.debug('lic ==> '+lic);
            
    }
    
    
    public class jsonClass {
        public string order_number;
        public string id;
        jsonClass(string order_number, string id){
            this.order_number = order_number;
            this.id = id;
        }
    }
    
    
}