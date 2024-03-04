@isTest 
public class UpdateAccountTurnoverTest {

  @testSetup 
  static void testDatas() {

    Id accountId = TestDataFactory.createAccount();

    Id contractId = TestDataFactory.createContract(accountId);
    update new Contract(Id= contractId, status = 'Activated');
 
    TestDataFactory.createOrderWithItems(accountId, 200);
  }

  @isTest 
  static void testUpdateAccountTurnoverOrderedStatus() {

    Decimal accountTurnover =
        [ SELECT Id, Chiffre_d_affaire__c FROM Account ]?.Chiffre_d_affaire__c;
    
    Order myNewOrder = [ SELECT Id, totalAmount from Order LIMIT 1 ];
    Decimal mytotalAmount = myNewOrder.totalAmount;

    Test.startTest();
    myNewOrder.Status = 'Ordered';
    update myNewOrder;
    Test.stopTest();

    Decimal newAccountTurnover =
        [ SELECT Id, Chiffre_d_affaire__c FROM Account ]?.Chiffre_d_affaire__c;

    System.assertEquals(newAccountTurnover, accountTurnover + myTotalAmount, 'The new Account Turnover is not correct');
  }

  @isTest 
  static void testUpdateAccountTurnoverOtherStatus() {

    Decimal accountTurnover =
        [ SELECT Id, Chiffre_d_affaire__c FROM Account ]?.Chiffre_d_affaire__c;
    Order myNewOrder = [ SELECT Id, totalAmount from order LIMIT 1 ];

    Test.startTest();
    myNewOrder.Status = 'Activated';
    update myNewOrder;
    Test.stopTest();

    Decimal newAccountTurnover =
        [ SELECT Id, Chiffre_d_affaire__c FROM Account ]?.Chiffre_d_affaire__c;

    System.assertEquals(newAccountTurnover, accountTurnover, 'The Account Turnover should not have changed');
  }
}