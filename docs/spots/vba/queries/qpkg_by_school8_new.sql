-- Query: qpkg_by_school8_new
SELECT qpkg_by_school4_new.SchoolID, qpkg_by_school4_new.CustomerID, Sum(OrderDetails.LineTotal) AS SumOfLineTotal
FROM qpkg_by_school4_new INNER JOIN (Orders INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) ON qpkg_by_school4_new.CustomerID = Orders.CustomerID
GROUP BY qpkg_by_school4_new.SchoolID, qpkg_by_school4_new.CustomerID;

