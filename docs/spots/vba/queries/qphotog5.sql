-- Query: qphotog5
SELECT qphotog3.PhotographerID, Orders.CustomerID, Sum(OrderDetails.LineTotal) AS SumOfLineTotal
FROM qphotog3 INNER JOIN (Orders INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) ON qphotog3.CustomerID = Orders.CustomerID
GROUP BY qphotog3.PhotographerID, Orders.CustomerID;

