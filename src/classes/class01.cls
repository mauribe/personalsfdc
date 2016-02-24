global virtual with sharing class class01 implements Iterator<Account> {
// OuterClass.cls --> showing all the features of Apex classes
//////// Apex Class Definition //
// PRIVATE access modifier declares that this class is only known locally ==> doesn't work CodeDeveloper01 cd = new CodeDeveloper01(); cd.privateVoidClass();
// PUBLIC access modifier declares that this class is visible in your application or namespace
// GLOBAL access modifier declares that this class is known by all Apex code everywhere
// With Sharing | without sharing
// VIRTUAL this class allows extension and overrides. You cannot override a method with the override keyword unless the class has been defined as virtual
// WITH SHARING: to enforce the sharing rules that apply to the current user
// WITHOUT SHARING: to ensure that the sharing rules for the current user are not enforced
// ////// SEQUENCE OF EXECUTION WITHIN A CLASS
// 1) Initialization Code
// 2) Static Variable or Method
// 3) Constructors
// ...

// Naming Convention: classes start with a capital letter, methods start with a lowercase verb, and variable names should be meaningfu
    
// ////// Variables //////
/*	
////// SET /////// 
  A set is a collection of unique, unordered elements. Ex. used to store collections of IDs that you want to use in a SOQL query
Set<String> s = new Set<String>{'Jon', 'Quinton', 'Reid'};

add(setElement), clear(), clone(), isempty(), remove(setElement), size(), contains(setElement)
https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_set.htm

////// LIST //////
A list is an ordered collection of elements that are distinguished by their indices. A List is a collection of primitives, user-defined objects, sObjects, Apex objects or other collections (can be multidimensional up to 5 levels). Use a List (as opposed to a Set) when the sequence of elements is important. You can also have duplicate elements in a List. List are zero-based so the first element in the List is always 0.
List<String> s = new List<String>{'Jon', 'Quinton', 'Reid'};
Arrays is similar to List but is not multidimensional
String[] s1 = new String[]{'Jon', 'Quinton', 'Reid'};

add(listElement), add(index, listElement), clear(), get(index), isEmpty(), remove(index), set(index, listElement), sort(), size()
https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_list.htm

////// MAP //////
A Map is a collection of key-value pairs. Keys can be any primitive data type while values can include primitives, Apex objects, sObjects and other collections. Use a map when you want to quickly find something by a key. Each key must be unique but you can have duplicate values in your Map.
Map<Integer, String> m = new Map<Integer, String>{5 => 'Jon', 6 => 'Quinton', 1 => 'Reid'};  
Map<ID, Set<String>> m = new Map<D, Set<String>>();  
// creates a map where the key is the ID of the record
Map<Id,Account> aMap = new Map<Id, Account>([Select Id, Name From Account LIMIT 2]);  
for (Id id : Trigger.newMap.keySet()) { if (Trigger.oldMap.get(id).LastName != Trigger.newMap.get(id).LastName)}

containsKey(key), get(key), isEmpty(), keySet(), put(key, value), 
https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_map.htm

///// Enums //////
//An enum is an abstract data type with values that each take on exactly one of a finite set of identifiers that you specify
public enum Season {WINTER, SPRING, SUMMER, FALL}
    public static void checkEnumVar() {
        Season e = Season.WINTER;
        system.debug(e);
    }
    Season m(Integer x, Season e) {
        if (e == Season.SUMMER){
            system.debug(e);        }
            return e;
        }
*/
    
// ////// Instance Methods and Variables //////
//     
    class RGB {
        Integer red;
		Integer green;
		Integer blue;
		
        RGB(Integer red, Integer green, Integer blue) {
		this.red = red; //with the dot (.) indicate this instance
		this.green = green;
		this.blue = blue; 
		}
        RGB(){
            this(4,5,6); //without the dot (.) indicate the previous instance with the input paramenters
        }
    }
    
    public boolean CheckInstanceMethod(Integer red, Integer green, Integer blue){
        boolean CIMResult = false;
        map<integer, RGB> CIMap = new map<integer, RGB>();
        CIMap.put(1,new RGB(1,2,3));
        CIMap.put(2,new RGB()); //invoke the RGB with 4,5,6 like property input
        system.debug('CheckInstanceMethod '+CIMap); // USER_DEBUG [83]|DEBUG|CheckInstanceMethod {1=RGB:[blue=3, green=2, red=1], 2=RGB:[blue=6, green=5, red=4]}
        if (CIMap.size()>0) CIMResult = true;
        return CIMResult;
        
    }
    
// //////// //////// //////// //////// //////// //////// //////    
    
    
// ////// Class Variables //////
// [public | private | protected | global] [final] [static] data_type variable_name [= value]

    Static Map<String, RGB> colorMap = new Map<String, RGB>();
    private static integer i = 0;
    private static List<Account> accs = new List<Account>([SELECT Id, Name FROM Account limit 10]);    
// FINAL: variables can only be assigned a value once. You cannot use the final keyword in the declaration of a class or method. Use the virtual keyword if you need to override a method or class
    private static final String vStaticFinalString = 'vStaticFinalString';
    
    // TRANSIENT declare instance variables that can't be saved, and shouldn't be transmitted as part of the view state for a Visualforce page. check VF called Visualforce01
    DateTime t1;
	transient DateTime t2;
    
// ////// Initialization Code /////// 
    static {
        // The instance initialization code in a class is executed each time an object is instantiated from that class. These code blocks run before the constructor.   
        system.debug('Initialization Code');
        
        //If you need to verify at run time whether an object is actually an instance of a particular class
        if (accs instanceof list<Account> ) { system.debug('accs is an instance of Account!');}
    }
    
// ////// Using Constructors //////
// The syntax for a constructor is similar to a method, but never has an explicit return type and it is not inherited by the object created from it.
    global class01(String vStr){
        //CodeDeveloper01 cd = new CodeDeveloper01(); ==> this code is executed every time you instantiate the class
		system.debug('Constructor 01');  
        // Private class is not called outside the class because is private but is called inside the class like in the Constructor
        privateVoidClass();
        // FUTURE METHOD line 251. The operation is a FutureHandler and execute first the 'Initialization Code' and after this method:
        futureMethod('INPUT',999);
        
    }
    global class01(){
        //A constructor can be overloaded, more than one constructor for a class, each having different parameters.
        
        //THIS in dot notation, without parenthesis, to represent the current instance of the class in which it appears
        //THIS to do constructor chaining, that is, in one constructor, call another constructor. In this format, use the this keyword with parentheses 
        this('TEST'); //call the Constructor 01 and execute the 02 after
        system.debug('Constructors 02'); 
    }    
    
// ////// Class Methods //////
// [public | private | protected | global] [override] [static] data_type method_name (input parameters)
// PRIVATE the method or variable is accessible only within the Apex class in which it is defined
// PROTECTED visible to any inner classes in the defining Apex class, and to the classes that extend the defining Apex class
// PUBLIC can be used by any Apex in this application or namespace
// GLOBAL can be used by any Apex code that has access to the class,
  
    @TestVisible private void privateVoidClass() {
        system.debug('privateVoidClass');
    }
    public String publicStringClass(){
        //CodeDeveloper01 cd = new CodeDeveloper01(); cd.privateVoidClass();
        system.debug('publicStringClass');
        String vReturn = 'test';
        return vReturn;
    }
// ////// Static Methods and Variables //////
// only with outer classes. Inner classes have no static methods or variables. A static method or variable doesn’t require an instance of the class in order to run
// A static method is used as a utility method, and it never depends on the value of an instance member variable
    public static string myStaticVariable = 'FALSE';
    
    public static String publicStaticStringClass(){
        //CodeDeveloper01.publicStaticStringClass();
        system.debug('publicStringClass');
        String vReturn = 'test';
        return vReturn;
    }

	//Example: Passing Primitive Data Type Arguments
	//    
    public static void debugStatusMessage() {
        String msg = 'Original value';
        processString(msg);
        // The value of the msg variable didn't
        // change; it is still the old value.
        System.assertEquals(msg, 'Original value');
    }
    public static void processString(String s) {
        s = 'Modified value';
    }
    
	//Example: Passing Non-Primitive Data Type Arguments
	//
    public static void createTemperatureHistory() {
        List<Integer> fillMe = new List<Integer>();
        reference(fillMe);
        // The list is modified and contains five items as expected.
        System.assertEquals(fillMe.size(),5);
        List<Integer> createMe = new List<Integer>();
        referenceNew(createMe);
        // The list is not modified because it still points to the original list, not the new list that the method created.
        System.assertEquals(createMe.size(),0);
    }
    public static void reference(List<Integer> m) {
        // Add rounded temperatures for the last five days.
        m.add(70);
        m.add(68);
        m.add(75);
        m.add(80);
        m.add(82);
    }
    public static void referenceNew(List<Integer> m) {
        // Assign argument to a new List of five temperature values.
        m = new List<Integer>{55, 59, 62, 60, 63};
    }

// ////// Instance Methods and Variables //////
    public void classRGB (){
		colorMap.put('red', new RGB(255, 0, 0));
        system.debug('colorMap '+colorMap);
        RGB rg = new RGB(255,255,255);
        system.debug('RG '+rg);
    }
    
// ////// Apex Properties //////
// An Apex property is similar to a variable, however, you can do additional things in your code to a property value before it is accessed or returned
// two code blocks, representing a get accessor and a set accessor
// access_modifier return_type property_name { get{} set{}}
// class01 c = new class01(); c.ApexProperties = 5; system.debug('c.ApexProperties '+c.ApexProperties);
    public integer ApexProperties {
        get { return ApexProperties; }
        set { ApexProperties = value; }
    } 
// Automatic Properties. you can leave get and set accessor code blocks empty    	
    public integer MyReadOnlyProp { get; }
    public double MyReadWriteProp { get; set; }
    public string MyWriteOnlyProp { set; }

    public static integer StaticMember;
    public integer NonStaticMember;
    public static integer MyGoodStaticProp {
    	get{return MyGoodStaticProp;}
    }
    // The following produces a system error
    // public static integer MyBadStaticProp { return NonStaticMember; }
    public integer MyGoodNonStaticProp {
	    get{return NonStaticMember;}
    }
    public static integer MyGoodStaticMember {
        get{return StaticMember;}
    }
    
// ////// Extending a Class //////    
// A class that extends another class inherits all the methods and properties of the extended class.
// the extending class can override the existing virtual methods by using the override keyword in the method definition. This is referred to as polymorphism
// class02extends c02 = new class02extends(); c02.class01Extends();
    public virtual void class01Extends() {
    	System.debug('executed the class01 -> call class01extends');
        // public override void class01Extends() {}
        // The super keyword can be used by classes that are extended from virtual or abstract classes ???????????
    }    
    
// ////// Interfaces //////
// An interface is like a class in which none of the methods have been implemented—the method signatures are there, but the body of each method is empty
    public Double class01Interface() {
        //Anonymous script: class01 cl = new class01(); double PurchaseResult = cl.class01Interface(); system.debug('PurchaseResult: '+PurchaseResult);
		Purchase pt = new Purchase(new CustomerPurchaseOrder());
		Double PurchaseResult = pt.discount(1);  
        return PurchaseResult;
    }    
    
// ////// Custom Iterators //////
// while (count < 11) { System.debug(count); count++;}
// hasNext ==> Returns Boolean : true if there is another item in the collection being traversed, false otherwise
// Next ==> Returns Any Type: the next item in the collection.
// class01 x = new class01(); while(x.hasNext()){ x.next(); } 
    global boolean hasNext(){
        if(i >= accs.size()) {
            system.debug('hasNext false '+i);
            return false;
            } else { system.debug('hasNext true '+i); return true;}
    }
    global Account next(){
        system.debug('next '+i);
        i++;
        return accs[i-1];
    }
// ////// TRANSIENT //////
// the transient date to be updated because it is being recreated each time the page is refreshed. The non-transient date continues 
// to have its original value, which has been deserialized from the view state, so it remains the same
    public String getT1() {
        if (t1 == null) t1 = System.now();
        return '' + t1;
    }
    public String getT2() {
        if (t2 == null) t2 = System.now();
        return '' + t2;
    }
    
// ////// ANNOTATIONS //////
// @AuraEnabled -- annotation enables client- and server-side access to an Apex controller method
// @deprecated -- for managed package
@future
    //asynchronous action. (callout=true) to allow callouts. parameters primitive data types, arrays of primitive data types. No sObjects or objects as arguments
    private static void futureMethod(String futureA, Integer futureI) {
    	System.debug('Method called with: ' + futureA + ' and ' + futureI);
    	// Perform long-running code
    }
// @Invocable , @InvocableVariable
// @isTest to define classes and methods that only contain code used for testing your application. (SeeAllData=true), (OnInstall=true)
// @ReadOnly just for Schedulable interface and Web Services
// @RemoteAction support for Apex methods used in Visualforce to be called via JavaScript
@RemoteAction
    public static String RemoteActionMethod(String vRemoteActionMethod){
        system.debug('RemoteActionMethod '+vRemoteActionMethod);
        return vRemoteActionMethod;
    }
//@testSetup static void methodName() {} Records that are created in a test setup method are available to all test methods in the test class and are rolled back at the end of test class execution   
//@TestVisible allow test methods to access private or protected members of another class outside the test class        

// ////// Apex REST Annotations ////// look at the classes called AccountManager, CaseManager, MyOwnTypeRestResource
//@RestResource Annotation
//@HttpDelete Annotation
//@HttpGet Annotation
//@HttpPatch Annotation
//@HttpPost Annotation
//@HttpPut Annotation

//CASTING a data type of one class can be assigned to a data type of another class, but only if one class is a child of the other class you want to convert an object from one data type to another
    Public class CastingMethod extends Class01 {
        Class01[] c01 = new Class01[5];
        CastingMethod CM = new CastingMethod();
        //c01.add(CM);
        //CastingMethod cm1 = (CastingMethod) Class01.get(0);
        //Collections can be cast in a similar manner that arrays can be cast in Java
        list<Class01> lc01 = new list<Class01>();
        list<CastingMethod> lCM = new list<CastingMethod>();
        //lc01 = lCM;
    }

//  NAMESPACE
    public static void checkNamespace () {
        // The System namespace is the default namespace in Apex ex. http://na1.salesforce.com
        system.debug ('System.URL.getCurrentRequestUrl'+ System.URL.getCurrentRequestUrl());
        // Apex looks up the query method on the custom class first so you should have Database custom class and System.Database standard
        
        //Schema Namespace
        DescribeSObjectResult d = Account.sObjectType.getDescribe();
		Map<String, FieldSet> FSMap = d.fieldSets.getMap();
        Map<String, FieldSet> FSMap2 = d.fieldSets.getMap();
        system.debug('equals: '+FSMAP.equals(FSMAP2));
        string t300 = 'c';
        string t301 = 'c';
        system.debug('equalsIgnoreCase: '+t300.equalsIgnoreCase(t301));
    }

// ////// Working with Data in Apex //////
// sObject Types: refers to any object that can be stored in the Force.com platform database and represents a row of data.

    public static void workingWithData () {
        Account sAcct = new Account(name = 'Acme', billingcity = 'San Francisco');
        // Custom labels are not standard sObjects. You can only access the value. Create a Custom Label in Setup menu
        String errorMsg = System.Label.Generic_Error;

    }
// Accessing sObject Fields. If you use the generic sObject type instead of a specific object, such as Account, you can retrieve only the Id field using dot notation    
    public static void workingWithDataConvertType() {
        List<Contact> wwdctContacts = new List<Contact>();
        List<Lead> wwdctLeads = new List<Lead>();
        List<Account> wwdctAccounts = new List<Account>();
        List<List<sObject>> results = [FIND '4155557000'
                                       IN Phone FIELDS
                                       RETURNING Contact(Id, Phone, FirstName, LastName),
                                       Lead(Id, Phone, FirstName, LastName), Account(Id, Phone, Name)];
        sObject[] records = ((List<sObject>)results[0]);
        system.debug('((List<sObject>)results[0]) ==> '+((List<sObject>)results[0]));
        if (!records.isEmpty()) {
            for (Integer convertTypeI = 0; convertTypeI < records.size(); convertTypeI++) {
                sObject record = records[convertTypeI];
                system.debug('record ==> '+record);
                if (record.getSObjectType() == Contact.sObjectType) {
                    wwdctContacts.add((Contact) record);
                    wwdctContacts.add(new Contact(FirstName='First', LastName='Last'));
                } else if (record.getSObjectType() == Lead.sObjectType){
                    wwdctLeads.add((Lead) record);
                } else if (record.getSObjectType() == Account.sObjectType) {
                    wwdctAccounts.add((Account) record);
                }
            }
        }
    }
        
    public static void workingWithDataAddingRecord() {    
        List<Id> wwdarListId = new List<Id>();
        Account wwdar01 = new Account(Name='Account Example');
        insert wwdar01;
        Account wwdar02 = [SELECT Name,Industry
                     FROM Account
                     WHERE Name='Account Example' LIMIT 1];
        wwdar02.Name = 'Account of the Day';
        update wwdar02;
        delete wwdar02;
        //DML Statements vs. Database Class Methods
        //Statements : if you want any error that occurs during bulk DML processing to be thrown as an Apex exception that immediately interrupts control flow (by using try. . .catch blocks).
        //Database : if you want to allow partial success of a bulk DML operation—if a record fails, the remainder of the DML operation can still succeed.
        //DML Operations As Atomic Transactions: all changes are committed to the database only after all operations in the transaction finish executing and don’t cause any errors
        List<Account> acctList = new List<Account>();
        acctList.add(new Account(Name='Acme1'));
        acctList.add(new Account(Industry='xxx'));
        // DML statement
        Database.SaveResult[] srList = Database.insert(acctList, false);
// ////// UtilCustomLog: Custom Util class created to save the record into a log customboject --> Database.SaveResult and DML Options
        UtilCustomLog uc = new UtilCustomLog();
        //list<CustomLog__c> lcl = new List<CustomLog__c>();
        list<utilcustomlog.scustomlog> lcl = new list<utilcustomlog.scustomlog>();
        
        // Iterate through each returned result
        for (Database.SaveResult sr : srList) {
            if (sr.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted account. Account ID: ' + sr.getId());
                wwdarListId.add(sr.getId());
                //lcl.add(new customlog__c(Apex_Class__c='workingWithDataAddingRecord', Description__c='Operation was successful', Record_ID__c=sr.getId()));
                lcl.add(new utilcustomlog.scustomlog('workingWithDataAddingRecord','Operation was successful', null,sr.getId(),null,null,'NoCategory'));
            }
            else {
                // Operation failed, so get all errors
                for(Database.Error err : sr.getErrors()) {
                    System.debug('The following error has occurred.');
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Account fields that affected this error: ' + err.getFields());
                    //lcl.add(new customlog__c(Apex_Class__c='workingWithDataAddingRecord', Description__c='Error: '+ err.getStatusCode() + ': ' + err.getMessage() + ' Account fields that affected this error: ' + err.getFields(), Record_ID__c=sr.getId()));
                    lcl.add(new utilcustomlog.scustomlog('workingWithDataAddingRecord','Error: '+ err.getStatusCode() + ': ' + err.getMessage() + ' Account fields that affected this error: ' + err.getFields(), null,sr.getId(),null,null,'NoCategory'));
                }
            }
        }
        utilcustomlog.WriteLog(lcl);
        List<Account> wwdaracctList = Database.query('select id from account where id = :wwdarListId');
        delete wwdaracctList; //delete all the accounts created
        //Bulk DML Operations. 10,000 rows that can be processed by DML operations in a single transaction. DML limit of 150 statements per Apex transaction
        List<Account> wwdarUpdatedList = new List<Account>();
        List<ACcount> wwdarList = new List<Account>([select id, Active__c from account limit 2]);
        for(Account con : wwdarList) {
            if (con.Active__c == 'Yes') {
                wwdarUpdatedList.add(con); // Add updated contact sObject to the list.
                }
            }
        update wwdarUpdatedList; // Call update on the list of contacts. This results in one DML call for the entire list.
    }

// Creating Parent and Child Records in a Single Statement Using Foreign Keys. withouth retry ID of the parent to insert the child. 
// You can create related records that are up to 10 levels deep    
    public static void workingWithDataAddingMultipleRecord() {
        List<Id> wwdamrId = new List<Id>();
        Date dt = Date.today();
        dt = dt.addDays(7);
        Opportunity newOpportunity = new Opportunity(Name='OpportunityWithAccountInsert', StageName='Prospecting', CloseDate=dt);
        // Create the parent reference. Used only for foreign key reference and doesn't contain any other fields.
        Account accountReference = new Account(MyExtID__c='SAP111111');
        newOpportunity.Account = accountReference;
        // Create the Account object to insert. Same as above but has Name field. Used for the insert.
        Account parentAccount = new Account(Name='Hallie',MyExtID__c='SAP111111');
        // Create the account and the opportunity.
        Database.SaveResult[] results = Database.insert(new SObject[] { parentAccount, newOpportunity });
        // Check results.
        for (Integer wwdamrI = 0; wwdamrI < results.size(); wwdamrI++) {
            if (results[wwdamrI].isSuccess()) {
                wwdamrId.add(results[wwdamrI].getId());
                System.debug('Successfully created ID: ' + results[wwdamrI].getId());
                } else {
                    //Returned Database Errors
                    for(Database.Error err : results[wwdamrI].getErrors()) {
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
						System.debug('Fields that affected this error: ' + err.getFields());
                        System.debug('Error: could not create sobject for array element ' + wwdamrI + '.');
                		System.debug('The error reported was: ' + results[wwdamrI].getErrors()[0].getMessage() + '\n');
                    }
                
            }
        }
        List<Account> wwdamrList = Database.query('select id from account where id = :wwdamrId');
        delete wwdamrList; //delete all the accounts created
    }
// MERGE Only leads, contacts, and accounts can be merged
// DELETE Deleted records aren’t deleted permanently from Force.com, but they are placed in the Recycle Bin for 15 days. 
// Use ALL ROWS keywords to query all records in an organization, including deleted records and archived activities

    public static void workingWithDataAddingDelete() {
        Account a = new Account(Name='Trump');
        insert(a);
        delete(a);
        Account[] savedAccts = [SELECT Id, Name FROM Account WHERE Name = 'Trump' ALL ROWS];
        try {
            undelete savedAccts;
            } catch (DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage()); // Process exception here
        }
// ////// Setting DML Options //////
// 1) allowFieldTruncation: If true, the property truncates String values that are too long
// Database.DMLOptions dml = new Database.DMLOptions(); dml.allowFieldTruncation = true;
// 2) assignmentRuleHeader: specifies the assignment rule to be used when creating a case or lead
        Database.DMLOptions wwdaddmo = new Database.DMLOptions();
        wwdaddmo.assignmentRuleHeader.useDefaultRule= true; //wwdaddmo.assignmentRuleHeader.assignmentRuleId= '01QD0000000EqAn';
        Lead l = new Lead(company='ABC', lastname='Smith');
        l.setOptions(wwdaddmo);
        insert l;
// 3) dupicateRuleHeader: are part of the Duplicate Management feature. see 'DuplicateError Class'     
        Database.DMLOptions wwdaddml = new Database.DMLOptions();
        wwdaddml.DuplicateRuleHeader.AllowSave = true;
        Account duplicateAccount = new Account(Name='dupe');
        Database.SaveResult wwdaddmlsr = Database.insert(duplicateAccount, wwdaddml);
        if (wwdaddmlsr.isSuccess()) {
        System.debug('Duplicate account has been inserted in Salesforce!');
        }
// 4) emailHeader: specify whether or not to send an email when the following events occur, Creation of a new case or task, Lead queue email notification etc.
// Database.DMLOptions dlo = new Database.DMLOptions(); dlo.EmailHeader.triggerAutoResponseEmail = true;        
// 5) localeOptions: language of any labels that are returned by Apex de_DE or en_GB
// 6) optAllOrNone: specifies whether the operation allows for partial success. The default for this property is false and successfully processed records are committed while records with errors aren't    
    }
