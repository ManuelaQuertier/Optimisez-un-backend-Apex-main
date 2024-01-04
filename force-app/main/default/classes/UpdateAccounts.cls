global class UpdateAccounts implements Database.Batchable<sObject>{
    
   global Database.QueryLocator start(Database.BatchableContext info){ 
       //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
       return Database.getQueryLocator('SELECT Id FROM Account WHERE Id IN(SELECT Id FROM Order WHERE status='Ordered' AND AccountId = Account.Id)');

   }
    
   global void execute(Database.BatchableContext info, List<Account> scope){ 
    
        List<Order> ordersOrdered = [SELECT Id, TotalAmount From Order WHERE AccountId IN (scope)];
        Map<Id, Decimal> mapAccountTotalAmount = new Map<Id,Decimal>();

        for (Order order : ordersOrdered){
            if(!mapAccountTotalAmount.containsKey(order.AccountId)){
                mapAccountTotalAmount.put(order.AccountId,0);
            }
            mapAccountTotalAmount.put(order.AccountId, mapAccountTotalAmount.get(order.AccountId) + order.TotalAmount);
        }

        for (Account account: scope ){
            account.Chiffre_d_affaire__c = mapAccountTotalAmount.get(account.id);
        }
       /*list<Order> listOrders =  [SELECT Id, TotalAmount, AccountId FROM Order];
       
		for(integer i=0; i < scope.size(); i++){
			Account myAccount = scope[i];
			myAccount.Chiffre_d_affaire__c = 0;
           for(integer j=0; j < listOrders.size(); j++){
               if(listOrders[j].AccountId == myAccount.Id){
                   myAccount.Chiffre_d_affaire__c = myAccount.Chiffre_d_affaire__c + listOrders[j].TotalAmount;
               }                   
           }
       }
       */
       update scope;
   }    
    
   global void finish(Database.BatchableContext info){     
       
   } 
}