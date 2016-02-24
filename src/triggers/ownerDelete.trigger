trigger ownerDelete on Lead (before delete) {

 for (lead l: trigger.old) {
 Id vUser = l.ownerid;
     if (vUser == Userinfo.getUserId()) {
     } else {
         l.adderror('You can delete this record');
     }
 }

}