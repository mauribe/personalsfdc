public class ShareRecordAddcls {

//delete all these records: select id from accountchild__share where UserOrGroupId = '00524000001rjwVAAQ'
    
    public list<AccountChild__Share> lAs = new list<AccountChild__Share>();
    UtilCustomLog uc = new UtilCustomLog();
    
    public ShareRecordAddcls(string vShare, map<id, string> mID) {
        if (vShare == 'AccountChild__c') {
            InsertMassShare(mID);   
        }   
    }
    
    private void InsertMassShare(map<id, string> mID) {
        /*for (sObject so: vsObject) {
            if(so instanceof AccountChild__Share) {
                AccountChild__Share vas = (AccountChild__Share)so;
                lAs.add(vas);
            }
        }
        if(lAs.size()>0) {
            DatabaseInsert(lAs);            
        }
        */
        List<AccountChild__Share> lAccountShare = [select AccessLevel,ParentId,RowCause,UserOrGroupId from AccountChild__Share where ParentId IN:mID.keySet() and UserOrGroupId = '00524000001rjwVAAQ'];
        Map<ID,AccountChild__Share> mAccountShare = new Map<ID,AccountChild__Share>();
        List<AccountChild__Share> nAccountShare = new List<AccountChild__Share>();
        for (AccountChild__Share mAc: lAccountShare) {
            mAccountShare.put(mAc.ParentId, mAc); 
        }
        for (id ac: mID.keySet()) {
            if (mAccountShare.containsKey(ac) == true) {
                system.debug('found the id '+ac);
            }
            else {
                system.debug('not found id: '+ac+' neetd into accountchild__share');
                AccountChild__Share uac = new AccountChild__Share();
                uac.AccessLevel = 'Read';
                uac.ParentId = ac;
                //uac.UserOrGroupId = '00524000001rjwVAAQ';
                uac.UserOrGroupId = mID.get(ac);
                uac.RowCause = Schema.AccountChild__share.RowCause.ApexSharing__c;
                nAccountShare.add(uac);
            }
        }
        if (nAccountShare.size()>0) {
                uc.DBSave(nAccountShare, 'ShareRecordAddcls','Insert');
        }
    }
    
    
}