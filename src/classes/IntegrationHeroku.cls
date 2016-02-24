public with sharing class IntegrationHeroku {
    // test with MultiStaticResourceCalloutMock !!!
	private static final string VURL = 'https://infinite-falls-83270.herokuapp.com/order';
    private static final string CONTENTTYPEJSON = 'application/json';
    private static final string CONTENTTYPEXML = 'text/xml';
    private static UtilCustomLog NewUtilCustomLog = new UtilCustomLog();
	
	public IntegrationHeroku() {
		
	}
    
    public class orderJson {
        string orderid;
        string id;
        public orderJson (string orderid,string id) {
            this.orderid = orderid;
            this.id = id;
        }
    } 
    
    public class postOrderJsonWrapper {
		string order_number;
		string id;
        postOrderJsonWrapper() {
            this.order_number = order_number;
            this.id = id;
        }        
    }
	
	@future (callout=true)
	public static void postOrder(set<id> lid, string vMethod) {
		Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(vUrl);
		req.setMethod('POST');
		string jsonOrders = generateJson(lid);
        req.setHeader('Content-Type', 'application/json');
		req.setBody(jsonOrders);
        HttpResponse res = h.send(req);
        String vHeader = res.getHeader('Content-Type');
        
        if (res.getStatusCode() != 200) {
            string vbody = 'Status='+res.getStatus()+' StatusCode='+res.getStatusCode();
            system.debug('System.HttpResponse => '+vbody);
            system.debug('res.getBody() ==> '+res.getBody());
        } else {
			list<invoice__c> licUpdate = new list<invoice__c>();
            if (vMethod =='parseJsonResponseReadValueAs') {
                JSONParser parser = JSON.createParser(res.getBody());
                map<id,sObject> mapInvoice = parseJsonResponseReadValueAs(parser);
                
                list<invoice__c> lic = [select id, order_number__c from invoice__c where id = :mapInvoice.keySet()];
                if (lic.size()>0) {
                    for (invoice__c li: lic) {
                        system.debug('the invoice exists id: '+li.id);
                        invoice__c c = (invoice__c) mapInvoice.get(li.id);
                        c.id = li.id;
                        //system.debug('c ==> '+c.order_number__c);                        
                        licUpdate.add(c);
                    }
                } else {system.debug('no invoice');}
            } 
            else if (vMethod =='deserialize') {
                //List<ExternalOrder> orders = (List<ExternalOrder>)JSON.deserialize(res.getBody(),List<ExternalOrder>.class);
                List<postOrderJsonWrapper> orders = (List<postOrderJsonWrapper>)JSON.deserialize(res.getBody(), List<postOrderJsonWrapper>.class);    
                for(postOrderJsonWrapper ord: orders) {
                    invoice__c ic = new invoice__c();
                    ic.id = ord.id;
                    ic.order_number__c = ord.order_number;
                    licUpdate.add(ic);
                }
            }
            
            if (licUpdate.size()>0) {
                system.debug('licUpdate ==> '+licUpdate);
                NewUtilCustomLog.DBSave(licUpdate, 'IntegrationHeroku','Update');                
            }

        }
	}
	
	public static string getOrder() {
		string vWalk;
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(vUrl);
		req.setMethod('GET');
        HttpResponse res = h.send(req);
        String vHeader = res.getHeader('Content-Type');
        
        // JSON
        if (vHeader.contains(CONTENTTYPEJSON)) {
            system.debug('Content-Type '+CONTENTTYPEJSON);
            string vbody = res.getBody();
            system.debug('vbody => '+vbody); //[{"orderId":1,"id":"123456789012345"}]
            //list<orderJson> oj = new list<orderJson>();
            list<orderJson> oj = (list<orderJson>)JSON.deserialize(vbody, list<orderJson>.class);
            system.debug('oj ==> '+oj);
            //List<InvoiceStatement> deserializedInvoices = (List<InvoiceStatement>)JSON.deserialize(JSONString, List<InvoiceStatement>.class);
        // XML            
        } else if (vHeader.contains(CONTENTTYPEXML)) {
            system.debug('Content-Type '+CONTENTTYPEXML);
            Dom.Document doc = res.getBodyDocument(); //Retrieve the root element for this document.
            Dom.XMLNode address = doc.getRootElement();
            vWalk = UtilsIntegration.walkThroughXml(address);
        }
        return vWalk;
		
	}
    
    public static string generateJson(set<id> invoiceIds) {
        JSONGenerator gen = JSON.createGenerator(true);
        // open the JSON generator
        gen.writeStartArray();
        
        for (Id invoiceId : invoiceIds) { // interate through the list of invoices passed in to the call writing each invoice ID to the array
            gen.writeStartObject();
            gen.writeStringField('id', invoiceId);
            //gen.writeStringField('test', 'AAAAAA');
            gen.writeEndObject();
        }
        gen.writeEndArray(); // close the JSON generator
        String jsonOrders = gen.getAsString(); // create a string from the JSON generator
        System.debug('jsonOrders: ' + jsonOrders); // debugging call, which you can check in debug logs
        return jsonOrders;
    }
    
    private static map<id,sObject> parseJsonResponseReadValueAs (JSONParser parser) {
        map<id,sObject> mapInvoice = new map<id,sObject>();
        //list<invoice__c> lic = new list<invoice__c>();
        while (parser.nextToken() != null) {// Start at the array of invoices.
			if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
                while (parser.nextToken() != null) {
                    if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                        postOrderJsonWrapper js = (postOrderJsonWrapper)parser.readValueAs(postOrderJsonWrapper.class); // Read entire invoice object, including its array of line items.
                        system.debug('js.order_number => '+js.order_number);
                        system.debug('js.id => '+js.id);  
                        invoice__c inv = new invoice__c();                        
                        //inv.id = js.id;
                        inv.order_number__c = js.order_number;
                        //lic.add(inv);
                        mapInvoice.put(js.id, inv);
                    }
                }
            }
        }
        return mapInvoice;
    }
}