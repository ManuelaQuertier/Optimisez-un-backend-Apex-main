trigger UpdateAccountCA on Order (after update) {
	
    set<Id> setAccountIds = new set<Id>();
    
    for(integer i=0; i< trigger.new.size(); i++){
        Order newOrder= trigger.new[i];
        If(newOrder.status)
       
        Account acc = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id =:newOrder.AccountId];
        
        if (acc.Chiffre_d_affaire__c == null){ 
            System.debug('Le chiffre d\'affaire est nul');
            acc.Chiffre_d_affaire__c = newOrder.TotalAmount;
            update acc;
        }else {
            acc.Chiffre_d_affaire__c = acc.Chiffre_d_affaire__c + newOrder.TotalAmount;
            System.debug('Chiffre d\'affaire = ' + acc.Chiffre_d_affaire__c);
			setAccountIds.add(acc.Id);
            System.debug( 'setAccIds= ' + setAccountIds);
            update acc;
        }
    }
}