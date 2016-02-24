public class latexClass {
//latexClass lt = new latexClass();    
//public String data;
//public Boolean embeddedData;
//public String error;
//public String fileExt;
//public Integer height;
//public Integer size;
//public Boolean success;
//public String url;
//public Integer width;
//
//system.debug('data ==> '+latexresult.data);
//system.debug('embeddedData ==> '+ latexresult.embeddedData);
//system.debug('error ==> '+latexresult.error);
//system.debug('fileExt ==> '+latexresult.fileExt);
//system.debug('height ==> '+ latexresult.height);
//system.debug('size ==> '+ latexresult.size);
//system.debug('success ==> '+ latexresult.success);
//system.debug('url ==> '+latexresult.url);
//system.debug('width ==> '+ latexresult.width);

    public latexClass() {
		
		latexWS.SOAPlatexResult latexresult = invokeLatexWs('A','B','C',1,true,true,true);
        Map<String, latexWS.compileResponse_element> response_map_x = new Map<String, latexWS.compileResponse_element>();
        
        if (latexresult.success) {
            system.debug('latexresult.data ==> '+latexresult.data);
        } else {
           system.debug('latexresult.error ==> '+latexresult.error);
        }
        
        //dom.Document doc = latexresult.error ;
        //for(dom.XmlNode node : doc.getRootElement().getChildElements()) {
        //  if(node.getName()=='invoice') {
        //   }
    	//}
    }
    //latexWS.compile_element
    public static latexWS.SOAPlatexResult invokeLatexWs (String source,String device,String deviceInfo,Integer dpi,Boolean utf8,Boolean ochem,Boolean embeddedData) {
    //public static latexWS.compile_element invokeLatexWs (String source,String device,String deviceInfo,Integer dpi,Boolean utf8,Boolean ochem,Boolean embeddedData) {
        latexWS.latexHttpPort latexreq = new latexWS.latexHttpPort();
        //latexWS.SOAPlatexResult latexresp = new latexWS.SOAPlatexResult();
        //system.debug(latexWS.SOAPlatexResult(source,device,deviceInfo,dpi,utf8,ochem,embeddedData));
        return latexreq.compile(source,device,deviceInfo,dpi,utf8,ochem,embeddedData);
    }
//    public static String[] country(string countryName) {
//        ParkService.ParksImplPort park = new ParkService.ParksImplPort();
//        return park.byCountry(countryName);


    private String parse(String toParse) {
          DOM.Document doc = new DOM.Document();      
          try {
            doc.load(toParse);    
            DOM.XMLNode root = doc.getRootElement();
            return walkThrough(root);
            
          } catch (System.XMLException e) {  // invalid XML
            return e.getMessage();
          }
	}
    
    private String walkThrough(DOM.XMLNode node) {
      String result = '\n';
      if (node.getNodeType() == DOM.XMLNodeType.COMMENT) {
        return 'Comment (' +  node.getText() + ')';
      }
      if (node.getNodeType() == DOM.XMLNodeType.TEXT) {
        return 'Text (' + node.getText() + ')';
      }
      if (node.getNodeType() == DOM.XMLNodeType.ELEMENT) {
        result += 'Element: ' + node.getName();
        if (node.getText().trim() != '') {
          result += ', text=' + node.getText().trim();
        }
        if (node.getAttributeCount() > 0) { 
          for (Integer i = 0; i< node.getAttributeCount(); i++ ) {
            result += ', attribute #' + i + ':' + node.getAttributeKeyAt(i) + '=' + node.getAttributeValue(node.getAttributeKeyAt(i), node.getAttributeKeyNsAt(i));
          }  
        }
        for (Dom.XMLNode child: node.getChildElements()) {
          result += walkThrough(child);
        }
        return result;
      }
      return '';  //should never reach here 
    }

}