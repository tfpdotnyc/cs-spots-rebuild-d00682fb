-- Query: AccountReceivable3JKB
SELECT Orders.OrderDate, AccountReceivable1.CustomerID, Customers.FirstName+' '+Customers.LastName AS Name, Format([Phone],'(000) 000-0000') AS [Phone Number], Customers.EMail, AccountReceivable1.OrderTotal AS [Order T], [OrderTotal]-IIf(IsNull([TotalDeposits]),0,[TotalDeposits])-IIf(IsNull([TotalOrderPayments]),0,[TotalOrderPayments]) AS [Balance Due], " " AS [Join]
FROM (((Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID) LEFT JOIN AccountReceivable1 ON Customers.CustomerID = AccountReceivable1.CustomerID) LEFT JOIN AccountsReceivable_Deposits ON Customers.CustomerID = AccountsReceivable_Deposits.CustomerID) LEFT JOIN AccountsReceivable_OrderPayments ON Customers.CustomerID = AccountsReceivable_OrderPayments.CustomerID
WHERE ((([OrderTotal]-IIf(IsNull([TotalDeposits]),0,[TotalDeposits])-IIf(IsNull([TotalOrderPayments]),0,[TotalOrderPayments]))>0));

