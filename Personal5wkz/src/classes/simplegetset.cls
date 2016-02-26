public class simplegetset { 
public List<Account> account { get; private set; }

    public simplegetset(ApexPages.StandardSetController controller) {
        //this.sObjContact = (account)controller.getrecord();
        this.account = (List<account>)[select id, name, industry from account];
        system.debug('Constructor => '+account);
        
    }

    public PageReference save() {
        system.debug('account => '+account);
        update account;
        return null;
    }


}