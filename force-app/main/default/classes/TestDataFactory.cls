@isTest
public class TestDataFactory {
    public static List<Order> createOrders(Integer numOrders) {
        List<Order> orders = new List<Order>();
        for(Integer i=0;i<numOrders;i++) {
            Order o = new Order(Name='TestOrder' + i);
            orders.add(o);
        }
        insert orders;
        /*List<Opportunity> opps = new List<Opportunity>();
        for (Integer j=0;j<numorders;j++) {
            Order order = orders[j];
            // For each Order just inserted, add opportunities
            for (Integer k=0;k<numOppsPerorder;k++) {
                opps.add(new Opportunity(Name=order.Name + ' Opportunity ' + k,
                                       StageName='Prospecting',
                                       CloseDate=System.today().addMonths(1),
                                       OrderId=order.Id));
            }
        }
        // Insert all opportunities for all Orders.
        insert opps;*/
        return orders;
    }
}