// LEAD CONVERT: Database.LeadConvert lc = new database.LeadConvert(); lc.setLeadId(myLead.id);

// Transaction Control: your business rules require that partial work be “rolled back” so that the processing can continue in another direction    
    public static void workingWithDataTransactionControl() {
        Account wwdtca = new Account(Name = 'xxx'); insert wwdtca;
        System.assertEquals(null, [SELECT AccountNumber FROM Account WHERE Id = :wwdtca.Id].AccountNumber);
        // Create a savepoint while AccountNumber is null
        Savepoint wwdtcsp = Database.setSavepoint();
        // Change the account number
        wwdtca.AccountNumber = '123'; update wwdtca;
        System.assertEquals('123', [SELECT AccountNumber FROM Account WHERE Id = :wwdtca.Id].AccountNumber);
        // Rollback to the previous null value
        Database.rollback(wwdtcsp);
        System.assertEquals(null, [SELECT AccountNumber FROM Account WHERE Id = :wwdtca.Id].AccountNumber);
// Locking Statements: Apex allows you to lock sObject records while they’re being updated in order to prevent race conditions and other thread safety problems
        for (Account[] wwdtcaccts : [SELECT Id FROM Account limit 1 FOR UPDATE]) {
            system.debug('LOCK ON RECORD!');
        }
    }
