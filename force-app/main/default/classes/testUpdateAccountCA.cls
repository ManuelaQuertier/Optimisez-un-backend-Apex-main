@isTest
private class testUpdateAccountCA {


    //insert account (with CA?)
    //insert orderWithItems
    //get Account CA
    //get TotalAmount

    @isTest testUpdateAccountCAOrderedStatus(){
        //insert new orderItem
        //get Account CA 
        //get New Total Amount
        //assert that Account CA  change and is equal oldCA+ new Total Amount
    }

    @isTest testUpdateAccountCANotOrderedStatus() {

        //insert new orderItem
        //get Account CA 
        //assert that Account CA doesn't change

        OrderItem oi1 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
        insert oi1;
        OrderItem oi2 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=20, UnitPrice = 1000);
        insert oi2;        
    }
}