trigger UpdateAccountTurnover on Order (after update) {
	
    set<Id> setAccountIds = new set<Id>();
    Map<Id, Decimal> mapAccountTotalAmount = new Map<Id,Decimal>();

    for (Order order : Trigger.new){
        if(order.status == 'Ordered'){
        Account acc = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id =:order.AccountId];
            if(!mapAccountTotalAmount.containsKey(order.AccountId)){
                mapAccountTotalAmount.put(order.AccountId,acc.Chiffre_d_affaire__c);
            }
        mapAccountTotalAmount.put(order.AccountId, mapAccountTotalAmount.get(order.AccountId) + order.TotalAmount);
        
            if(!setAccountIds.contains(acc.Id)){
                setAccountIds.add(acc.Id);
            }
		}
    }
    
    List<Account> accToUpdate = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN :setAccountIds];
    
    for (Account account: accToUpdate){
        account.Chiffre_d_affaire__c = mapAccountTotalAmount.get(account.id);
	system.debug(account.Id + ' ' + account.Chiffre_d_affaire__c);
    }

    if(accToUpdate.size() > 0){
		update accToUpdate;
	}

}