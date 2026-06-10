-- Query: AccountReceivable5JKB
SELECT AccountReceivable3.OrderDate, AccountReceivable3.CustomerID, AccountReceivable3.Name, AccountReceivable3.[Phone Number], AccountReceivable3.EMail, AccountReceivable3.[Order T], AccountReceivable3.[Balance Due], AccountReceivable4.[Total Due]
FROM AccountReceivable4 INNER JOIN AccountReceivable3 ON AccountReceivable4.Join = AccountReceivable3.Join;

