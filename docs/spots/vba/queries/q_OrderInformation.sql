-- Query: q_OrderInformation
PARAMETERS CustomerID_Lookup Long, OrderNumber_Lookup Text ( 255 );
SELECT *
FROM Orders
WHERE (((Orders.CustomerID)=[CustomerID_Lookup]) AND ((Orders.OrderNumber)=[OrderNumber_Lookup]));

