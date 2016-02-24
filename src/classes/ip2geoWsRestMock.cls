@isTest
global class ip2geoWsRestMock implements HttpCalloutMock {

    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        string vXml = '<IPInformation xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://ws.cdyne.com/"><City>Mountain View</City><StateProvince>CA</StateProvince><Country>United States</Country><Organization/><Latitude>37.386</Latitude><Longitude>-122.0838</Longitude><AreaCode>650</AreaCode><TimeZone/><HasDaylightSavings>false</HasDaylightSavings><Certainty>90</Certainty><RegionName/><CountryCode>US</CountryCode></IPInformation>';
        response.setHeader('Content-Type', 'application/xml');
        //response.setBody('{"animal":{"id":99,"name":"trailhead","eats":"burritos","says":"more badgers"}}');
        response.setBody(vXml);
        response.setStatusCode(200);
        return response; 
    }
}

//<IPInformation xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://ws.cdyne.com/">
//<City>Mountain View</City>
//<StateProvince>CA</StateProvince>
//<Country>United States</Country>
//<Organization/>
//<Latitude>37.386</Latitude>
//<Longitude>-122.0838</Longitude>
//<AreaCode>650</AreaCode>
//<TimeZone/>
//<HasDaylightSavings>false</HasDaylightSavings>
//<Certainty>90</Certainty>
//<RegionName/>
//<CountryCode>US</CountryCode>
//</IPInformation>