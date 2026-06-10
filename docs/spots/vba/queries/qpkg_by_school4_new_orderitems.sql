-- Query: qpkg_by_school4_new_orderitems
SELECT Customers.SchoolID, Orders.CustomerID
FROM (Orders LEFT JOIN Customers ON Orders.CustomerID = Customers.CustomerID) INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
WHERE (((OrderDetails.OrderItemID) Not In ('P')))
GROUP BY Customers.SchoolID, Orders.CustomerID;

