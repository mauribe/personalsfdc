global class Class11WSInbound {
    
    //global class propertyInput {
    //    string lastName;
    //    id AccountId;
    //}
    
   //webService static Id makeContact(propertyInput propIn) { 
   webService static Id makeContact(string lastName, id AccountId) { 
        Contact c = new Contact(LastName = lastName, AccountId = accountId); 
        insert c;
        System.debug(LoggingLevel.Info, 'Created ' + c.Id + ' for ' + accountId);
         
        system.debug('tmpcheck');
        list<utilcustomlog.scustomlog> lcl = new list<utilcustomlog.scustomlog>();
        lcl.add(new utilcustomlog.scustomlog('apex','description', null,'getid','Ok','geststatuscode','NoCategory'));
        utilcustomlog.writelog(lcl);
        return c.id;
    }
    
    private void tmpcheck() {
        system.debug('tmpcheck');
        list<utilcustomlog.scustomlog> lcl = new list<utilcustomlog.scustomlog>();
        lcl.add(new utilcustomlog.scustomlog('apex','description', null,'getid','Ok','geststatuscode','NoCategory'));
        utilcustomlog.writelog(lcl);  
    }
    
    
    
    
    
    
    
    
    /* LOGIN()
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:enterprise.soap.sforce.com">
        <soapenv:Header>
        <urn:LoginScopeHeader>
        </urn:LoginScopeHeader>
        </soapenv:Header>
        <soapenv:Body>
        <urn:login>
        <urn:username>USERNAME</urn:username>
        <urn:password>PASSWORD+TOKEN</urn:password>
        </urn:login>
        </soapenv:Body>
        </soapenv:Envelope>

    /* SOAP REQUEST
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:clas="http://soap.sforce.com/schemas/class/Class11WSInbound">
        <soapenv:Header>
        <clas:SessionHeader>
        <clas:sessionId>00D24000000jW9H!AQQAQITa1ZgfWHGNRgLdSElZGYQ5lOweQKm1e4dntDIwUXT3xPr9vW_2m633ZqimbxwH64AeZmqpFwyl9bhVJpmMXymgb_Pd</clas:sessionId>
        </clas:SessionHeader>
        </soapenv:Header>
        <soapenv:Body>
        <clas:makeContact>
        <clas:lastName>TEST123</clas:lastName>
        <clas:accountId>0012400000RKhL7</clas:accountId>
        </clas:makeContact>
        </soapenv:Body>
        </soapenv:Envelope>
    */
    
}