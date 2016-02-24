@RestResource(urlMapping='/class14/*')
global class Class14RestInbound {

//https://mauridev2015-dev-ed.my.salesforce.com/services/apexrest/class14/

    @HttpGet
    global static list<CustomLog__c> doGet() {
        //get the specified resource
        RestRequest req = RestContext.request;
		RestResponse res = RestContext.response;
        list<CustomLog__c> cl = [select id,description__c from customlog__c limit 2];
        system.debug('req ==> '+req);
        system.debug('req.headers ==> '+req.headers);
        return cl;
//14:43:26:106 USER_DEBUG [11]|DEBUG|req ==> RestRequest:[headers={Accept=application/json, Accept-Encoding=gzip, CipherSuite=AES256-GCM-SHA384 TLSv1.2 256-bits, Content-Type=application/json; charset=UTF-8, Host=mauridev2015-dev-ed.my.salesforce.com, User-Agent=Workbench/34.0.12, X-PrettyPrint=true, X-Salesforce-SIP=54.166.7.219}, httpMethod=GET, params={}, remoteAddress=54.166.7.219, requestBody=Blob[0], requestURI=/class14/, resourcePath=/services/apexrest/class14/*]        
    }
    
    @HttpPost
    global static Integer doPost(Class14c c14) {
        //creates a new resource
        system.debug('c14 ==> '+c14);
        RestRequest req = RestContext.request;
        system.debug('req.requestBody ==> '+req);
        return c14.vInt;
// JSON Request
//{
//"Class14c": {
//    "vInt" : 123
//}
//}
        
    }
    
    global class Class14c {
        global integer vInt;
        global string vTest;
        global boolean vBool;
    }
    
//@HttpDelete
@HttpDelete
    global static string doDelete (){
        //delete the specified resource
        string vStr;
        RestRequest req = RestContext.request;
        //system.debug(req.params);
        for (string rp: req.params.keyset()) {
			system.debug('rp ==> '+req.params.get(rp));            
        }
        string vId = req.params.get('id');
        system.debug('vId ==> '+vId );
        //{id=1234}
        
        return vId;
    }
    
@HttpPatch
    global static string doPatch(string vStr) {
        //updates the specified resource
        return vStr;
    }

@HttpPut
    global static string doPut(string vStr){
        //creates or updates the specified resource
        return vStr;
    }    
    
    
}