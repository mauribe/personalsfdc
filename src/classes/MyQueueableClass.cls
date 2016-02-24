/**
 * Invoke with: ID jobId = System.enqueueJob(new MyQueueableClass(N)); N should be an integer 
 */
public class MyQueueableClass implements Queueable,  Database.AllowsCallouts {
    Integer i;
    public MyQueueableClass(Integer i) {
        this.i = i;
    }

    public void execute(QueueableContext context) {
        // Send GET request to google
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://google.com');
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);

        System.debug(res.getBody());
        System.debug('i:'+i);

        if(i==0) {
            System.enqueueJob(new MyQueueableClass(i));
        }
    }
}