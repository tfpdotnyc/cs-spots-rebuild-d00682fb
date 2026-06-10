-- Query: Query8
SELECT 
FROM (((Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID) LEFT JOIN Actions ON Orders.OrderID = Actions.OrderID) LEFT JOIN ActionItems ON Actions.Action = ActionItems.Action) LEFT JOIN Schools ON Customers.SchoolID = Schools.SchoolID;

