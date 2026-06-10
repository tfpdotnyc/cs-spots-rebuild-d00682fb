-- Query: qphotog4
SELECT qphotog3.PhotographerID, Count(OrderDetails.OrderItemID) AS [# PACKAGES], Sum(OrderDetails.LineTotal) AS [$ PACKAGES]
FROM qphotog3 INNER JOIN (Orders INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) ON qphotog3.CustomerID = Orders.CustomerID
GROUP BY qphotog3.PhotographerID;