// Working with SOQL and SOSL Query Results
    public static void workingWithDataQueryResults() {
        insert new Account(Name = 'Singha');
        integer wwdtqrint = 1;
        //Using Apex Variables in SOQL and SOSL Queries. The use of a local code variable (:) within a SOQL or SOSL statement is called a bind
        Account wwdtqracc = [SELECT Id FROM Account WHERE Name = 'Singha' LIMIT :wwdtqrint];
        // Even if only one sObject field is selected, a SOQL or SOSL query always returns data as complete records
        String wwdtqrname = [SELECT Id, Name FROM Account WHERE Name = 'Singha' LIMIT 1].Name;
        //Double rev = [SELECT AnnualRevenue FROM Account WHERE Name = 'Acme'][0].AnnualRevenue;
        // this is the only situation you don't need to specify the field
        Integer wwdtqrcount = [SELECT COUNT() FROM Account];
// SOQL for loops iterate over all of the sObject records returned by a SOQL query.
		Savepoint wwdtqrsp = Database.setSavepoint();
        insert new Account[] {
            new Account(Name='yyy'),
            new Account(Name='yyy'),
            new Account(Name='yyy')};
		Integer wwdtqri = 0;
        for (Account tmp : [SELECT Id FROM Account WHERE Name = 'yyy']) {wwdtqri++;}
        System.assert(wwdtqri == 3); // Since there were three accounts named 'yyy' in the database, the loop executed three times
        wwdtqri = 0; Integer wwdtqrj;
		for (Account[] tmp : [SELECT Id FROM Account WHERE Name = 'yyy']) { wwdtqrj = tmp.size(); wwdtqri++;}
        System.assert(wwdtqrj == 3); // The list should have contained the three accounts named 'yyy'
		System.assert(wwdtqri == 1); // Since a single batch can hold up to 200 records and, only three records should have been returned, the loop should have executed only once Revert the database to the original state
		Database.rollback(wwdtqrsp);
    }

    public static void workingWithDataExpandingsObject(){
        Map<ID, Account> wwdesm = new Map<ID, Account>([SELECT Id, Name FROM Account LIMIT 10]);
        // After populating the map, iterate through the map entries
        for (ID wwdesidKey : wwdesm.keyset()) { Account wwdesa = wwdesm.get(wwdesidKey); System.debug(wwdesa);}
    }

    public static void checkDynamicApex(){
//Describing sObjects Using Tokens. For example, use the token version of an sObject or field when you are determining the type of an sObject or field that your code needs to use
        
        // Create a new account as the generic type sObject
		sObject s = new Account();
        // Verify that the generic sObject is an Account sObject
		System.assert(s.getsObjectType() == Account.sObjectType);
        // Get the sObject describe result for the Account object
		Schema.DescribeSObjectResult dsr = Account.sObjectType.getDescribe();
        system.debug('dsr ==> '+dsr); //ex. getKeyPrefix=001;getLabel=Account;getLabelPlural=Accounts;getName=Account;
		system.debug('dsr.getLabel ==> '+dsr.getLabel()); // get just Account
        // Get the field describe result for the Name field on the Account object
		Schema.DescribeFieldResult dfr = Schema.sObjectType.Account.fields.Name;
        system.debug('dfr ==> '+dfr); //ex. getLabel=Account Name;getLength=255;getLocalName=Name;getType=STRING;isAccessible=true
        // Verify that the field token is the token for the Name field on an Account object
        System.assert(dfr.getSObjectField() == Account.Name);
        system.debug('dfr.getSObjectField() ==> '+dfr.getSObjectField());
        // Get the field describe result from the token
        dfr = dfr.getSObjectField().getDescribe();
        system.debug('dfr ==> '+dfr); //ex. getLabel=Account Name;getLength=255;getLocalName=Name;getType=STRING;isAccessible=true
// SObjects: act as static classes with special static methods and member variables for accessing token and describe result information        
		Schema.sObjectType t = Account.sObjectType; //To access the token for an sObject
        Schema.DescribeSObjectResult dsr1 = Account.sObjectType.getDescribe(); //To access the describe result for an sObject,
		Schema.SObjectField fieldToken = Account.Description; //To access the token for a field
        system.debug('fieldToken ==> '+fieldToken);
        Schema.DescribeFieldResult dfr1 = Schema.sObjectType.Account.fields.Name; // Get the describe result for the Name field on the Account object
        dfr1 = dfr1.getSObjectField().getDescribe(); // Get the describe result from the token
        system.debug ('dfr1 ==> '+dfr1);
        Schema.DescribeFieldResult dfr2 = Account.Description.getDescribe(); //To access the describe result for a field
        system.debug('dfr2 ==> '+dfr2);
//Accessing All Field Describe Results for an sObject
        Map<String, Schema.SObjectField> fieldMap = Schema.SObjectType.Account.fields.getMap();
            for (String fieldm1: fieldMap.keySet()) {
                system.debug('fieldm1 ==> '+fieldm1); //list all the fields of a object Account
            }
        }

	public static void checkFieldMetaData (){
        Set<String> fields = new Set<String>{'name','annualrevenue','BADFIELD'};
        system.debug('Account.getSObjectType().getDescribe() ==> '+Account.getSObjectType().getDescribe());
        Map<String, Schema.DescribeFieldResult> finalMap = getFieldMetaData(Account.getSObjectType().getDescribe(), fields);
        // only print out the 'good' fields
        for (String field : new Set<String>{'name','annualrevenue'}) {  
        System.debug(finalMap.get(field).getName()); // field name
        System.debug(finalMap.get(field).getType()); // field type
        System.debug(finalMap.get(field).getLength()); // field length
        }
	}

    public static List<String> getAllFieldsMetaData(Schema.DescribeSObjectResult dsor) {
    	//Map<String, Schema.SObjectField> fieldMap = Schema.SObjectType.dsor.fields.getMap();
        Schema.DescribeSObjectResult r = dsor.sObjectType.getDescribe();
        List<String>apiNames =  new list<String>();
        for(string apiName : r.fields.getMap().keySet()){
           apiNames.add(apiName);
           system.debug('apiName ==> '+apiName);
        }
        //System.debug(apiNames);
        return apiNames;
        }
    
    private static Map<String, Schema.DescribeFieldResult> getFieldMetaData(Schema.DescribeSObjectResult dsor, Set<String> fields) {
        
        // the map to be returned with the final data
        Map<String,Schema.DescribeFieldResult> finalMap = new Map<String, Schema.DescribeFieldResult>();
        // map of all fields in the object
        Map<String, Schema.SObjectField> objectFields = dsor.fields.getMap();
        
        // iterate over the requested fields and get the describe info for each one. 
        // add it to a map with field name as key
        for(String field : fields){
            // skip fields that are not part of the object
            if (objectFields.containsKey(field)) {
                Schema.DescribeFieldResult dr = objectFields.get(field).getDescribe();
                // add the results to the map to be returned
                finalMap.put(field, dr); 
            }
        }
        return finalMap;
    }
        
    public static void checksObjectsSchemaMethod(){
// sObject types to describe. gets describe metadata information
        String[] types = new String[]{'Account','Trail__c'};
        // Make the describe call
        Schema.DescribeSobjectResult[] results = Schema.describeSObjects(types);
        System.debug('Got describe information for ' + results.size() + ' sObjects.');
        // For each returned result, get some info
        for(Schema.DescribeSobjectResult res : results) {
            System.debug('sObject Label: ' + res.getLabel());
            System.debug('Number of fields: ' + res.fields.getMap().size());
            System.debug(res.isCustom() ? 'This is a custom object.' : 'This is a standard object.');
            // Get child relationships
            Schema.ChildRelationship[] rels = res.getChildRelationships();
            if (rels.size() > 0) {
                System.debug(res.getName() + ' has ' + rels.size() + ' child relationships.');
            }
		}
// Describing Tabs Using Schema Methods. Get tab set describes for each app
        List<Schema.DescribeTabSetResult> tabSetDesc = Schema.describeTabs();
        // Iterate through each tab set describe for each app and display the info
        for(DescribeTabSetResult tsr : tabSetDesc) { String appLabel = tsr.getLabel();
            System.debug('Label: ' +  tsr.getLabel()); //getLogoUrl , isSelected
            String ns = tsr.getNamespace();
            if (ns == '') {System.debug('The ' + appLabel + ' app has no namespace defined.');
            } else {System.debug('Namespace: ' + ns);}
            // Display tab info for the Sales app
            if (appLabel == 'Sales') {
                List<Schema.DescribeTabResult> tabDesc = tsr.getTabs();
                System.debug('-- Tab information for the Sales app --');
                for(Schema.DescribeTabResult tr : tabDesc) {
                    System.debug('getLabel: ' + tr.getLabel());//getColors, getIconUrl, getIcons
            	}
            }
        }
//Schema getGlobalDescribe method to return a map that represents the relationship between all sObject names (keys) to sObject tokens (values)        
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        for (String gd1: gd.keySet()) {
            if (gd1 == 'Order') system.debug('==> '+gd1 +' ==> '+gd.get(gd1));
        }
// Accessing All Data Categories Associated with an sObject: describeDataCategoryGroups & describeDataCategoryGroupStructures    
    }

    public static void workWithDataDynamicQuery () {
//However, unlike inline SOQL, dynamic SOQL can’t use bind variable fields in the query string
        Vehicle__c  myVariable = new Vehicle__c (Name  ='TestField'); 
        String resolvedField1 = myVariable.Name  ;
// Dynamic SOSL 
		String searchquery='FIND\'Edge*\'IN ALL FIELDS RETURNING Account(id,name),Contact, Lead';
		List<List<SObject>> searchList = search.query(searchquery);
        for (List<SObject> searchListFOR :searchList ) {
			system.debug('searchListFOR ==> '+searchListFOR);            
        }
		//List<sObject> sobjList = Database.query('SELECT Id FROM Vehicle__c WHERE Name = :myVariable.Name');
        List<sObject> sobjList1 = Database.query('SELECT Id FROM Vehicle__c WHERE Name = :resolvedField1');

// foreign key ==> SELECT ID, Name, Parent__r.id, Parent__r.name FROM Child__c ORDER BY Parent__r.name        
// Setting and Retrieving Foreign Keys: Apex assumes the foreign key is populated through a relationship SOQL query, which always returns a parent object with a populated ID.
		Savepoint wwddq = Database.setSavepoint();
        
        List<Campsite_Reservation__c> ListCR = new List<Campsite_Reservation__c>([select name , Campsite__r.Name  from Campsite_Reservation__c]);
        List<Campsite__c> ListCR1 = Database.query('SELECT Id, Name, ' + '(SELECT Name, Start_Date__c FROM Campsite_Reservation__r LIMIT 1) FROM Campsite__c');
        system.debug('ListCR ==> '+ListCR);
// PARENT CHILD
// SELECT LastName__c, ( SELECT LastName__c FROM Daughters__r ) FROM Mother__c      
//SELECT Id, FirstName__c, Mother_of_Child__r.FirstName__c FROM Daughter__c WHERE Mother_of_Child__r.LastName__c LIKE 'C%'
        //      MIS_Job__c mj= new MIS_Job__c(Account__c=myTestAcct.ID, MISNumber__c = '000',Category__c='XXX',  Status__c='YYY');

        Campsite__c newC = new Campsite__c(name = 'PARENT');
        insert newC;
        Campsite_Reservation__C newCR = new Campsite_Reservation__c (Campsite__c=newC.id, Start_Date__c  = system.today());
        insert newCR;
        system.debug('newCR ==> '+newCR);
        //insert new Campsite_Reservation__c (Campsite__r = 'PARENT' Start_Date__c  = system.today(), Campsite__r = new Campsite__c (name = 'PARENT'));
        
        // You can also access foreign keys using dynamic Apex
        String queryString = 'SELECT Id, Name,(SELECT Name, Start_Date__c FROM Campsite_Reservation__r LIMIT 1) FROM Campsite__c';
        SObject[] queryParentObject = Database.query(queryString);
        for (SObject parentRecord : queryParentObject){
            Object ParentFieldValue = parentRecord.get('Name');
            // Prevent a null relationship from being accessed
            SObject[] childRecordsFromParent = parentRecord.getSObjects('Campsite_Reservation__r');
            if (childRecordsFromParent != null) {
                for (SObject childRecord : childRecordsFromParent){
                    Object ChildFieldValue1 = childRecord.get('Name');
                    Object ChildFieldValue2 = childRecord.get('Start_Date__c');
                    System.debug('Campsite__c Name: ' + ParentFieldValue +
                    '. Campsite_Reservation__c Name: '+ ChildFieldValue1 + ' ' + ChildFieldValue2);
                }
            }
        }
        Database.rollback(wwddq);
    } 

