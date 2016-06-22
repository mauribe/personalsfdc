trigger AvoidHardcodingID on Account (after insert, after update) {
	for(Account a: Trigger.new){
	   //Error - hardcoded the record type id
	   if(a.RecordTypeId=='012500000009WAr'){     	  	
	      //do some logic here.....
	   }else if(a.RecordTypeId=='0123000000095Km'){
	      //do some logic here for a different record type...
	   }
	}
}



