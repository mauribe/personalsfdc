public class RandomContactFactory {

    public static List<Contact> generateRandomContacts (Integer vQuant, String vName){
        List<Contact> vLstContact = new List<Contact>();
        for(Integer i=0;i<vQuant;i++) {
            Contact sObContact = new Contact(firstname = vName+i);
        	vLstContact.add(sObContact);
        }
        system.debug('vLstContact = '+vLstContact);
        return vLstContact;
    }
    
}