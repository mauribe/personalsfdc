@isTest
public class UtilCustomLogTester {

    static testMethod void testUtilCustomLog(){
        UtilCustomLogCustomSet__c vCustomSetting = new UtilCustomLogCustomSet__c();
        vCustomSetting.Name = 'Default';
        vCustomSetting.Log_Level__c = 2;
        insert vCustomSetting;
        UtilCustomLog uc = new UtilCustomLog();
        
    }
        
    
}