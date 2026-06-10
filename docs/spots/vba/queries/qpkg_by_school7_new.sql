-- Query: qpkg_by_school7_new
SELECT qpkg_by_school4_new.SchoolID, Sum(OrderPayments.Amount) AS [DEP  PAID]
FROM qpkg_by_school4_new INNER JOIN (Orders INNER JOIN OrderPayments ON Orders.OrderID = OrderPayments.OrderID) ON qpkg_by_school4_new.CustomerID = Orders.CustomerID
GROUP BY qpkg_by_school4_new.SchoolID;