// ///// Apex Security and Sharing /////
// 1) User Permission 2) Field Level Security 3) Sharing Rules
// Apex generally runs in system context; that is, the current user's permissions, field-level security, and sharing rules aren’t taken into account during code execution
// The only exceptions to this rule are Apex code that is executed with the executeAnonymous call and Chatter in Apex. executeAnonymous always executes using the full permissions of the current user.
// Enforcing sharing rules by using the 'with sharing' keyword doesn’t enforce the user's permissions and field-level security.
    // public with sharing class CWith {All code in this class operates with enforced sharing rules.}
    // public without sharing class CWithout {
    // All code in this class ignores sharing rules and operates
    // public static void m() {This call into CWith operates with enforced sharing rules for the context user. When the call finishes, the code execution returns to without sharing mode}
    // }
    // public class CInnerWithOut extends CWithout { All code in this class ignores sharing rules because this class extends a parent class that ignores sharing rules.}

    public static List<Object> checkClassSecurity (String objectName) {
        //To enforce current user's permissions, field-level security check Schema.DescribeSObjectResult to verify whether the current user has read, create, or update access to an sObjec
        if (Schema.sObjectType.Contact.fields.Email.isUpdateable()) { //isCreateable(), isAccessible(),isDeletable()
        	system.debug('the email is updateable');
            // Update contact phone number
        } else { system.debug('the field is not updateable'); }
//Force.com Managed Sharing => Reason Fiel(rowCause): Account Sharing (ImplicitChild), Associated record owner or sharing (ImplicitParent), Owner(Owner), Opportunity Team(Team), Sharing Rule(Rule), Territory Assignment Rule(TerritoryRule)
//User Managed Sharing => Reason Fiel: Manual Sharing(Manual), Territory Manual(TerritoryManual)
//Apex Managed Sharing => Defined by developer(Defined by developer)
		String queryString = retryAllFieldsObject(objectName);
        queryString += ' LIMIT 1';
		//system.debug('queryString ==> '+queryString);
        try {
            List<Object> sObjectAS = Database.query(queryString);
            system.debug('sObjectAS =>'+sObjectAS);
            return sObjectAS;
        } catch (exception e){
            system.debug ('error ==> '+e);
            return null;
        }
    }


    public static String retryAllFieldsObject (String objectName) {
        // Initialize setup variables
        //String objectName1 = 'Contact';  // modify as needed
        String query = 'SELECT';
        Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
        for(String s : objectFields.keySet()) {
           query += ' ' + s + ',';
        }
        // Grab the fields from the describe method and append them to the queryString one by one. Manually add related object's fields that are needed.
        //query += 'Account.Name,'; // modify as needed
        // Strip off the last comma if it exists.
        if (query.subString(query.Length()-1,query.Length()) == ','){
            query = query.subString(0,query.Length()-1);
        }
        // Add FROM statement
        query += ' FROM ' + objectName;
        // Add on a WHERE/ORDER/LIMIT statement as needed
        //query += ' WHERE firstName = \'test\''; // modify as needed
        system.debug('query ==> '+query);
        return query;
        /* try {
             List<sObject> sListobject = database.query(query);
             system.debug('sListobject ==> '+sListobject);
             return sListobject;
        } catch (QueryException e){
                //perform exception handling
                return null;
        } */
    }
