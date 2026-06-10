-- Query: qSalespersonItemSummary2Total
SELECT 'Total' AS UID, OrderDetails.OrderDetailID, OrderItems.ItemType
FROM qOrderReport2 INNER JOIN (OrderDetails INNER JOIN OrderItems ON OrderDetails.OrderItemID = OrderItems.OrderItemID) ON qOrderReport2.OrderID = OrderDetails.OrderID
WHERE (((qOrderReport2.OrderDate)>=#1/1/1980# And (qOrderReport2.OrderDate)<=#12/31/9999#));

