-- Query: AccountReceivable Percent
PARAMETERS StartDate DateTime, EndDate DateTime;
SELECT AccountReceivable3.OrderDates, AccountReceivable3.CustomerID, AccountReceivable3.Session, AccountReceivable3.Name, AccountReceivable3.[Phone Number], AccountReceivable3.EMail, AccountReceivable3.Description, AccountReceivable3.[Order T], AccountReceivable3.[Balance Due]
FROM [AccountReceivable Percent1] INNER JOIN AccountReceivable3 ON [AccountReceivable Percent1].CustomerID = AccountReceivable3.CustomerID
WHERE (((AccountReceivable3.OrderDates)>=[StartDate] And (AccountReceivable3.OrderDates)<=[EndDate]) AND ((AccountReceivable3.[Balance Due])>[expr1]));

