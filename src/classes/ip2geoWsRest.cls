public class ip2geoWsRest {
// ip2geoWsRest i2 = new ip2geoWsRest();
	@TestVisible private static map<string,string> mXml = new map<string,string>();
    
    public ip2geoWsRest() {
		doGet('http://ws.cdyne.com/ip2geo/ip2geo.asmx/ResolveIP');        
    }
    
    public static HttpResponse doGet(string vUrl) {
        Http h = new Http();
        HttpRequest req = new HttpRequest();
		vUrl+='?ipAddress=8.8.8.8';
        vUrl+='&licenseKey=0';
        req.setEndpoint(vUrl);
        //req.setBody('{"ipAddress":"mighty moose"}');
        //req.setBody(body)
		req.setMethod('GET');
        HttpResponse res = h.send(req);
        Dom.Document doc = res.getBodyDocument();
        //Retrieve the root element for this document.
        Dom.XMLNode address = doc.getRootElement();
        string vWalk = walkThrough(address);
        //system.debug('vWalk ==> '+vWalk);
        //system.debug('mXml ==> '+mXml);
        return res;
    }
    
    @TestVisible private static String walkThrough(DOM.XMLNode node) {
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
            mXml.put(node.getName(), node.getText().trim());
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