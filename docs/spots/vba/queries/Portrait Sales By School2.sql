-- Query: Portrait Sales By School2
SELECT Schools.School, OrderItems.Description, Orders.OrderDate, Sum(OrderDetails.Units) AS Units
FROM (((OrderDetails INNER JOIN Orders ON OrderDetails.OrderID = Orders.OrderID) INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID) INNER JOIN Schools ON Customers.SchoolID = Schools.SchoolID) INNER JOIN OrderItems ON OrderDetails.OrderItemID = OrderItems.OrderItemID
GROUP BY Schools.School, OrderItems.Description, Orders.OrderDate;

UNION SELECT Schools.School,' TOTAL ORDERS' , Orders.OrderDate, Count(Orders.OrderDate) AS CountOfOrderDate
FROM (Orders INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID) INNER JOIN Schools ON Customers.SchoolID = Schools.SchoolID
GROUP BY Schools.School, Orders.OrderDate;

