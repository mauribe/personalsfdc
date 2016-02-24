public with sharing class AccountHandler {

	public static Account insertNewAccount (string vStr) {
		Account acnt = new Account();
		acnt.name = vStr;
		try {
				insert acnt;
				return acnt;
			} catch (DmlException e) {
    			System.debug('A DML exception has occurred: ' +
                e.getMessage());
				return null;
			}
	}

}