-- Query: AccountReceivable Percent1
PARAMETERS [Percent] IEEEDouble;
SELECT [Order T]*[Percent] AS Expr1, AccountReceivable3.CustomerID
FROM AccountReceivable3;

