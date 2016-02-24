public class Integration {
    public class ExternalOrder {
    public String id {get; set;}
    public Integer order_number {get; set;}
    }

    @future (callout=true) // indicates that this is an asynchronous call
    public static void postOrder(List<Id> invoiceIds) {
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartArray();
        for (Id invoiceId : invoiceIds) {
            gen.writeStartObject();
            gen.writeStringField('id', invoiceId);
            gen.writeEndObject();
        }
        gen.writeEndArray();
        String jsonOrders = gen.getAsString();
        System.debug('jsonOrders: ' + jsonOrders);
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://hidden-cliffs-1534.herokuapp.com/order');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(jsonOrders);
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug('Fulfillment service returned '+ res.getBody());
        if (res.getStatusCode() != 200) {
            System.debug('Error from ' + req.getEndpoint() + ' : ' +
            res.getStatusCode() + ' ' + res.getStatus());
        }
        else {
        List<Invoice__c> invoices = [SELECT Id FROM Invoice__c WHERE Id IN :invoiceIds];
        List<ExternalOrder> orders = (List<ExternalOrder>)JSON.deserialize(res.getBody(),List<ExternalOrder>.class);
        Map<Id, Invoice__c> invoiceMap = new Map<Id, Invoice__c>(invoices);
        for ( ExternalOrder order : orders ) {
            Invoice__c invoice = invoiceMap.get(order.id);
            invoice.order_number__c = String.valueOf(order.order_number);
        }
        update invoices;
        }
    }
}