// manually share a record to a user or a group using Apex or the SOAP API. If the owner of the record changes, the sharing is automatically deleted.
    public static boolean manualShareRead(Id recordId, Id userOrGroupId){ // class01.manualShareRead('a012400000HuTkgAAF', '00524000001qSl7AAE');
        Trail__Share jobShr = new Trail__Share(); // Create new sharing object for the custom object Job.
        jobShr.ParentId = recordId; // Set the ID of record being shared.
        jobShr.UserOrGroupId = userOrGroupId; // Set the ID of user or group being granted access.
        jobShr.AccessLevel = 'Read'; // Set the access level.
        
        //MANUAL SHARE
        //jobShr.RowCause = Schema.Trail__Share.RowCause.Manual; // Set rowCause to 'manual' for manual sharing. This line can be omitted as 'manual' is the default value for sharing objects.
        // APEX SHARING ==> AutomaticbyApex__c is a custom Object --> Custom Object --> Apex Sharing Reason
        jobShr.RowCause = Schema.Trail__Share.rowCause.AutomaticbyApex__c;
        
        // Insert the sharing record and capture the save result.
        // The false parameter allows for partial processing if multiple records passed
        // into the operation.
        Database.SaveResult sr = Database.insert(jobShr,false); // Process the save results.
        if(sr.isSuccess()){ return true;} // Indicates success
        else { Database.Error err = sr.getErrors()[0]; // Get first save result error.
        // Check if the error is related to trival access level.
        // Access levels equal or more permissive than the object's default
        // access level are not allowed.
        // These sharing records are not required and thus an insert exception is acceptable.
        if(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION &&
        err.getMessage().contains('AccessLevel')){
        return true; } // Indicates success.
        else{ return false; } // Indicates failure.
        }
        //Creating an Apex Class for Recalculating Sharing
    }
//Security Tips for Apex and Visualforce Development --> pag 199
//Cross Site Scripting (XSS)
//Cross-Site Request Forgery (CSRF)
//SOQL Injection

// //// CUSTOM SETTINGS ////
    public static void checkCustomSettings(){
        //is exposed in the application cache. List Custom Settings (accessed across your organization) or Hierarchy Custom Settings(specific profiles or users)
    	//class01CSList
    	List<class01CSList__c> mcs = class01CSList__c.getall().values();
        boolean textField = null;
        for (class01CSList__c listMCS: mcs) {
            system.debug('listMCS ==> '+ListMCS);
        }
        
    } 
    
// //// Asynchronous Apex /////
// Future Methods --> When you have a long-running method and need to prevent delaying an Apex transaction.When you make callouts to external Web services. To segregate DML operations and bypass the mixed save DML error
// The maximum number of future method invocations per a 24-hour period is 250,000 or the number of user licenses in your organization multiplied by 200, whichever is greater. This limit is for your entire organization and is shared with all asynchronous Apex: Batch Apex, Queueable Apex, scheduled Apex, and future methods.
@future
    public static void myFutureMethod(List<ID> recordIds) {
        //parameters must be primitive data types, arrays of primitive data types, or collections of primitive data types. Methods with the future annotation cannot take sObjects or objects as arguments
		List<Account> accts = [SELECT Name FROM Account WHERE Id IN :recordIds];
        system.debug('myFutureMethod');
        //No more than 50 method calls per Apex invocation
        //If more than 2,000 unprocessed requests from a single organization are in the queue, any additional requests will be delayed
    }
