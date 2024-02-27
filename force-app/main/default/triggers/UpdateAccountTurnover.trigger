trigger UpdateAccountTurnover on Order (after update) {
	
    if (Trigger.isAfter){
        if(Trigger.isUpdate){
            UpdateAccountTurnoverTriggerHandler instance = new UpdateAccountTurnoverTriggerHandler();

            List<Order> triggerOrders = Trigger.new;

            instance.UpdateAccountTurnover(triggerOrders);
        }
    }
    
}