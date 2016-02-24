global class latexClassTestMock implements WebServiceMock{
    global void doInvoke
    	(Object stub,
        Object request,
        Map<String, Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType) {
            latexWS.SOAPlatexResult out;
            latexws.SOAPlatexResult response_x = new latexws.SOAPlatexResult();
            latexws.compileResponse_element response_y = new latexws.compileResponse_element();
            response_x.data = 'A';
            response_y.out = response_x;
	        response.put('response_x', response_y); 
    }

}