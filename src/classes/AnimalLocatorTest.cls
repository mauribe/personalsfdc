@isTest
public class AnimalLocatorTest {

    @isTest static void AnimalLocatorTest() {
     	Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock ()); 
        // check contentType, Header etc.
        HttpResponse response = AnimalLocator.makeGetCallout(99);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"animal":{"id":99,"name":"trailhead","eats":"burritos","says":"more badgers"}}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
        
        // asserEquals trailhead
        String vResp = AnimalLocator.getAnimalNameById(99);
        string vRespExpectedValue = 'trailhead';
        System.assertEquals(vResp, vRespExpectedValue);
    }
}