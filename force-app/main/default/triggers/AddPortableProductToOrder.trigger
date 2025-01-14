trigger AddPortableProductToOrder on Order (before insert) {
    // define name of the portable product
    String portableProductName = 'Installation: Portable Product';
    
    // get product ID for the "Installation: Portable Product"
    Product2 portableProduct = [SELECT Id FROM Product2 WHERE Name = :portableProductName LIMIT 1];
    
    // list for OrderItems that need to be added
    List<OrderItem> newOrderItems = new List<OrderItem>();
    
    // iterate through new Orders being created
    for (Order ord : Trigger.new) {
        // query for existing OrderItems associated with this Order
        List<OrderItem> existingOrderItems = [SELECT Id, Product2Id FROM OrderItem WHERE OrderId = :ord.Id];
        
        // check if "Installation: Portable Product" is already on the Order
        Boolean hasPortableProduct = false;
        for (OrderItem orderItem : existingOrderItems) {
            if (orderItem.Product2Id == portableProduct.Id) {
                hasPortableProduct = true;
                break;
            }
        }
        
        // add the Product if it's not in the Order
        if (!hasPortableProduct) {
            OrderItem newItem = new OrderItem(
                OrderId = ord.Id,
            Product2Id = portableProduct.Id,
            Quantity = 1
                );
            newOrderItems.add(newItem);
        }
    }
    
    // insert new OrderItems to add the product to Orders
    if (!newOrderItems.isEmpty()) {
        insert newOrderItems;
    }
}