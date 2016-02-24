@isTest
public class SharingRecalculationAccountChildTester {

    // Test for the JobSharingRecalc class
    static testMethod void testApexSharing(){
        // Insert Custom Setting for UtilCustomLog class
        UtilCustomLogCustomSet__c vCustomSetting = new UtilCustomLogCustomSet__c();
        vCustomSetting.Name = 'Default';
        vCustomSetting.Log_Level__c = 2;
        insert vCustomSetting;
        // Instantiate the class implementing the Database.Batchable interface.
        SharingRecalculationAccountChild recalc = new SharingRecalculationAccountChild();
        // Select users for the test.
        List<User> users = [SELECT Id FROM User WHERE IsActive = true LIMIT 1];
        ID User1Id = users[0].Id;
        
        // Insert some test job records.
        List<AccountChild__c> ltestAc = new List<AccountChild__c>();
        for (Integer i=0;i<5;i++) {
            AccountChild__c j = new AccountChild__c();
            j.Description__c = 'Test Job ' + i;
            j.sharewith__c = User1Id;
            ltestAc.add(j);
        }
        insert ltestAc;
        Test.startTest();
            String AcId = Database.executeBatch(recalc); // Invoke the Batch class.
        Test.stopTest();
            // Get the Apex job and verify there are no errors.
        AsyncApexJob aaj = [Select JobType, TotalJobItems, JobItemsProcessed, Status, CompletedDate, CreatedDate, NumberOfErrors from AsyncApexJob where Id = :AcId];
        System.assertEquals(0, aaj.NumberOfErrors);
        // This query returns jobs and related sharing records that were inserted
        // by the batch job's execute method.
        List<AccountChild__c> acs = [SELECT Id, sharewith__c,
        (SELECT Id, ParentId, UserOrGroupId, AccessLevel, RowCause FROM Shares
        WHERE RowCause = :Schema.AccountChild__Share.rowCause.ApexSharing__c)
        FROM AccountChild__c];
        // Validate that Apex managed sharing exists on jobs.
        for(AccountChild__c ac : acs){
            // One Apex managed sharing records should exist for each job when using the Private org-wide default.
            System.assert(ac.Shares.size() == 1);
            for(AccountChild__Share acShr : ac.Shares){ // Test the sharing record for the sharewith on AccountChild
                if(acShr.RowCause == Schema.AccountChild__Share.RowCause.ApexSharing__c){
                    System.assertEquals(acShr.UserOrGroupId,ac.sharewith__c);
                    System.assertEquals(acShr.AccessLevel,'Read');
                }
            }
        }
    }

}