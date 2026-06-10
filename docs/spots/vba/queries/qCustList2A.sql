-- Query: qCustList2A
SELECT Schools.School, qCustList1A.SchoolID, qCustList1A.LastName, qCustList1A.FirstName, qCustList1A.CustomerID, qCustList1A.OrderNumber, qCustList1A.OrderDate, Sum(qCustList1A.LineTotal) AS LineTotal, Sum(qCustList1A.Tax) AS Tax
FROM qCustList1A INNER JOIN Schools ON qCustList1A.SchoolID = Schools.SchoolID
GROUP BY Schools.School, qCustList1A.SchoolID, qCustList1A.LastName, qCustList1A.FirstName, qCustList1A.CustomerID, qCustList1A.OrderNumber, qCustList1A.OrderDate;

