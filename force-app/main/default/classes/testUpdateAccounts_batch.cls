@isTest
public class testUpdateAccounts_batch {

	@TestSetup
	static void testDatas(){
        
        Id accountId = TestDataFactory.createAccount();
        
        Id contractId = TestDataFactory.createContract(accountId);
        Contract newContract = [SELECT Id, status FROM Contract];
        newContract.status= 'Activated';
        update newContract;
        
		TestDataFactory.createOrderWithItems(accountId, 1);
    }

   @isTest
   static void testAccountTurnoverUpdateWithNewPrices() {

		Order myOrder = [Select Id, Status FROM Order];
		myOrder.status= 'Ordered';
		update myOrder;

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

	@isTest 
	static void testSchedulerMethod(){

		String timeToSchedule = '0 0 0 28 2 ? 2024';

		Test.startTest();
		String jodId = System.schedule('ExecuteBatchTest', timeToSchedule, new UpdateAccounts_batch());
		Test.stopTest();

		List<AsyncApexJob> jobsScheduled = [select Id, ApexClassID, ApexClass.Name, Status, JobType from AsyncApexJob where JobType = 'ScheduledApex'];
		System.assertEquals(1, jobsScheduled.size(), 'expecting one apex batch job');

	}
}
