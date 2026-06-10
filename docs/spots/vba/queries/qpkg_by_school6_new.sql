-- Query: qpkg_by_school6_new
SELECT qpkg_by_school4_new.SchoolID, Sum(OrderDetails.LineTotal) AS [TOTAL SALES]
FROM qpkg_by_school4_new INNER JOIN (Orders INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) ON qpkg_by_school4_new.CustomerID = Orders.CustomerID
GROUP BY qpkg_by_school4_new.SchoolID;

