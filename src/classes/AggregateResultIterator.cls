global class AggregateResultIterator Implements Iterator<AggregateResult>{ 
 
    AggregateResult [] results {get;set;} 
    Integer index {get;set;} 
 
    global AggregateResultIterator(){ 
        //String query = 'SELECT count(id) quantity, ownerid, DAY_IN_MONTH(createddate) dayinmonth FROM Task GROUP BY DAY_IN_MONTH(createddate), ownerid'; 
        String query = 'select Id, MIN(createdDate) from Account GROUP BY Id LIMIT 1';
        results = Database.query(query); 
    } 
 
    global boolean hasNext(){ 
        return results !=null && !results.isEmpty() && index < results.size(); 
    } 
 
    global AggregateResult next(){ 
        return results[index++]; 
    } 
}