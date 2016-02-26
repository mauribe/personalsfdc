@isTest
public class thecontrollerTests {
    private static String nextPage;
    public static testMethod void testMyControllerNoParameters() {
        PageReference pageRef = Page.success;
        Test.setCurrentPage(pageRef);
        thecontroller controller = new thecontroller();
        nextPage = controller.save().getUrl();
        System.assertEquals('/apex/failure?error=noParam', nextPage); // Verify that page fails without parameters
    }
    
    public static testMethod void testMyControllerNoInsert() {
        thecontroller controller = new thecontroller();
        
        ApexPages.currentPage().getParameters().put('qp', 'yyyy'); // Add parameters to page URL
        controller = new thecontroller(); // Instantiate a new controller with all parameters in the page
        controller.setLastName('lastname');
        controller.setFirstName('firstname');
        //controller.setCompany('acme'); //required field for the lead save process
        controller.setEmail('firstlast@acme.com');
        nextPage = controller.save().getUrl();
        System.assertEquals('/apex/failure?error=noInsert', nextPage); // Verify that page fails without required fields
    }
    
    public static testMethod void testMyControllerInsert() {
        thecontroller controller = new thecontroller();
        ApexPages.currentPage().getParameters().put('qp', 'yyyy'); // Add parameters to page URL
        controller = new thecontroller(); // Instantiate a new controller with all parameters in the page
        controller.setLastName('lastname');
        controller.setFirstName('firstname');
        controller.setCompany('acme');
        controller.setEmail('firstlast@acme.com');
        nextPage = controller.save().getUrl();
        System.assertEquals('/apex/success', nextPage); // Verify that the success page displays
        Lead[] leads = [select id, email from lead where Company = 'acme'];
        System.assertEquals('firstlast@acme.com', leads[0].email);
    }
    
    public static testMethod void testMyControllergetAllValues() {
        thecontroller controller = new thecontroller();
        ApexPages.currentPage().getParameters().put('qp', 'yyyy'); // Add parameters to page URL
        controller = new thecontroller(); // Instantiate a new controller with all parameters in the page
        controller.setLastName('lastname');
        controller.setFirstName('firstname');
        controller.setCompany('acme');
        controller.setEmail('firstlast@acme.com');
        String vFN = controller.getFirstName();
        String vLN = controller.getLastName();        
        String vCO = controller.getCompany();
        String vEM = controller.getEmail();
        System.assertEquals('firstname', vFN); // Verify the first name
        System.assertEquals('lastname', vLN); // Verify the first name
        System.assertEquals('acme', vCO); // Verify the first name
        System.assertEquals('firstlast@acme.com', vEM); // Verify the first name
        controller.test='test123';
        String vTest = controller.test;
        System.assertEquals('test123', vTest); // Verify the test variable
    }
    
}