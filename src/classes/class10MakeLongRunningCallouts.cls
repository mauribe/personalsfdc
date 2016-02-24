public with sharing class class10MakeLongRunningCallouts {
    public String requestLabel;
    public String result {get;set;} // Result of callout
    private static final String LONG_RUNNING_SERVICE_URL = 'https://th-apex-http-callout.herokuapp.com/animals'; // Endpoint of long-running service
    // Action method
    public Object startRequest() {
        Continuation con = new Continuation(40); // Create continuation with a timeout
        con.continuationMethod='processResponse'; // Set callback method
        HttpRequest req = new HttpRequest(); // Create callout request
        req.setMethod('GET');
        req.setEndpoint(LONG_RUNNING_SERVICE_URL);
        this.requestLabel = con.addHttpRequest(req); // Add callout request to continuation
        return con; // Return the continuation
    }
    // Callback method
    public Object processResponse() {
        HttpResponse response = Continuation.getResponse(this.requestLabel); // Get the response by using the unique label
        this.result = response.getBody();// Set the result variable that is displayed on the Visualforce page
        return null;// Return null to re-render the original Visualforce page
    }
}