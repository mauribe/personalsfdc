@IsTest
private class AccountManagerTest {

    @isTest static void testgetAccount() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://na1.salesforce.com/services/apexrest/AccountManager/V1/'
            + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account ThisAccount = AccountManager.getAccount();
        // Verify results
        System.assert(ThisAccount != null);
        System.assertEquals('Test Account', ThisAccount.name);
    }
    
    static Id createTestRecord() {
        // Create test record
        Account accountTest = new Account(
            Name = 'Test Account');
        insert accountTest;
        return accountTest.Id;
        
    }
          

}