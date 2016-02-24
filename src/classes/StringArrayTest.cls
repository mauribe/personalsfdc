public with sharing class StringArrayTest {
	
	public static List<String> generateStringArray (integer vInt) {
		system.debug('DEBUG vInt '+vInt);
		List<String> vStr = new List<String>();

			// Iterate over a list to read elements
			for(Integer i=0;i<vInt;i++) {
			    // Write value to the debug log
			    vStr.add('Test '+i);
			    System.debug('vStr '+i);
			}
		System.debug(vStr);
		return vStr;
	}

}