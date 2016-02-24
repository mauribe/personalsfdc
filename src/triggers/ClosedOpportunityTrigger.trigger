trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    List<Task> tasks = new List<Task>(); 
    List<Opportunity> Opps = Trigger.new; 
    for (Opportunity Opp : Opps) {
        system.debug('Opp '+Opp);
        Task tsk = new Task(whatID = Opp.ID, Ownerid = Opp.OwnerId, Subject='Follow Up Test Task'); 
        tasks.add(tsk);
        system.debug('tsk '+tsk);
    } 
insert tasks;
}