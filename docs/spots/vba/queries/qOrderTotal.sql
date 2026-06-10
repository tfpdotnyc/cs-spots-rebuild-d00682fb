-- Query: qOrderTotal
SELECT OrderDetails.OrderID, Sum(OrderDetails.LineTotal) AS TotalOrder
FROM OrderDetails
GROUP BY OrderDetails.OrderID;

