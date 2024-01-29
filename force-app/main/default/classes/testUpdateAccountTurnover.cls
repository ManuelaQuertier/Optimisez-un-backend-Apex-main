@isTest
public class testUpdateAccountTurnover {

    @testSetup 
    static void testDatas(){
        
        Id accountId = TestDataFactory.createAccount();
        
        Id contractId = TestDataFactory.createContract(accountId);
        Contract newContract = [SELECT Id, status FROM Contract];
        newContract.status= 'Activated';
        update newContract;
        
		TestDataFactory.createOrderWithItems(accountId, 1);
    }

   @isTest
	static void testUpdateAccountTurnoverOrderedStatus(){
		        
        Decimal accountTurnover = [SELECT Id,Chiffre_d_affaire__c FROM Account].Chiffre_d_affaire__c;
		//System.debug('oldCA :' + accountTurnover);
        Order myNewOrder = [SELECT Id,totalAmount from Order LIMIT 1];
       	Decimal mytotalAmount = myNewOrder.totalAmount;
		//System.debug('total amount:' + mytotalAmount);

        Test.startTest();
        
            myNewOrder.Status = 'Ordered';
		    update myNewOrder;
        
        Test.stopTest();

        Decimal newAccountTurnover =  [SELECT Id,Chiffre_d_affaire__c FROM Account ].Chiffre_d_affaire__c;

        //System.debug('newCA :' + newAccountTurnover + ' , ' + 'calcul :' +( accountTurnover + myTotalAmount));
        System.assertEquals(newAccountTurnover, accountTurnover + myTotalAmount,'pas bien');

    }

    @isTest
    static void testUpdateAccountTurnoverOtherStatus(){

        Decimal accountTurnover = [SELECT Id,Chiffre_d_affaire__c FROM Account].Chiffre_d_affaire__c;
        Order myNewOrder = [SELECT Id,totalAmount from order LIMIT 1];

        Test.startTest();
         
            myNewOrder.Status = 'Activated';
		    update myNewOrder;
         
        Test.stopTest();

        Decimal newAccountTurnover =  [SELECT Id,Chiffre_d_affaire__c FROM Account].Chiffre_d_affaire__c;


        System.assertEquals(newAccountTurnover, accountTurnover);
        //System.debug(newAccountTurnover + ' , ' + accountTurnover);

    }
}