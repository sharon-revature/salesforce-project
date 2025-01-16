trigger AddPortableProductToOrder on Order (after insert) {
    // product to be added
    String productName = 'Installation: Portable Product';
    
    // get the Pricebook2 and PricebookEntry information in a single SOQL query (outside the loop)
    Pricebook2 standardPricebook = [SELECT Id FROM Pricebook2 WHERE IsStandard = true LIMIT 1];
    
    if (standardPricebook != null) {
        PricebookEntry portableProductEntry = [SELECT Id, UnitPrice FROM PricebookEntry WHERE Product2.Name = :productName AND Pricebook2Id = :standardPricebook.Id LIMIT 1];
        
        if (portableProductEntry != null) {
            // bulkify orderId into a set
            Set<Id> orderIds = new Set<Id>();
            for (Order newOrder : Trigger.new) {
                orderIds.add(newOrder.Id);
            }
            
            // 1 query for all OrderItems for the given orders
            Map<Id, Set<Id>> orderItemMap = new Map<Id, Set<Id>>();
            for (OrderItem item : [SELECT Id, OrderId, PricebookEntryId FROM OrderItem WHERE OrderId IN :orderIds]) {
                if (!orderItemMap.containsKey(item.OrderId)) {
                    orderItemMap.put(item.OrderId, new Set<Id>());
                }
                orderItemMap.get(item.OrderId).add(item.PricebookEntryId);
            }
            
            // list for new OrderItems to insert
            List<OrderItem> orderItemsToInsert = new List<OrderItem>();
            
            // loop through each new orders
            for (Order newOrder : Trigger.new) {
                // check if the product is already added to the order
                if (!orderItemMap.containsKey(newOrder.Id) || !orderItemMap.get(newOrder.Id).contains(portableProductEntry.Id)) {
                    // add the portable product as a new OrderItem if not
                    OrderItem newOrderItem = new OrderItem();
                    newOrderItem.OrderId = newOrder.Id;
                    newOrderItem.PricebookEntryId = portableProductEntry.Id;
                    newOrderItem.Quantity = 1;
                    newOrderItem.UnitPrice = portableProductEntry.UnitPrice;
                    orderItemsToInsert.add(newOrderItem);
                }
            }
            
            // insert new OrderItems if any
            if (!orderItemsToInsert.isEmpty()) {
                insert orderItemsToInsert;
            }
        }
    }
}