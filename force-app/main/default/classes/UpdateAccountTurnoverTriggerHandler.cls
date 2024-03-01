public with sharing class UpdateAccountTurnoverTriggerHandler {

public void UpdateAccountTurnover(List<Order> ordersUpdated, Map<Id,Order> oldOrdersMap) {

    set<Id> setAccountIds = new set<Id>();
    Map<Id, Decimal> mapAccountTotalAmount = new Map<Id, Decimal>();
    List<Order> ordersOrdered = new List<Order>();

    for (Order orderTriggered : ordersUpdated) {
      if (orderTriggered.status != oldOrdersMap.get(orderTriggered.Id).status && orderTriggered.status == 'Ordered') {
        ordersOrdered.add(orderTriggered);
      }
    }

    for (Order order : ordersOrdered) {

      if (!mapAccountTotalAmount.containsKey(order.AccountId)) {
        mapAccountTotalAmount.put(order.AccountId, 0);
      }
      mapAccountTotalAmount.put(order.AccountId, mapAccountTotalAmount.get(order.AccountId) + order.TotalAmount);

      if (!setAccountIds.contains(order.AccountId)) {
        setAccountIds.add(order.AccountId);
      }
    }

    List<Account> accountToUpdate =
        [ SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN:setAccountIds ];

    for (Account account : accountToUpdate) {
      account.Chiffre_d_affaire__c = account.Chiffre_d_affaire__c + mapAccountTotalAmount.get(account.id);
    }

    if (accountToUpdate.size() > 0) {
      update accountToUpdate;
    }
  }
}