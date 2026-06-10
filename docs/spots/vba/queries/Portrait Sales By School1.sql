-- Query: Portrait Sales By School1
SELECT Schools.School, OrderItems.Description, Orders.OrderDate, OrderDetails.Units
FROM (((OrderDetails INNER JOIN Orders ON OrderDetails.OrderID = Orders.OrderID) INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID) INNER JOIN Schools ON Customers.SchoolID = Schools.SchoolID) INNER JOIN OrderItems ON OrderDetails.OrderItemID = OrderItems.OrderItemID
GROUP BY Schools.School, OrderItems.Description, Orders.OrderDate, OrderDetails.Units;

