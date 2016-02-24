@isTest
public class TestVerifyDate {

    @isTest static void TestVerifyDate_data2lessdate1() {
        Date data1 = date.newInstance(1983, 7, 15);
        Date data2 = date.newInstance(1983, 7, 14);        
            verifydate.CheckDates(data1, data2);
        System.assertEquals(date.newInstance(1983, 7, 14), data2);
    }
    @isTest static void TestVerifyDate_data2moredate1() {
        Date data1 = date.newInstance(1983, 7, 15);
        Date data2 = date.newInstance(1983, 7, 16);        
            verifydate.CheckDates(data1, data2);
        System.assertEquals(date.newInstance(1983, 7, 15), data1);
    }
    
}