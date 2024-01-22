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
        //change the order status to completed
        //update order
        //get Account CA 
        //assert that Account CA doesn't change
      
    }
}