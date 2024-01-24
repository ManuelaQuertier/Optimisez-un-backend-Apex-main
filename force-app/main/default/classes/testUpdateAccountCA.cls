@isTest
public class testUpdateAccountCA {

   @isTest
	static void testUpdateAccountTurnoverOrderedStatus(){
		        
        Id accountId = TestDataFactory.createAccount();
        Id contractId = TestDataFactory.createContract(accountId);

        Account newAccount = [SELECT Id,Chiffre_d_affaire__c FROM Account WHERE Id = :accountId];
        Decimal accountTurnover = newAccount.Chiffre_d_affaire__c;
        System.debug(accountTurnover);
        
        Contract newContract = [SELECT Id, status FROM Contract WHERE Id = :contractId];
        newContract.status= 'Activated';
        update newContract;
        

		List<Order> orders = TestDataFactory.createOrderWithItems(newAccount.Id, 1);

        Test.startTest();
        
        Order myNewOrder = [SELECT Id,totalAmount from order Where Id = :orders[0].Id];
        myNewOrder.Status = 'Ordered';
		update myNewOrder;
       	Decimal mytotalAmount = myNewOrder.totalAmount;
        System.debug('total amount:' + mytotalAmount);
        
        Account accountUpdated =  [SELECT Id,Chiffre_d_affaire__c FROM Account WHERE Id = :accountId];
        Decimal newAccountTurnover = accountUpdated.Chiffre_d_affaire__c;
            
        Test.stopTest();
        System.assertEquals(newAccountTurnover, accountTurnover + myTotalAmount);
        System.debug(newAccountTurnover + ' , ' + ( accountTurnover + myTotalAmount));

    }
    /*
   testUpdateAccountCANotOrderedStatus() {

        //insert new orderItem
        //change the order status to completed
        //update order
        //get Account CA 
        //assert that Account CA doesn't change
      
    }
    */
}