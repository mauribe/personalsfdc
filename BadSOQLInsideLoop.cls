trigger BadSOQLInsideLoop on Account (before insert, before update) {

	List<Account> accList = new List<Account>([Select Id,Name From Account]);

	for(Account acc : accList){
	    Integer numWithEmail = 0;
	    for(Contact cont : [Select Id,Email From Contact Where AccountId = :acc.Id]){
	        if(!String.isEmpty(cont.Email)){
	            numWithEmail++;
	        }
	    }
	}
}