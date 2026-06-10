-- Query: AccountReceivable1JKB
SELECT Sum(Round(OrderDetails.LineTotal*(1+Orders.SalesTaxRate),2)) AS OrderTotal, Orders.CustomerID
FROM OrderDetails INNER JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
GROUP BY Orders.CustomerID
HAVING (((Sum(Round([OrderDetails].[LineTotal]*(1+[Orders].[SalesTaxRate]),2)))<>0));

