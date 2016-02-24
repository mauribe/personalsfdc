public class Class13AsyncFuture {

@future
    public static void futurecallout (set<id> sID){
        system.debug('Class13AsyncFuture ==> '+sID);
        List<Contact> ListCont = [select id, title from contact where id = :sID];
        for (contact vCon: ListCont) {
            system.debug('vCon ==> '+vCon);
            vCon.title = 'X'+vCon.id;
            update vCon;
        }
    }    
    
}