public class thecontroller {
    private String firstName;
    private String lastName;
    private String company;
    private String email;
    private String qp;
    private String vtest;
    public thecontroller() {
        this.qp = ApexPages.currentPage().getParameters().get('qp');
    }
    
    public thecontroller(ApexPages.StandardSetController controller) {
        
    }
    
    public String test {
    get {
    return test;
    }
    set {
    this.vtest = value;
    }
    }
    
    public String getFirstName() {
        return this.firstName;
    }
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    public String getLastName() {
        return this.lastName;
    }
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    public String getCompany() {
        return this.company;
    }
    public void setCompany(String company) {
        this.company = company;
    }
    public String getEmail() {
        return this.email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    
    public PageReference saveValitionRules (){
        contact l = new contact ( lastname = lastName, firstname = firstname);
        l.lastname.addError('test');
        //Map<String, Schema.SobjectField> fields  =contact.getSObjectType().getDescribe().fields.getMap();
                //fields.get('lastname').addError('error text');

        //contact.email.addError('Either email or phone must be defined');
        try {
        //insert l;    
        }
        catch (exception e) {
            //contact.lastname.addError('validation rules!!');
            //l.lastname.addError('test');
            return null;
        }
        return null;
    }
    
    public PageReference save() {
        PageReference p = null;
        if (this.qp == null || !'yyyy'.equals(this.qp)) {
            p = Page.failure;
            p.getParameters().put('error', 'noParam');
        } else {
            try {
                Lead newlead = new Lead(LastName=this.lastName,
                FirstName=this.firstName,
                Company=this.company,
                Email=this.email);
                insert newlead;
            } catch (Exception e) {
                
                ApexPages.addMessage(new
                ApexPages.Message(ApexPages.Severity.ERROR,
                'Errors on the form. Please correct and resubmit.'));
                return null;
                //p = Page.failure;
                //p.getParameters().put('error', 'noInsert');
            }
        }
        if (p == null) {
                p = Page.success;
        }
        p.setRedirect(true);
        return p;
    }
}