@IsTest
private class CaseManagerTest_v2 {

    //@HttpGet
    @isTest static void testGetCaseById() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://na1.salesforce.com/services/apexrest/Cases/V1/'
            + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Case thisCase = CaseManager.getCaseById();
        // Verify results
        System.assert(thisCase != null);
        System.assertEquals('Test record', thisCase.Subject);
    }
	//@HttpPost
    @isTest static void testCreateCase() {
        // Call the method to test
        String jsonStr = '{ "subject" : "Bigfoot Sighting!", "status" : "New", "origin" : "Phone","priority" : "Low" }';
        JSONParser parser = JSON.createParser(jsonStr);
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        RestRequest restReq = RestContext.request;    
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint('https://na1.salesforce.com/services/apexrest/Cases/V1/');
        req.setBody('{"dateRange":{"f":"2011-09-01","l":"2011-09-01"}}');
        HttpResponse res;
        try {
            res = h.send(req);
            System.debug('HTTP Response Code: ' + res.getStatusCode());
            System.debug('Response Body: ' + res.getBody());
        } catch (Exception e) {
            System.debug('Callout Error:' + e.getMessage());            
        }
        System.assert(res.getStatusCode() == 200);
        
        /* RestRequest request = new RestRequest();
        request.requestUri =
            'https://na1.salesforce.com/services/apexrest/Cases/V1/';
        request.httpMethod = 'POST';
        system.debug('parser.getBlobValue '+parser.getBlobValue());
        //request.requestBody = parser.getBlobValue();
        RestContext.request = request;
        system.debug('RestContext.request '+RestContext.request); */
        //RestResponse res = RestContext.response;
        //System.assert(res.statusCode == 200);
        
        
        
        /* ID thisCaseId = CaseManager.createCase(
            'Ferocious chipmunk', 'New', 'Phone', 'Low'); 
        // Verify results
        System.assert(thisCaseId != null);
        Case thisCase = [SELECT Id,Subject FROM Case WHERE Id=:thisCaseId];
        System.assert(thisCase != null);
        System.assertEquals(thisCase.Subject, 'Ferocious chipmunk'); */
    }

    @isTest static void testDeleteCase() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://na1.salesforce.com/services/apexrest/Cases/'
            + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        CaseManager.deleteCase();
        // Verify record is deleted
        List<Case> cases = [SELECT Id FROM Case WHERE Id=:recordId];
        System.assert(cases.size() == 0);
    }

    @isTest static void testUpsertCase() {
        // 1. Insert new record
        ID case1Id = CaseManager.upsertCase(
                'Ferocious chipmunk', 'New', 'Phone', 'Low', null);
        // Verify new record was created
        System.assert(Case1Id != null);
        Case case1 = [SELECT Id,Subject FROM Case WHERE Id=:case1Id];
        System.assert(case1 != null);
        System.assertEquals(case1.Subject, 'Ferocious chipmunk');
        // 2. Update status of existing record to Working
        ID case2Id = CaseManager.upsertCase(
                'Ferocious chipmunk', 'Working', 'Phone', 'Low', case1Id);
        // Verify record was updated
        System.assertEquals(case1Id, case2Id);
        Case case2 = [SELECT Id,Status FROM Case WHERE Id=:case2Id];
        System.assert(case2 != null);
        System.assertEquals(case2.Status, 'Working');
    }    

    @isTest static void testUpdateCaseFields() {
        Id recordId = createTestRecord();
        // updateCaseFields() expects request parameters.
        // Set parameters in test request.
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://na1.salesforce.com/services/apexrest/Cases/'
            + recordId;
        request.httpMethod = 'PATCH';
        request.params.put('id', recordId);
        request.params.put('status', 'Working');
        RestContext.request = request;
        // Update status of existing record to Working
        ID thisCaseId = CaseManager.updateCaseFields();
        // Verify record was updated
        System.assert(thisCaseId != null);
        Case thisCase = [SELECT Id,Status FROM Case WHERE Id=:thisCaseId];
        System.assert(thisCase != null);
        System.assertEquals(thisCase.Status, 'Working');
    }  

    // Helper method
    static Id createTestRecord() {
        // Create test record
        Case caseTest = new Case(
            Subject='Test record',
            Status='New',
            Origin='Phone',
            Priority='Medium');
        insert caseTest;
        return caseTest.Id;
    }          

}