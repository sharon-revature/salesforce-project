trigger AddPortableProductToOrder on Order (after insert) {
    // Product to be added
    String productName = 'Installation: Portable Product';
    
    // get the PricebookEntry (id and unitprice) for the product in the standard pricebook
    Pricebook2 standardPricebook = [SELECT Id FROM Pricebook2 WHERE IsStandard = true LIMIT 1];
    PricebookEntry portableProductEntry = [SELECT Id, UnitPrice FROM PricebookEntry WHERE Product2.Name = :productName AND Pricebook2Id = :standardPricebook.Id LIMIT 1];
    
    List<OrderItem> orderItemsToInsert = new List<OrderItem>();
    
    // loop through each new Order
    for (Order newOrder : Trigger.new) {
        // check if newOrder already has the product
        Boolean hasPortableProduct = false;
        // for each item/product for each newOrder
        for (OrderItem item : [SELECT Id FROM OrderItem WHERE OrderId = :newOrder.Id]) {
            if (item.PricebookEntryId == portableProductEntry.Id) {
                hasPortableProduct = true;
                break;
            }
        }
        
        // add it to the list if it's not there
        if (!hasPortableProduct) {
            OrderItem newOrderItem = new OrderItem();
            newOrderItem.OrderId = newOrder.Id;
            newOrderItem.PricebookEntryId = portableProductEntry.Id;
            newOrderItem.Quantity = 1;
            newOrderItem.UnitPrice = portableProductEntry.UnitPrice;
            orderItemsToInsert.add(newOrderItem);
        }
    }
    
    // insert the new OrderItems if any
    if (!orderItemsToInsert.isEmpty()) {
        insert orderItemsToInsert;
    }
}