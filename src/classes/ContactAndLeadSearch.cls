public class ContactAndLeadSearch {
    public static List<List<Sobject>> searchContactsAndLeads (String vStr){
        List<List<sObject>> lSobject = [FIND :vStr IN ALL FIELDS 
                   RETURNING Lead(lastname, firstname),Contact(FirstName,LastName)];
		Lead[] searchLead = (Lead[])lSobject[0];
		Contact[] searchContacts = (Contact[])lSobject[1];
        system.debug('lSobject '+lSobject);
        return lSobject;
    }

}