-- Query: qPhotographerOrder2
SELECT [Photographers].[FirstName] & ' ' & [Photographers].[LastName] AS Photographer, qCustomerPhotographer.PhotographerID, Count(qOrderReport2.OrderID) AS OrderCount, Sum(qOrderReport2.TotalOrder) AS OrderTotal
FROM qOrderReport2 INNER JOIN qCustomerPhotographer ON qOrderReport2.Orders.CustomerID = qCustomerPhotographer.CustomerID
WHERE (((qOrderReport2.OrderDate) >= #3/24/2002# And (qOrderReport2.OrderDate) <= #3/24/2003#))
GROUP BY [Photographers].[FirstName] & ' ' & [Photographers].[LastName], qCustomerPhotographer.PhotographerID;

