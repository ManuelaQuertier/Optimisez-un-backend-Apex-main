@isTest
public class testMyTeamOrdersController {

    @testSetup 
    static void testDatas(){

		Id accountId = TestDataFactory.createAccount();
        
        Id contractId = TestDataFactory.createContract(accountId);
        Contract newContract = [SELECT Id, status FROM Contract];
        newContract.status= 'Activated';
        update newContract;
        
		TestDataFactory.createOrderWithItems(accountId, 10);
    }

    @isTest
    static void testSumOrders() {

        List<Order> someOrders = [SELECT Id, Status FROM Order LIMIT 5];

        List<Order> ordersToUpdate = new List<Order>();

        for(Order order : someOrders){
            order.Status = 'Ordered';
            ordersToUpdate.add(order);
        }
        update ordersToUpdate;
       
        Test.startTest();
        MyTeamOrdersController instance = new MyTeamOrdersController();
        Decimal sumOfTotalAmount = instance.SumOrders;
        System.debug(sumOfTotalAmount);
      	Test.stopTest();
		
        AggregateResult allOrdersgroupedResults = [SELECT SUM(TotalAmount) total FROM Order];
		Decimal sumOfAllTotalAmount = (Decimal)allOrdersgroupedResults.get('total');
		system.debug((Decimal)allOrdersgroupedResults.get('total'));

        AggregateResult notOrderedOrdersgroupedResults = [SELECT SUM(TotalAmount) total FROM Order WHERE Status != 'Ordered'];
		Decimal sumOfAllnotOrdered = (Decimal)notOrderedOrdersgroupedResults.get('total');
		system.debug((Decimal)notOrderedOrdersgroupedResults.get('total'));

		System.debug('ordered :' + sumOfTotalAmount + ' - ' + 'Calcul:' + (sumOfAllTotalAmount - sumOfAllnotOrdered));
        System.assertEquals(sumOfTotalAmount,(sumOfAllTotalAmount - sumOfAllnotOrdered));
        
    }
}