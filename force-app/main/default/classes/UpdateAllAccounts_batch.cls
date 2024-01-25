global class UpdateAllAccounts_batch implements schedulable {
    
    
   global void execute(schedulableContext context){
   
      UpdateAccounts_batch batch = new UpdateAccounts_batch();
      Database.executebatch(batch);
   }    

}