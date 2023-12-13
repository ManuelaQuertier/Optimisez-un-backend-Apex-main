public without sharing class MyTeamOrdersController {

    public decimal SumOders{

        get{
			AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order];
            decimal sumOfOrders = groupedResults.get('total');
			return sumOfOrders;
        }
        set;
    }
}