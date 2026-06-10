-- Query: qYrBook_Paid2_Old
SELECT Schools.School, qYrBook_Paid1.LastName, qYrBook_Paid1.FirstName, qYrBook_Paid1.CustomerID, qYrBook_Paid1.SessionID, qYrBook_Paid1.SessionNumber, qYrBook_Paid1.EffDate, qYrBook_Paid1.YearbookFee, qYrBook_Paid1.SalesTaxRate, Sum(SessionDetail.LineTotal) AS Total
FROM (qYrBook_Paid1 INNER JOIN SessionDetail ON qYrBook_Paid1.SessionID = SessionDetail.SessionID) INNER JOIN Schools ON qYrBook_Paid1.SchoolID = Schools.SchoolID
GROUP BY Schools.School, qYrBook_Paid1.LastName, qYrBook_Paid1.FirstName, qYrBook_Paid1.CustomerID, qYrBook_Paid1.SessionID, qYrBook_Paid1.SessionNumber, qYrBook_Paid1.EffDate, qYrBook_Paid1.YearbookFee, qYrBook_Paid1.SalesTaxRate;

