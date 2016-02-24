public class ContactSearch {

    public static List<Contact> searchForContacts (String vLastName, String vMailingPostalCode){
        List<Contact> lCont = [select id, firstname from Contact where lastname=:vLastName and MailingPostalCode=:vMailingPostalCode];
		return lCont;
    }
    
}