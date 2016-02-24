@isTest
public class ip2geoWsRestTest {

    @isTest static void ip2geoTest() {
        Test.setMock(HttpCalloutMock.class, new ip2geoWsRestMock ()); 
        // check contentType, Header etc.
        string vURL = 'http://ws.cdyne.com/ip2geo/ip2geo.asmx/ResolveIP';
        HttpResponse response = ip2geoWsRest.doget(vURL);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/xml');
        
        Dom.Document doc = response.getBodyDocument();
        Dom.XMLNode address = doc.getRootElement();
        string vWalk = ip2geoWsRest.walkThrough(address);
        map<string,string> mXml = ip2geoWsRest.mXml;
        //system.debug('mXml ==> '+mXml);
        for (string mx: mXml.keySet()) {
            //system.debug('mx ==> '+mx);
            if (mx == 'AreaCode') {
				//system.debug('mXml.get(mx) ==> '+mXml.get(mx));
                system.assertEquals('650', mXml.get(mx));                
            }
        }
//{AreaCode=650, Certainty=90, City=Mountain View, Country=United States, CountryCode=US, HasDaylightSavings=false, Latitude=37.386, Longitude=-122.0838, StateProvince=CA}        
    }
}