-- Query: UnusedDeposits
SELECT CDate(Format([Date],'mm/dd/yyyy')) AS DepositDate, DepositPayments.CustomerID, [Customers].[FirstName]+' '+[Customers].[LastName] AS CustomerName, Format([Phone],'(000) 000-0000') AS PhoneNumber, Customers.EMail, Sum(DepositPayments.Amount) AS SumOfAmount
FROM DepositPayments INNER JOIN Customers ON DepositPayments.CustomerID = Customers.CustomerID
WHERE (((DepositPayments.OrderID)=0))
GROUP BY CDate(Format([Date],'mm/dd/yyyy')), DepositPayments.CustomerID, [Customers].[FirstName]+' '+[Customers].[LastName], Format([Phone],'(000) 000-0000'), Customers.EMail;

