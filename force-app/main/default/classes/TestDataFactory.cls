//@isTest
public class TestDataFactory {
    
    public static String createAccount() {
        
		Account a = new Account(Name='TestAccount');
        insert a;
        return a.Id;
    }

    public static String createContract(Id accountId){

        Contract c = new Contract(
            AccountId = accountId,
            StartDate = Date.today(),
            ContractTerm = Integer.valueof((Math.random() * 9 + 3))
            );
            insert c;
            return c.Id;
    }
    public static void createOrders(Id accountId, Id contractId, Integer nbreOfRecords) {
        
        List<Order> ordersToInsert = new List<Order>();
        for(integer i= 0 ; i< nbreOfRecords; i++){
            Order o = new Order(
                Name='TestOrder' + i,
                AccountId = accountId,
                Status = 'Draft',
                EffectiveDate = Date.today(),
                ContractId = contractId,
                ShipmentCost__c = Integer.valueof((Math.random() * 20 + 130))
                );
                ordersToInsert.add(o);
        }
		insert ordersToInsert;
    }

    
    public static void createData(){
        Integer nbreOfRecords;
        Id accountId = TestDataFactory.createAccount();
        Id contractId = TestDataFactory.createContract(accountId);
        TestDataFactory.createOrders(accountId, contractId, nbreOfRecords);
    }
}