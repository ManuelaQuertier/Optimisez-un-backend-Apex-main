//@isTest
public class TestDataFactory {
    
    public static Id createAccount() {
        
		Account myAccount = new Account(Name='TestAccount7');
        insert myAccount;
        return myAccount.Id;
    }

    public static Id createContract(Id accountId){

        Contract myContract = new Contract(
            AccountId = accountId,
            StartDate = Date.today(),
            ContractTerm = Integer.valueof((Math.random() * 9 + 3))
            );
        insert myContract;
		return myContract.Id;
    }

    public static Id createProduct(){

        Product2 myProduct = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        Insert myProduct;
        return myProduct.Id;
    }

    public static String createPriceBookEntry(){

        Id productId = createProduct();
       
        PricebookEntry myPriceBookEntry = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = productId,
            UnitPrice = 1020,
            IsActive = true
            );
        Insert myPriceBookEntry;
        return myPriceBookEntry.Id;
    }

    public static List<Order> createOrders(Id accountId, Id contractId, Integer nbreOfRecords) {

        List<Order> ordersToInsert = new List<Order>();
       
        for(integer i= 0 ; i< nbreOfRecords; i++){
            Order o = new Order(
                Name='TestOrder' + i,
                AccountId = accountId,
                Status = 'Draft',
                EffectiveDate = Date.today(),
                Pricebook2Id = Test.getStandardPricebookId(),
                ContractId = contractId,
                ShipmentCost__c = Integer.valueof(Math.random() * 10 + 50)
                );
            ordersToInsert.add(o);
        }

		insert ordersToInsert;
        return ordersToInsert;
    }

    public static List<order> createOrderItem(List<Order> orders, Id pricebookEntryId) {

        List<OrderItem> orderItems = new List<OrderItem>();
        for(Order O : orders){
            OrderItem myOrderItem = new OrderItem (
                OrderId = O.Id,
                PricebookEntryId = pricebookEntryId,
                Quantity= Integer.valueof(Math.random()*10 + 1),
                UnitPrice = 150
                );
            orderItems.add(myOrderItem);    
        }
        insert orderItems;
        return orders;
    }


    public static List<order> createOrderWithItems(Id accountId, Integer nbreOfOrders){

        Integer nbreOfRecords = nbreOfOrders;
		Contract contract = [SELECT Id From Contract WHERE AccountId = :accountId];
        Id pricebookEntryId = createPriceBookEntry();
        List<Order> OrdersforOrderItem = createOrders(accountId, contract.Id, nbreOfRecords);
        createOrderItem(OrdersforOrderItem, pricebookEntryId);
        return OrdersforOrderItem;
    }

}