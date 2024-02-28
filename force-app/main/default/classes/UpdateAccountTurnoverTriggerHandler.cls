public with sharing class UpdateAccountTurnoverTriggerHandler {

    public void UpdateAccountTurnover( List<Order> ordersOrdered) {
        
        set<Id> setAccountIds = new set<Id>();
        Map<Id, Decimal> mapAccountTotalAmount = new Map<Id,Decimal>();

        for (Order order : ordersOrdered){

                if(!mapAccountTotalAmount.containsKey(order.AccountId)){
                    mapAccountTotalAmount.put(order.AccountId,0);
                }
                mapAccountTotalAmount.put(order.AccountId, mapAccountTotalAmount.get(order.AccountId) + order.TotalAmount);
        
                if(!setAccountIds.contains(order.AccountId)){
                setAccountIds.add(order.AccountId);
                }
        }
    
        List<Account> accountToUpdate = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN :setAccountIds];
    
        for (Account account: accountToUpdate){
        account.Chiffre_d_affaire__c = account.Chiffre_d_affaire__c + mapAccountTotalAmount.get(account.id);
	    //system.debug(account.Id + ' ' + account.Chiffre_d_affaire__c);
        }

        if(accountToUpdate.size() > 0){
		update accountToUpdate;
	    }
    }
}