trigger CalculMontant on Order (before insert, before update) {
	
	Order newOrder= trigger.new[0];
    if (newOrder.TotalAmount == 0){
      newOrder.NetAmount__c = 0;  
    } else {
	newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;
	}
}