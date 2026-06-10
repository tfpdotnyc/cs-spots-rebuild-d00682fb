-- Query: qOrderReport1
SELECT Customers.SchoolID, Orders.*, Customers.*, qOrderTotal.TotalOrder, qOrderShipping.ShipCost, qOrderTax.TotalTax
FROM (((Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID) LEFT JOIN qOrderTotal ON Orders.OrderID = qOrderTotal.OrderID) LEFT JOIN qOrderShipping ON Orders.OrderID = qOrderShipping.OrderID) LEFT JOIN qOrderTax ON Orders.OrderID = qOrderTax.OrderID;

