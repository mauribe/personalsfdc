trigger BadBulkifyyourCode on Account (before insert, before update) {

   //This only handles the first record in the Trigger.new collection
   //But if more than one Account initiated this trigger, those additional records
   //will not be processed
   Account acct = Trigger.new[0];
   List<Contact> contacts = [select id, salutation, firstname, lastname, email 
              from Contact where accountId =&nbsp;:acct.Id];
   
}
