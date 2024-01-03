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
    public static Order createOrders(Id accountId, Id contractId) {
        
        Order o = new Order(
            Name='TestOrder',
            AccountId = accountId,
            Status = 'Draft',
            EffectiveDate = Date.today(),
            ContractId = contractId
            ShipmentCost__c = Integer.valueof((Math.random() * 20 + 130))
            );
		insert o;
        return o;
    }

    
    public static void createData(){
        Id accountId = TestDataFactory.createAccount();
        Id contractId = TestDataFactory.createContract(accountId);
        Order myOrder = TestDataFactory.createOrders(accountId, contractId);
    }
}