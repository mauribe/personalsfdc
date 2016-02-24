@isTest
public class TestRestrictContactByName {

    @isTest static void TestContactwithinvalidname() {
	    account act = new account(name='TEST01');
            insert act;
        contact con = new contact(accountid=act.id, LastName = 'INVALIDNAME');        
        Test.startTest();
        Database.SaveResult result = Database.Insert(con, false);
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML',
                             result.getErrors()[0].getMessage());
        
    }
    
}