// Queueable Apex (class04Queueable) --> To start a long-running operation and get an ID for it. To pass complex types to a job. To chain jobs. Setup --> Apex Jobs
// public class Class04Queueable implements Queueable
    public static void AsyncClass04Queueable(){
        ID jobID = System.enqueueJob(new Class04Queueable(1)); //You can add up to 50 jobs to the queue with System.enqueueJob in a single transaction
        system.debug('jobID ==> '+jobID);
        AsyncApexJob Jobinfo = checkAsyncApexJob(jobID);
        system.debug('Jobinfo ==> '+Jobinfo);
  	
    }
    public static AsyncApexJob checkAsyncApexJob (string jobID) {
		AsyncApexJob jobInfo = [SELECT Status,NumberOfErrors FROM AsyncApexJob WHERE Id=:jobID];  
        return jobInfo;
    }

// Scheduled Apex --> To schedule an Apex class to run on a specific schedule. You can only have 100 scheduled Apex jobs at one time. Setup --> Scheduled Jobs
// Synchronous Web service callouts are not supported from scheduled Apex    
// global class class05Schedulable implements Schedulable, Database.AllowsCallouts{
    public static void AsyncClass05Schedulable() {
		class05Schedulable ac05sm = new class05Schedulable();
        //20 seconds
        //30 minutes
        //8 hours
        //10 days of month
        //2 month
        //? Day_of_week
        // Optional Year
        String ac05ssch = '00 10 19 26 12 ?'; //Seconds Minutes Hours Day_of_month(1-7 SUN-SAT) Month Day_of_week optional_year
        String ac05sjobID = system.schedule('AsyncClass05Schedulable Job', ac05ssch, ac05sm);
        CronTrigger ac05sct = checkAsyncSchedulableJob (ac05sjobID);
        system.debug('ac05sct ==> '+ac05sct);
    }
    public static CronTrigger checkAsyncSchedulableJob (string ac05sjobID){
        CronTrigger casjct = [SELECT id, cronjobdetailid, nextfiretime, previousfiretime, state, starttime, endtime, cronexpression, timezonesidkey, ownerid, lastmodifiedbyid, createdbyid, createddate, timestriggered FROM CronTrigger where id = :ac05sjobID];
        system.debug('casjct ==> '+casjct);
        CronJobDetail ctd = [SELECT Id, Name, JobType FROM CronJobDetail WHERE Id = :casjct.cronjobdetailid];
        system.debug('ctd ==> '+ctd);
        return casjct;
    }

// Batch Apex --> For long-running jobs with large data volumes that need to be performed in batches, such as database maintenance jobs. For jobs that need larger query results than regular transactions allow. You can only have five queued or active batch jobs at one time
// The Database.Batchable interface contains three methods that must be implemented:
// To use a callout in batch Apex, specify Database.AllowsCallouts in the class definition
// Database.Stateful in the class definition, you can maintain state across these transactions
// global class class06Batchable implements Database.Batchable<sObject>{
    public static void AsyncClass06Batchable(){

// 1) Execute the batch with scheduleBatch. to schedule a batch job to run once at a future time - 
// System.scheduleBatch(instance of class,job name, time interval,scope )
		
        //string query = 'select id, description__c from accountchild__c';
        //class06Batchable myBatchObject = new class06Batchable(query);
        //String ac06bcronID = System.scheduleBatch(myBatchObject, 'job example', 1,10); //in this example since the scope is 10 and the query is limit to 10 there will be just 1 job batched
        //CronTrigger ac06bct = checkAsyncSchedulableJob (ac06bcronID);
        //system.debug('ac06bct ==> '+ac06bct);
        
// OR 2) execute the batch with Database.executeBatch: Submits a batch Apex job for execution corresponding to the specified class
        // Database.executeBatch(batchClassObject, scope)
        //batchClassObject : ex. class06Batchable
        //scope: An optional parameter scope. This parameter specifies the number of records to pass into the execute method
        
        UtilBCustomLog utilb = new UtilBCustomLog();
        utilb.query = 'select id, description__c from accountchild__c'; 
        utilb.vContext = 'AccountChild';
        utilb.bSendEmail = false;
        //Id ac06bId = Database.executeBatch(new UtilBCustomLog(query), 200);
        Id ac06bId = Database.executeBatch(utilb, 200);
        AsyncApexJob ac06bJobinfo = checkAsyncApexJob(ac06bId);
        system.debug('ac06bJobinfo ==> '+ac06bJobinfo);

//Holding Batch Jobs in the Apex Flex Queue ???
//Up to 100 Holding batch jobs can be held in the Apex flex queue.   

//LIMIT
//The batch Apex start method can have up to 15 query cursors open at a time per user     
//A maximum of 50 million records can be returned in the Database.QueryLocator
//Scope up to 2,000 --> Salesforce chunks the records returned by the QueryLocator into smaller batches of up to 2,000 records
//Methods declared as future aren’t allowed in classes that implement the Database.Batchable interface AND batch Apex class as well
//Chaining Batch Jobs: you can start another batch job from an existing batch job to chain jobs together
    }

   
    

// ///// Apex Email Service /////////    
//class07ApexEmailService    
    

// ///// Platform Cache Partitions /////////        
    public static void checkCachePartition() {
        //create a default cache partition in Setup ==> Platform Cache Partition: cachedefault : cachedefault 
        //doesn't work in a DE use this code in EE, UE & PE
        DateTime dt = DateTime.parse('06/16/2015 11:46 AM');
        Cache.Session.put('local.cachedefault.orderDate', dt);
        //sets the lifetime of the cached value (3600 seconds or 1 hour) and makes the value available to any namespace
        Cache.Session.put('local.cachedefault.totalSum', '500', 3600, Cache.Visibility.ALL, true);
        if (Cache.Session.contains('local.cachedefault.orderDate')) {
        	DateTime cachedDt = (DateTime)Cache.Session.get('local.cachedefault.orderDate');
            system.debug('cachedDt ==> '+cachedDt);
        }
        
    }
    
    public static void lightningConnectCreateOrder () {
        Orders__x order = new Orders__x (customerid__c='500');
        Database.SaveResult sr = Database.insertAsync (order);
        if (! sr.isSuccess ()) {
            String locator = Database.getAsyncLocator ( sr );
            system.debug('locator ==> '+locator);
            //completeOrderCreation(locator);
        } else {
            for(Database.Error err : sr.getErrors()) {
                System.debug('The following error has occurred.');
                System.debug(err.getStatusCode() + ': ' + err.getMessage());
                System.debug('Account fields that affected this error: ' + err.getFields());
            }
        }
// Get Started with the Apex Connector Framework ==> PAG 368 ???????        
    }

// ///// Reports Dashboard API /////

    public static void runReportAPI (boolean runSync){
        Reports.ReportResults results;
        List <Report> reportList = [SELECT Id,DeveloperName FROM Report where DeveloperName = 'Opportunities_by_Stage'];
        String reportId = (String)reportList.get(0).get('Id');
        // Run the report
        if (runSync) { //To run a report synchronously, use one of the ReportManager.runReport()
            results = Reports.ReportManager.runReport(reportId, true);
	        System.debug('Synchronous results: ' + results);
        }
        else { //To run a report asynchronously, use one of the ReportManager.runAsyncReport()
            Reports.ReportInstance instance = Reports.ReportManager.runAsyncReport(reportId, true);
	        System.debug('Asynchronous instance: ' + instance);
            System.debug('List of asynchronous runs: ' + Reports.ReportManager.getReportInstances(reportId));
        }
        
        // Get the report metadata
        Reports.ReportMetadata rm = results.getReportMetadata();
        System.debug('Name: ' + rm.getName());
        System.debug('ID: ' + rm.getId());
        System.debug('Currency code: ' + rm.getCurrencyCode());
        System.debug('Developer name: ' + rm.getDeveloperName());
        // Get grouping info for first grouping
        Reports.GroupingInfo gInfo = rm.getGroupingsDown()[0];
        System.debug('Grouping name: ' + gInfo.getName());
        System.debug('Grouping sort order: ' + gInfo.getSortOrder());
        System.debug('Grouping date granularity: ' + gInfo.getDateGranularity());
        
        // Get aggregates
        for (Integer rrai = 0; rrai < rm.getAggregates().size(); rrai++) {
        	System.debug('Aggregate n:'+rrai+' ==> '+ rm.getAggregates()[0]);    
        }
        // Get detail columns
        System.debug('Detail columns: ' + rm.getDetailColumns());
        List<String> lstColumns = new List<String>();
        lstColumns = rm.getDetailColumns();
        for (String lstC: lstColumns){
            system.debug ('Column ==> '+lstC);
        }
        // Get report format
        System.debug('Report format: ' + rm.getReportFormat());
        
        // Get the first down-grouping in the report
        Reports.Dimension dim = results.getGroupingsDown();
        Reports.GroupingValue groupingVal = dim.getGroupings()[0];
        System.debug('Key: ' + groupingVal.getKey());
        System.debug('Label: ' + groupingVal.getLabel());
        System.debug('Value: ' + groupingVal.getValue());
        // Construct a fact map key, using the grouping key value
        String factMapKey = groupingVal.getKey() + '!T';
        // Get the fact map from the report results
        Reports.ReportFactWithDetails factDetails = (Reports.ReportFactWithDetails)results.getFactMap().get(factMapKey);
        // Get the first summary amount from the fact map
        Reports.SummaryValue sumVal = factDetails.getAggregates()[0];
        System.debug('Summary Value: ' + sumVal.getLabel());
        // Get the field value from the first data cell of the first row of the report
        Reports.ReportDetailRow detailRow = factDetails.getRows()[0];
        System.debug(detailRow.getDataCells()[0].getLabel());
        
        // Get the report metadata
        // The ReportTypeColumn.getFilterable method tells you whether a field can be filtered.
        // The ReportTypeColumn.filterValues method returns all filter values for a field.
        // The ReportManager.dataTypeFilterOperatorMap method lists the field data types that you can use to filter the report.
        Reports.ReportDescribeResult describe = Reports.ReportManager.describeReport(reportId);
        Reports.ReportMetadata reportMd = describe.getReportMetadata();
        // Override filter and run report
        Reports.ReportFilter filter = reportMd.getReportFilters()[0]; //lists all filters that exist in the report.
        filter.setValue('2013-11-01');
        Reports.ReportResults resultsFilterR = Reports.ReportManager.runReport(reportId, reportMd);
        Reports.ReportFactWithSummaries factSum = (Reports.ReportFactWithSummaries)resultsFilterR.getFactMap().get('T!T');
        System.debug('Value for November: ' + factSum.getAggregates()[0].getLabel());
        // Override filter and run report
        filter = reportMd.getReportFilters()[0];
        filter.setValue('2013-10-01');
        resultsFilterR = Reports.ReportManager.runReport(reportId, reportMd);
        factSum = (Reports.ReportFactWithSummaries)resultsFilterR.getFactMap().get('T!T'); //Fact Map Key ==> T!T: The grand total of a report
        // 0!T The first item in the first-level grouping , 0_1!T The first item in the first-level grouping and the second item in the second-level grouping.
        System.debug('Value for October: ' + factSum.getAggregates()[0].getLabel());
    }

