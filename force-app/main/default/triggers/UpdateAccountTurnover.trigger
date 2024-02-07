trigger UpdateAccountTurnover on Order (after update) {
	
    UpdateAccountTurnoverTriggerHandler instance = new UpdateAccountTurnoverTriggerHandler();
    
        instance.UpdateAccountTurnover();
}