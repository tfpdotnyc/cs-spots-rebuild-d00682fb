-- Query: q_OrderDetail_Back
PARAMETERS pCustomerID IEEEDouble, pOrderNumber Text ( 255 );
SELECT OrderDetails.OrderDetailID, OrderDetails.Units AS Qty, OrderItems.Description AS ItemType, OrderDetails.UnitCost AS Price, OrderDetails.Discount, OrderDetails.LineTotal AS Total
FROM OrderItems INNER JOIN (Orders INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) ON OrderItems.OrderItemID = OrderDetails.OrderItemID
WHERE (((Orders.CustomerID)=[pCustomerID]) AND ((Orders.OrderNumber)=[pOrderNumber]));

