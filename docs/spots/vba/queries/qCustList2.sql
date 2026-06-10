-- Query: qCustList2
SELECT Schools.School, qCustList1.LastName, qCustList1.FirstName, qCustList1.CustomerID, qCustList1.OrderNumber, qCustList1.OrderDate
FROM qCustList1 INNER JOIN Schools ON qCustList1.SchoolID = Schools.SchoolID
ORDER BY Schools.School, qCustList1.LastName, qCustList1.FirstName;

