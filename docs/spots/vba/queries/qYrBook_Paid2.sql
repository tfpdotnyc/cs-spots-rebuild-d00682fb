-- Query: qYrBook_Paid2
SELECT Schools.School, qYrBook_Paid1.LastName, qYrBook_Paid1.FirstName, qYrBook_Paid1.CustomerID, qYrBook_Paid1.SessionID, qYrBook_Paid1.SessionNumber, qYrBook_Paid1.EffDate, qYrBook_Paid1.YearbookFee, qYrBook_Paid1.SalesTaxRate, Sum(SessionDetail.LineTotal) AS TotalOld, Sum(IIf([SessionItems].[Taxable]=True,[LineTotal]*(1+[SalesTaxRate]),[LineTotal])) AS Total, Sum(qYrBook_Paid1.TPayments) AS TPayments, Sum(qYrBook_Paid1.TDeposit) AS TDeposit
FROM ((qYrBook_Paid1 INNER JOIN SessionDetail ON qYrBook_Paid1.SessionID = SessionDetail.SessionID) INNER JOIN Schools ON qYrBook_Paid1.SchoolID = Schools.SchoolID) INNER JOIN SessionItems ON SessionDetail.SessionItemID = SessionItems.SessionItemID
GROUP BY Schools.School, qYrBook_Paid1.LastName, qYrBook_Paid1.FirstName, qYrBook_Paid1.CustomerID, qYrBook_Paid1.SessionID, qYrBook_Paid1.SessionNumber, qYrBook_Paid1.EffDate, qYrBook_Paid1.YearbookFee, qYrBook_Paid1.SalesTaxRate;

