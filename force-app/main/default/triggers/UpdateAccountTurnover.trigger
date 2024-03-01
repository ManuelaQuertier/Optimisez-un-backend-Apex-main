trigger UpdateAccountTurnover on Order(after update) {

    if (Trigger.isAfter && Trigger.isUpdate) {

      UpdateAccountTurnoverTriggerHandler instance = new UpdateAccountTurnoverTriggerHandler();

      List<Order> ordersUpdated = trigger.new;
      Map<Id,Order> oldOrdersMap = trigger.oldMap;

      instance.UpdateAccountTurnover(ordersUpdated,oldOrdersMap);
    }
}