// ///// Visual Workflow /////

// Getting Flow Variables
	public Flow.Interview.class09flowChat myFlow {get; set;}

    public String getBreadCrumb() {
        String aBreadCrumb;
        if (myFlow==null) { return 'Home';}
        else aBreadCrumb = (String) myFlow.getVariableValue('vaBreadCrumb'); system.debug('aBreadCrumb ==> '+aBreadCrumb);
        return(aBreadCrumb==null ? 'Home': aBreadCrumb);
    }
//Process.Plugin is a built-in interface that allows you to process data within your organization and pass it to a specified flow
//class09flowChat

//@InvocableMethod
//The annotation supports all data types and bulk operations. Once you implement the annotation on a class, the class can be
// referenced from flows, processes, and the Custom Invocable Actions REST API endpoint.
// Only one method in a class can have the InvocableMethod annotation. Triggers can’t use invocable methods.

////// FIRST EXAMPLE //////
/*
@InvocableMethod(label='Get Account Names' description='Returns the list of account names corresponding to the specified account IDs.')
  public static List<String> checkflowChat(List<id> ids) {
    List<String> accountNames = new List<String>();
    List<Account> accounts = [SELECT Name FROM Account WHERE Id in :ids];
    for (Account account : accounts) {
      accountNames.add(account.Name);
    }
    return accountNames;
  }
*/

////// SECOND EXAMPLE //////    
    
    global class InvocableVariableRequest {
		@InvocableVariable(label='Account ID' description='Insert the Account ID' required=true)
		public id InvocableAccountID;
    }
    
    global class InvocableVariableResponse {
		@InvocableVariable(label='Account Name' description='description of label AcctName' required=true)
		public String InvocableAccountName;
    }        

@InvocableMethod(label='Get Account Names' description='Returns the list of account names corresponding to the specified account IDs.')
    global static list<InvocableVariableResponse> checkflowChat2(list<InvocableVariableRequest> requests) {
        list<InvocableVariableResponse> results = new list<InvocableVariableResponse>();
        for (InvocableVariableRequest request : requests) {
        	results.add(flowGetAccountName(request));
        }
        return results;
    }

    public static InvocableVariableResponse flowGetAccountName (InvocableVariableRequest request){
        InvocableVariableResponse IVResp = new InvocableVariableResponse();
        List<Account> accounts = [SELECT Name FROM Account WHERE Id = :request.InvocableAccountID];
        for (Account account : accounts) {
          IVResp.InvocableAccountName = account.name;
        }
        return IVResp;
    }

    
// ///// WEB SERVICES /////////    
//the maximum request or response size is 6 MB for synchronous Apex or 12 MB for asynchronous
//RestContext Class ==> Contains the RestRequest and RestResponse objects
//request ==> Represents an object used to pass data from an HTTP request to an Apex RESTful Web service method ==> RestRequest req = RestContext.request;
//response ==> Represents an object used to pass data from an Apex RESTful Web service method to an HTTP response ==> RestResponse res = RestContext.response;
//Invoking a custom Apex REST Web service method always uses system context. no enforces of permissions and field-level security. Sharing rules are enforced only when declaring a class with the with sharing keyword
    
// REST Callout ==> AnimalsCallouts / AnimalsCalloutTest
// REST Callout ==> AnimalLocator / AnimalLocatorMock / AnimalLocatorTest / ip2geoWsRest (Test.setMock(HttpCalloutMock.class, new ip2geoWsRestMock ()); )
// SOAP web service outbound ==> ParkService (WSDL) / ParkLocator / ParkServiceMock / ParkLocatorTest/ Latex (Test.setMock(WebServiceMock.class, new latexClassTestMock());)
// Apex REST service inbound ==> AccountManager / CaseManager 
// SOAP web service inbound ==> Class11WSInbound
// Rest web service inboung ==> Class14RestInbound
   
    public static void InvokingSOAPCallouts (){
        parkService.ParksImplPort isr = new parkService.ParksImplPort();
        //Sending HTTP Headers on a Web Service Callout
        isr.inputHttpHeaders_x = new Map<String, String>();
        //Setting a basic authentication header
        isr.inputHttpHeaders_x.put('Authorization', 'Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==');
        isr.outputHttpHeaders_x = new Map<String, String>();
        //Getting cookie header
		String cookie = isr.outputHttpHeaders_x.get('Set-Cookie');
    }
    
    public static void InvokingHTTPCallouts() {
//• Http Class. Use this class to initiate an HTTP request and response.
//• HttpRequest Class: Use this class to programmatically create HTTP requests like GET, POST, PUT, and DELETE.
//• HttpResponse Class: Use this class to handle the HTTP response returned by HTTP.    
    }
//A single Apex transaction can make a maximum of 100 callouts to an HTTP request or an API call.        
//You can make up to 20 concurrent callouts to endpoints outside of your Salesforce org’s domain
//The default timeout is 10 seconds, min 1 and max 120


// //// Asynchronous - Continuation /////    
    public static void MakeLongRunningCallouts() {
//Asynchronous callouts that are made from a Visualforce page don’t count toward the Apex limit of 10 synchronous requests that last longer than five seconds        
	//check the class class10MakeLongRunningCallouts
	//Asynchronous callouts are supported only through a Visualforce page
	//You can chain up to three callouts.
	//To make multiple callouts to a long-running service simultaneously from a Visualforce page, you can add up to three requests to the Continuation instance
    }


// ///// JSON Support /////
    
