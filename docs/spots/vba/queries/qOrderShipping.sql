-- Query: qOrderShipping
SELECT Shipping.OrderID, Sum(Shipping.Cost) AS ShipCost
FROM Shipping
GROUP BY Shipping.OrderID;

