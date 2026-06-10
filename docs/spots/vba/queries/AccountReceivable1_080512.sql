-- Query: AccountReceivable1_080512
SELECT Sum(Round([OrderDetails].[LineTotal]*(1+[Orders].[SalesTaxRate]),2)) AS OrderTotal, Orders.CustomerID, Orders.OrderNumber, OrderDetails.OrderID
FROM OrderDetails INNER JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
GROUP BY Orders.CustomerID, Orders.OrderNumber, OrderDetails.OrderID
HAVING (((Sum(Round([OrderDetails].[LineTotal]*(1+[Orders].[SalesTaxRate]),2)))<>0));

