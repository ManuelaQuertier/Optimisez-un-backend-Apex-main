public with sharing class UpdateAccountService {

public void UpdateAccounts(List<Account> scope) {

  //only select The Orders ordered in the list of account
    List<Order> ordersOrdered = [ SELECT Id, AccountId,
                                  TotalAmount From Order WHERE Status = 'Ordered' AND AccountId IN:scope ];
    
    Map<Id, Decimal> mapAccountTotalAmount = new Map<Id, Decimal>();

    //If the account is not yet in the map,put it. Sum the order total Amount of the all the orders to Account Amount
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