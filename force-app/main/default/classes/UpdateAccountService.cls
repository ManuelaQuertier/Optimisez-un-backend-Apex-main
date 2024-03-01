public with sharing class UpdateAccountService {

public void UpdateAccounts(List<Account> scope) {

    List<Order> ordersOrdered = [ SELECT Id, AccountId,
                                  TotalAmount From Order WHERE Status = 'Ordered' AND AccountId IN:scope ];
    
    Map<Id, Decimal> mapAccountTotalAmount = new Map<Id, Decimal>();

    for (Order order : ordersOrdered) {
      if (!mapAccountTotalAmount.containsKey(order.AccountId)) {
        mapAccountTotalAmount.put(order.AccountId, 0);
      }
      mapAccountTotalAmount.put(order.AccountId, mapAccountTotalAmount.get(order.AccountId) + order.TotalAmount);
    }

    for (Account account : scope) {
      account.Chiffre_d_affaire__c = mapAccountTotalAmount.get(account.id);
    }

    update scope;
  }
}