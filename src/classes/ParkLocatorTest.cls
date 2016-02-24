@isTest
private class ParkLocatorTest {
    @isTest static void testCallout() {              
        
        //Performing DML Before Mock Callouts: execute the DML and set test.starttest();
        //insert account ...
        //Test.startTest(); //Call Test.startTest before performing callout but after setting test data. At the end of class insert Test.stopTest();
        
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        // Call the method that invokes a callout
        String[] parkNames = ParkLocator.country('Japan');
        // Verify that a fake result is returned
        System.assertEquals(parkNames[0], 'Shinjuku'); 

        //system.assertEquals(expected, actual)

    }
}