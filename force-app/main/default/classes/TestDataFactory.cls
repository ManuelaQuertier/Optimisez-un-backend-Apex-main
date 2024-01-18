@isTest
public class TestDataFactory {
    
    public static String createAccount() {
        
		Account myAccount = new Account(Name='TestAccount');
        insert myAccount;
        return myAccount.Id;
    }

    public static String createContract(Id accountId){

        Contract myContract = new Contract(
            AccountId = accountId,
            StartDate = Date.today(),
            ContractTerm = Integer.valueof((Math.random() * 9 + 3))
            );
            insert myContract;
            return myContract.Id;
    }

    public static String createProduct(){

        Product2 myProduct = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        Insert myProduct;
        return myProduct.Id;
    }

    public static String createPriceBookEntry(Id productId){

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
                ShipmentCost__c = Integer.valueof((Math.random() * 20 + 130))
                );
                ordersToInsert.add(o);
        }
		insert ordersToInsert;
        return ordersToInsert;
    }

    public static void createOrderItem(List<Order> orders, Id pricebookEntryId) {
        List<OrderItem> orderItems = new List<OrderItem>();
        for(Order O : orders){
            OrderItem oi1 = new OrderItem (
                OrderId = O.Id,
                PricebookEntryId = pricebookEntryId,
                Quantity=10,
                UnitPrice = 150);
            orderItems.add(oi1);    
        }
        insert orderItems;
    }

    public static void createOrderWithItems(Id accountId, Id contractId, Integer nbreOfRecords, Id pricebookEntryId){
        
        List<Order> OrdersforItem = createOrders(accountId, contractId, nbreOfRecords);
        createOrderItem(OrdersforItem, pricebookEntryId);
    }

    public static void createData(){
        Integer nbreOfRecords;
        Id accountId = TestDataFactory.createAccount();
        Id contractId = TestDataFactory.createContract(accountId);
        TestDataFactory.createOrders(accountId, contractId, nbreOfRecords);
    }

}