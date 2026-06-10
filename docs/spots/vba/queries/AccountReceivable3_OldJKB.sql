-- Query: AccountReceivable3_OldJKB
PARAMETERS StartDate DateTime, EndDate DateTime;
SELECT Orders.OrderDate, AccountReceivable1.CustomerID, Customers.FirstName+' '+Customers.LastName AS Name, Format([Phone],'(000) 000-0000') AS [Phone Number], Customers.EMail, Format(AccountReceivable1.OrderTotal,"Currency") AS [Order T], AccountReceivable1.OrderTotal-AccountReceivable2.TotalPaid AS [Balance Due], [StartDate] AS [Start Date], [EndDate] AS [End Date], " " AS [Join]
FROM AccountReceivable1, AccountReceivable2, Customers, Orders
WHERE (((Orders.OrderDate)>[StartDate] And (Orders.OrderDate)<[EndDate]) And ((AccountReceivable1.OrderTotal-AccountReceivable2.TotalPaid)>1));

