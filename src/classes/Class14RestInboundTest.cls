@isTest
public class Class14RestInboundTest {
    @isTest static void testgetClass14() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://mauridev2015-dev-ed.my.salesforce.com/services/apexrest/class14/'
            + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        list<customlog__c> ThisCustomLog = Class14RestInbound.doGet();
        // Verify results
        System.assert(ThisCustomLog != null);
        System.assertEquals('Test', ThisCustomLog[0].Description__c);
    }
    
    @isTest static void testpostClass14() {
        Class14RestInbound.Class14c c1 = new Class14RestInbound.Class14c();
        c1.vInt = 123;
        integer vPostI = Class14RestInbound.doPost(c1);
        System.assert(vPostI != null);
    }
    
    @isTest static void testDeleteClass14() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://mauridev2015-dev-ed.my.salesforce.com/services/apexrest/class14/'
            + recordId;
        request.httpMethod = 'DELETE';
        request.addParameter('id', '123');
        request.addParameter('sp', '456');
        RestContext.request = request;
        String ThisdoDelete = Class14RestInbound.doDelete();
        system.debug('ThisdoDelete ==> '+ThisdoDelete);
        System.assert(ThisdoDelete != null);
    }
    
    @isTest static void testPatchClass14() {
        String vtestPatchClass14c1 = 'test';
        String vtestPatchClass14 = Class14RestInbound.doPatch(vtestPatchClass14c1);
        System.assert(vtestPatchClass14 != null);
    }
    
    @isTest static void testPutClass14() {
        String vtestPutClass14c1 = 'test';
        String vtestPutClass14 = Class14RestInbound.doPut(vtestPutClass14c1);
        System.assert(vtestPutClass14 != null);
    }
    
    
    
    static id createTestRecord () {
        customlog__c cl = new customlog__c(description__c='Test');
        insert cl;
        return cl.id;
    }
}