@isTest
public class class01Test {

// /// testSetup ///
//the testing framework executes the test setup method first, before any test method in the class. Records that are created in a test setup 
//method are available to all test methods in the test class and are rolled back at the end of test class execution
    
    @testSetup static void setup() {
	    List<sObject> ls = Test.loadData(Account.sObjectType, 'AccountTestData'); //insert the Object + Static Resource (CSV file)
        // Verify that all 3 test accounts were created
        System.assert(ls.size() == 3);
        // Get first test account
        Account a1 = (Account)ls[0];
        String acctName = a1.Name;
        System.debug(acctName);
    }
    
    @isTest static void checkClassSecurityTest(){
    //or public static testmethod void checkClassSecurityTest(){
    	String sObj = 'Account';
        List<Object> ccstL = class01.checkClassSecurity(sObj);
    }
    
    @isTest static void checkClassSecurityTest01(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Read Only'];
        User u = new User(Alias = 'standt', Email='mauriziobella@gmail.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles', UserName='mauridev2015@gmail.com.test');
//runAs only in test methods. The original system context is started again after all runAs test methods complete.
//You can create new users with runAs even if your organization has no additional user licenses        
        System.runAs(u) {
            // The following code runs as user 'u'
            System.debug('Current User: ' + UserInfo.getUserName());
            System.debug('Current Profile: ' + UserInfo.getProfileId());
            String sObj = 'Account';
        	List<Object> ccstL = class01.checkClassSecurity(sObj);
        }
    }
    
    
    @isTest static void privateVoidClassTest(){
        // when a method is private, it is not visible to the test class. use the @TestVisible 
        // Example: @TestVisible private void privateVoidClass() { private void privateVoidClass() {
    	class01 c01 = new class01();
        c01.privateVoidClass();
    }
    
    @isTest static void exampleDeleteAccountTest() {
        class01Test c01 = new class01Test(); 
        Account act = c01.AccountTestData();
        List<Account> act1 = [select id from account where name = 'sForceTest1' limit 1];
        String result = class01.exampleDeleteAccount(act1[0]);
        system.assertEquals(result, 'ok');
    }
    
    public static testMethod void testSoslFixedResults() {
        Id [] fixedSearchResults= new Id[1];
        fixedSearchResults[0] = '001x0000003G89h';
        Test.setFixedSearchResults(fixedSearchResults);
        List<List<Object>> searchList = [FIND 'sForceTest1'
                                          IN ALL FIELDS RETURNING
                                          Account(id, name WHERE name = 'test' LIMIT
                                                  1)];
        system.debug('searchList ==> '+searchList);
        //sObject[] records = ((List<sObject>)searchList[0]);
        //system.debug('((List<sObject>)searchList[0]) ==> '+((List<sObject>)searchList[0]));
        //system.debug('records ==> '+records);
    }
    
    
   
//Test.loadData : you can populate data in your test methods without having to write many lines of code    
    private account AccountTestData() {    
        List<sObject> ls = Test.loadData(Account.sObjectType, 'AccountTestData'); //insert the Object + Static Resource (CSV file)
        // Verify that all 3 test accounts were created
        System.assert(ls.size() == 3);
        // Get first test account
        Account a1 = (Account)ls[0];
        String acctName = a1.Name;
        System.debug(acctName);
        return a1;
    }
        
}