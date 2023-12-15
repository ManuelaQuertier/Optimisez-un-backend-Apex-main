//@isTest
public class TestDataFactory {
    
    public static String createAccount() {
        
		Account a = new Account(Name='TestAccount');
        insert a;
        return a.Id;
    }
    public static Order createOrders(Id accountId) {
        
        Order o = new Order(Name='TestOrder',
							AccountId = accountId,
                           Status = 'Draft',
							EffectiveDate = Date.today());
		insert o;
        return o;
    }
    
    public static void createData(){
        Id accountId = TestDataFactory.createAccount();
        Order myOrder = TestDataFactory.createOrders(accountId);
    }
}