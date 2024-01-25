trigger UpdateAccountTurnover on Order (after update) {
	
    set<Id> setAccountIds = new set<Id>();
    List<Account> accToUpdate = new List<Account>();
    
    for(integer i=0; i< trigger.new.size(); i++){
        Order newOrder= trigger.new[i];
        If(newOrder.status == 'Ordered'){

            Account acc = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id =:newOrder.AccountId];

            acc.Chiffre_d_affaire__c = acc.Chiffre_d_affaire__c + newOrder.TotalAmount;
            System.debug('Chiffre d\'affaire = ' + acc.Chiffre_d_affaire__c);
            
			accToUpdate.add(acc);
            System.debug( 'setAccIds= ' + accToUpdate);
        }
    } 

    update accToUpdate;
}