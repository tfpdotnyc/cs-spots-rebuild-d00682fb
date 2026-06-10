-- Query: 000AuditOrdersDetails
SELECT OrderDetails.OrderID, OrderDetails.OrderDetailID, OrderDetails.Units, OrderDetails.UnitCost, OrderDetails.Discount, OrderDetails.LineTotal, OrderItems.Description, OrderItems.UnitPrice
FROM OrderDetails INNER JOIN OrderItems ON OrderDetails.OrderItemID = OrderItems.OrderItemID
ORDER BY OrderDetails.OrderID;

