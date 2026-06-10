-- Query: q_OrderDetail
PARAMETERS pCustomerID IEEEDouble, pOrderNumber Text ( 255 );
SELECT OrderDetails.OrderDetailID, OrderDetails.Units AS Qty, OrderDetails.OrderItemID AS ItemType, OrderDetails.UnitCost AS Price, OrderDetails.Discount, OrderDetails.LineTotal AS Total
FROM Orders INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
WHERE (((Orders.CustomerID)=[pCustomerID]) AND ((Orders.OrderNumber)=[pOrderNumber]));

