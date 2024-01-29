
@isTest
public class testMyTeamOrdersController {

    @testSetup 
    static void testDatas(){

    }

    @isTest
    static void testSumOrders() {

        List<Order> allOrders = [SELECT Id, Status FROM Order ];

        List<Order> ordersToUpdate = new List<Order>();

        test.startTest();
        for(Order order : allOrders){
            order.Status = 'Ordered';
            ordersToUpdate.add(order);
        }
        update ordersToUpdate;
        /*
        MyTeamOrdersController instance = new MyTeamOrdersController();
        Decimal sumOfTotalAmount = instance.SumOrders;
        System.debug(sumOfTotalAmount);
        test.stopTest();
        //call SumOrder Method
        //get total amount 
        //sum totals amount

        //System.assertEquals(groupResults,sumOfTotalAmount);
        */
    }
}