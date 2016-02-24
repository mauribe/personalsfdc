public with sharing class UtilsIntegration {
	private static map<string,string> mXml = new map<string,string>();
	
	public UtilsIntegration() {
		system.debug('Constructor UtilsIntegration');
	}
	
	
	public static String walkThroughXml(DOM.XMLNode node) {
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
          result += walkThroughXml(child);
        }
        return result;
      }
      return '';  //should never reach here 
    }
    
}