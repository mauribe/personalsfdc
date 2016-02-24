@isTest
public class latexClassTest {
    @isTest static void testCallout() {
        Test.setMock(WebServiceMock.class, new latexClassTestMock());
        latexWS.SOAPlatexResult latexresult = latexClass.invokeLatexWs('A','B','C',1,true,true,true);
        system.debug('latexresult ==> '+latexresult);
        
    }
    
}