// System.JSON ==> Contains methods for serializing Apex objects into JSON format and deserializing JSON content that was serialized using the serialize method in this class.
// System.JSONGenerator ==> Contains methods used to serialize objects into JSON content using the standard JSON encoding.
// System.JSONParser ==> Represents a parser for JSON-encoded content
// System.JSONToken ==> enumeration contains the tokens used for JSON parsing
// JSONException ==> if an issue is encountered during execution
    
    public static void checkJSONSupport() {    
//Serialize and Deserialize
        Account cjssAcc = new Account(name = 'TEST');
        Account cjssAcc2 = new Account(name = 'TEST2');
        list<Account> cjssAccList = new List<Account>();
        cjssAccList.add(cjssAcc);
        cjssAccList.add(cjssAcc2);
        String cjssJSONString = JSON.serialize(cjssAccList); // Serialize the list of InvoiceStatement objects.
		System.debug('Serialized list of invoices into JSON format: ' + cjssJSONString);
        
        List<Account> deserializedInvoices = (List<Account>)JSON.deserialize(cjssJSONString, List<Account>.class); // Deserialize the list of invoices from the JSON string.
        System.assertEquals(cjssAccList.size(), deserializedInvoices.size());
        
        //Serialization of queried sObject with additional fields set
        Contact con = [SELECT Id, LastName, AccountId FROM Contact LIMIT 1];
        con.FirstName = 'Joe';        // Set additional field
        String jsonstring = Json.serialize(con);
        System.debug(jsonstring);
        System.assert(jsonstring.contains('Joe') == true);

//JSONGenerator
		
        // Create a JSONGenerator object. Pass true to the constructor for pretty print formatting.
		JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeNumberField('abc', 1.21);
        gen.writeStringField('def', 'xyz');
        gen.writeFieldName('ghi');
        gen.writeStartObject();
        gen.writeObjectField('aaa', cjssAccList);
        gen.writeEndObject();
        gen.writeFieldName('Object A');
        gen.writeObject('writeobject');
        gen.writeEndObject();
        // Get the JSON string.
        String pretty = gen.getAsString();
        system.debug('pretty ==> '+pretty);
        
//JSONParser
		
		String cjssJSON = '{"invoiceList":[' +
            '{"totalPrice":5.5,"statementDate":"2011-10-04T16:58:54.858Z","lineItems":[' +
            '{"UnitPrice":1.0,"Quantity":5.0,"ProductName":"Pencil"},' +
            '{"UnitPrice":0.5,"Quantity":1.0,"ProductName":"Eraser"}],' +
            '"invoiceNumber":1},' +
            '{"totalPrice":11.5,"statementDate":"2011-10-04T16:58:54.858Z","lineItems":[' +
            '{"UnitPrice":6.0,"Quantity":1.0,"ProductName":"Notebook"},' +
            '{"UnitPrice":2.5,"Quantity":1.0,"ProductName":"Ruler"},' +
            '{"UnitPrice":1.5,"Quantity":2.0,"ProductName":"Pen"}],"invoiceNumber":2}' +
            ']}';
		JSONParser parser = JSON.createParser(cjssJSON); 
        Double grandTotal = 0.0;
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&
                (parser.getText() == 'totalPrice')) {
                // Get the value.
                parser.nextToken();
                // Compute the grand total price for all invoices.
                grandTotal += parser.getDoubleValue();
            }
        }
        system.debug('Grand total=' + grandTotal);
    }
    

// //// XML Support /////

     // pag 486  ????
     

    
// //// Securing Your Data /////    
    public static void makeSecuringYourData() {
        
        Blob cryptoKey = Crypto.generateAesKey(256); // Use generateAesKey to generate the private key
        Blob data = Blob.valueOf('Test data to encrypted'); // Generate the data to be encrypted.
        Blob encryptedData = Crypto.encryptWithManagedIV('AES256', cryptoKey, data); // Encrypt the data and have Salesforce.com generate the initialization vector
        Blob decryptedData = Crypto.decryptWithManagedIV('AES256', cryptoKey, encryptedData); // Decrypt the data
    
        //You can encode and decode URLs and convert strings to hexadecimal format
        DateTime d = System.now();
        String timestamp = ''+ d.year() + '-' +
        d.month() + '-' +
        d.day() + '\'T\'' +
        d.hour() + ':' +
        d.minute() + ':' +
        d.second() + '.' +
        d.millisecond() + '\'Z\'';
        System.debug(timestamp);
        String urlEncodedTimestamp = EncodingUtil.urlEncode(timestamp, 'UTF-8');
        System.debug('urlEncodedTimestamp ==> '+urlEncodedTimestamp); //2015-12-27%27T%2723%3A49%3A7.4%27Z%27
    }
    

// ///// Using Patterns and Matchers /////
//Regular expressions in Apex follow the standard syntax for regular expressions used in Java.
    public static void UsingPatternsandMatchers() {
        Pattern MyPattern = Pattern.compile('a*b'); // First, instantiate a new Pattern object "MyPattern"
        Matcher MyMatcher = MyPattern.matcher('aaaaab'); // Then instantiate a new Matcher object "MyMatcher"
        System.assert(MyMatcher.matches());// You can use the system static method assert to verify the match
        Boolean Test = Pattern.matches('a*b', 'aaaaab');
    }
    
    
// ///// Creating Custom Exceptions /////    
// 
    public static Map<String, String> checkExceptionError(Exception e){
        Map<String, String> lExcep = new Map<String, String>();
		lExcep.put('Exception type caught', e.getTypeName());
        lExcep.put('Message', e.getMessage());
		lExcep.put('Cause', string.valueof(e.getCause()));
        lExcep.put('Error Line', string.valueof(e.getLineNumber()));
        lExcep.put('Stack trace',e.getStackTraceString());
        //DmlException, have specific exception methods that apply to only them and aren’t common to other exception types
        Integer ceenumErrors = e.getNumDml();
        for(Integer ceei=0;ceei<ceenumErrors;ceei++) {
            lExcep.put('Index of the failed record ['+ceei+']', string.valueOf(e.getDmlFieldNames(ceei)));
        	lExcep.put('Index of the failed record ['+ceei+']', string.valueOf(e.getDmlId(ceei)));                       
        	lExcep.put('Index of the failed record ['+ceei+']', string.valueOf(e.getDmlMessage(ceei)));
        }
        return lExcep;
    }
    
// You can’t throw built-in Apex exceptions but can only catch them
    public class class01Exception extends Exception{}
    
    public static void checkcatch(){
        try {
            account act = new account();
            insert act;
        } catch (Exception e){
            //throw new class01Exception('ERROR CUSTOM!!!' + e);
            Map<String, String> lExcep = checkExceptionError(e);
            for (String lExcepKey: lExcep.keySet()) {
                system.debug(lExcepKey+' ==> '+lExcep.get(lExcepKey));
            }
        }
    }

       public static void checkcatchCustom(){
        try {
            integer ccci = 0;
            if (ccci > 5) throw new class01Exception('This is bad');
        } catch (class01Exception ce){
            throw new class01Exception('Merchandise item could not be inserted.', ce.getCause());
        } catch (Exception e) {
            system.debug('exception ==> '+e);
        }
    } 
    
// ///// TEST ///////
// 
// This example shows how to use DML operations to insert and query the ApexTestQueueItem and ApexTestResult objects.
// ApexTestQueueItem: Represents a single Apex class in the Apex job queue.
// ApexTestResult: Represents the result of an Apex test method execution.
    // Enqueue all classes ending in "Test".
    public static ID enqueueTests() {
        ApexClass[] testClasses = [SELECT Id FROM ApexClass WHERE Name LIKE '%Test'];
        if (testClasses.size() > 0) {
            ApexTestQueueItem[] queueItems = new List<ApexTestQueueItem>();
            for (ApexClass cls : testClasses) {
                queueItems.add(new ApexTestQueueItem(ApexClassId=cls.Id));
            }
            insert queueItems;
            // Get the job ID of the first queue item returned.
            ApexTestQueueItem item = [SELECT ParentJobId FROM ApexTestQueueItem WHERE Id=:queueItems[0].Id LIMIT 1];
            return item.parentjobid;
        }
        return null;
    }
    // Get the status and pass rate for each class whose tests were run by the job. that correspond to the specified job ID.
    public static void checkClassStatus(ID jobId) {
        ApexTestQueueItem[] items = [SELECT ApexClass.Name, Status, ExtendedStatus FROM ApexTestQueueItem WHERE ParentJobId=:jobId];
        for (ApexTestQueueItem item : items) {
            String extStatus = item.extendedstatus == null ? '' : item.extendedStatus;
            System.debug(item.ApexClass.Name + ': ' + item.Status + extStatus);
        }
    }
    // Get the result for each test method that was executed.
    public static void checkMethodStatus(ID jobId) {
        ApexTestResult[] results = [SELECT Outcome, ApexClass.Name, MethodName, Message, StackTrace FROM ApexTestResult WHERE AsyncApexJobId=:jobId];
        for (ApexTestResult atr : results) {
            System.debug(atr.ApexClass.Name + '.' + atr.MethodName + ': ' + atr.Outcome);
            if (atr.message != null) {
            	System.debug(atr.Message + '\n at ' + atr.StackTrace);
            }
        }
    }

    public static String exampleDeleteAccount(Account acc){
        String result;
        try {
        	delete(acc);
            return result = 'ok';
        } catch (exception e) {
            return result = 'ko';
        }
    }

@Future
    public static void FutureInsertData(id vID){
        list<contact> vlists = [select id from contact where id = :vID];
        list<contact> vlistsadd = new list<contact>();
        for (contact vlist: vlists) {
            vlist.firstname='UPDATE'+vID;
        vlistsadd.add(vlist);
        }
                update vlistsadd;
        
    }    
    
    public static void checkRecordType() {
        
        RecordType rt = [SELECT Id,Name FROM RecordType WHERE SobjectType='Metric' LIMIT 1];
        Schema.DescribeSObjectResult d = Schema.SObjectType.Metric;
        Map<Id,Schema.RecordTypeInfo> rtMapById = d.getRecordTypeInfosById();
        Schema.RecordTypeInfo rtById = rtMapById.get(rt.id);
        Map<String,Schema.RecordTypeInfo> rtMapByName = d.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName = rtMapByName.get(rt.name);
        system.debug('rtByName ==> '+rtByName);
        System.assertEquals(rtById,rtByName);
        
    }
    
    
    
    
    
    
    
    

    
}