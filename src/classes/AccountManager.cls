@RestResource(urlMapping='/Accounts/0012400000RKhL7/contacts')
global with sharing class AccountManager {
    
    @HttpGet
    global static Account getAccount() {
        // workbench /services/apexrest/AccountManager/V1/0012400000RKhL7
        RestRequest request = RestContext.request;
        // grab the accountId from the end of the URL
        String vRequestURI = request.requestURI;
        List<String> accountId = vRequestURI.split('/');
        Account result =  [SELECT id, (select id, name from Contacts), name from Account where id = :accountid];
        return result;
    
    }
}