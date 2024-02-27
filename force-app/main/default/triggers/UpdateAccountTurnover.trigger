trigger UpdateAccountTurnover on Order (after update) {
	
    if (Trigger.isAfter){
        if(Trigger.isUpdate){
            UpdateAccountTurnoverTriggerHandler instance = new UpdateAccountTurnoverTriggerHandler();

            List<Order> ordersOrdered = new List<Order>();

            for (Order triggerOrders : trigger.new){
                if (triggerOrders.status != trigger.oldMap.get(triggerOrders.Id).status && triggerOrders.status == 'Ordered'){
                    ordersOrdered.add(triggerOrders);
                }
            }
            
            instance.UpdateAccountTurnover(ordersOrdered);
        }
    }
    
}