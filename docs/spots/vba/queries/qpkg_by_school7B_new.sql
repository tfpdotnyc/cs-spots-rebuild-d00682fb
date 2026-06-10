-- Query: qpkg_by_school7B_new
SELECT qpkg_by_school4_new.SchoolID, Sum(DepositPayments.Amount) AS [DEP  PAID2]
FROM (qpkg_by_school4_new INNER JOIN Orders ON qpkg_by_school4_new.CustomerID = Orders.CustomerID) INNER JOIN DepositPayments ON Orders.OrderID = DepositPayments.OrderID
GROUP BY qpkg_by_school4_new.SchoolID;

