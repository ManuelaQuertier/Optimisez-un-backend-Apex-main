@isTest
public class testUpdateAccounts_batch {

   @isTest(SeeAllData=true)
   static void testAccountTurnoverUpdateWithNewPrices() {

        OrderItem myTestOrderItem = [Select Id, UnitPrice, Order.Id, Order.AccountId from orderItem where Order.status = 'Ordered' LIMIT 1];
			//System.debug(myTestOrderItem);
		Id accountId = myTestOrderItem.Order.AccountId;

		Decimal oldAccountTurnover = [SELECT Id, Chiffre_d_affaire__c from Account where Id = :accountId ].Chiffre_d_affaire__c;
			//System.debug ('oldCA' + oldAccountTurnover);
        myTestOrderItem.UnitPrice += 100;
       	update myTestOrderItem;

			//system.debug ('' + newTotalAmount);
       		
       Test.startTest();
       		Id batchId = Database.executeBatch(new UpdateAccounts_batch());
       	Test.stopTest();
       	
		AggregateResult aggregateTotalAmount = [SELECT SUM(TotalAmount) total FROM Order WHERE Status = 'Ordered' AND AccountId = :accountId];
		Decimal sumOfTotalAmount = (Decimal)aggregateTotalAmount.get('total');

		Decimal newAccountTurnover = [SELECT Id, Chiffre_d_affaire__c from Account where Id = :accountId ].Chiffre_d_affaire__c;
       		//System.debug('newCA' + newAccountTurnover);

       System.assertEquals(newAccountTurnover, sumOfTotalAmount, 'problem with the batch');
    }
}