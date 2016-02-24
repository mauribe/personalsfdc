public class AnimalLocator {

    public static String getAnimalNameById(Integer vIdAnimal) {
        string vJsonName;
    	//{"animals":["majestic badger","fluffy bunny","scary bear","chicken"]}
    	HttpResponse response = makeGetCallout(vIdAnimal);
        //response.getBody() = {"animal":{"id":1,"name":"chicken","eats":"chicken food","says":"cluck cluck"}}
		if (response.getStatusCode() == 200) {
            //Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            //resp is a JSON string
            JSONParser parser = JSON.createParser(response.getbody());
            while (parser.nextToken() != null) {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
                    String fieldName = parser.getText();
                    parser.nextToken();
                    if(fieldName == 'name') {
                        vJsonName = parser.getText();
                    } 
            	}
            }
        }
    	return vJsonName;
    }

    public static HttpResponse makeGetCallout(Integer vIdAnimal) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+vIdAnimal);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        return response;
    }
}