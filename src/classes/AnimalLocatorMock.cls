@isTest
global class AnimalLocatorMock  implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/xml');
        response.setBody('{"animal":{"id":99,"name":"trailhead","eats":"burritos","says":"more badgers"}}');
        //String MockJson = '{"animals": ["pesky porcupine", "hungry hippo", "squeaky squirrel"]}';
        response.setStatusCode(200);
        return response; 
    }
}