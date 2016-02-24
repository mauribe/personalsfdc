public class DisplayCaseController {

    @AuraEnabled
    public static Case getCaseFromId(Id caseID) {
        if(caseID == null) {
            system.debug('caseID '+ caseID);
            return [SELECT ID, Subject, Description, Status from Case where id = '500240000058fTNAAY'];
        }
        List<Case> cases = [ SELECT Id, Subject, Description, Status from CASE where ID = :caseID ];        
		system.debug('cases int '+ cases);
        if(cases.size() == 0) {
        	system.debug('cases 0 '+ cases);
            return [SELECT ID, Subject, Description, Status from Case LIMIT 1];
        } else {
            system.debug('cases '+ cases);
            return cases[0];
            
        }        
    }
    
    
}