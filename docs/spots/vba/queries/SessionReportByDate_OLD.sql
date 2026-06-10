-- Query: SessionReportByDate_OLD
SELECT Sessions.SessionID, Sessions.SessionNumber, Customers.CustomerID, Customers.LastName, Customers.FirstName, Sum(IIf(IsNull([Sessions].[YearbookFee]),0,[Sessions].[YearbookFee])) AS YBFee, Sum(IIf(IsNull([SessionPayments].[Amount]),0,[SessionPayments].[Amount])) AS SittingFee, Sum(IIf(IsNull([DepositPayments].[Amount]),0,[DepositPayments].[Amount])) AS DepositFee, CDate(Format([DateTime],'mm-dd-yyyy')) AS [Date], Schools.School, Schools.SchoolID
FROM ((DepositPayments RIGHT JOIN (SessionPayments RIGHT JOIN Sessions ON SessionPayments.SessionID = Sessions.SessionID) ON DepositPayments.SessionID = Sessions.SessionID) LEFT JOIN Customers ON Sessions.CustomerID = Customers.CustomerID) LEFT JOIN Schools ON Customers.SchoolID = Schools.SchoolID
GROUP BY Sessions.SessionID, Sessions.SessionNumber, Customers.CustomerID, Customers.LastName, Customers.FirstName, CDate(Format([DateTime],'mm-dd-yyyy')), Schools.School, Schools.SchoolID;

