global class UpdateAllAccounts implements schedulable {
    
    
   global void execute(schedulableContext context){
    UpdateAccounts batch = new UpdateAccounts();
    Database.executebatch(batch);
   }    

}