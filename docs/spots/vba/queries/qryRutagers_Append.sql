-- Query: qryRutagers_Append
INSERT INTO Customers ( CustomerID, LastName, FirstName, S_LastName, S_FirstName, Gender, Address, City, State, ZipCode, Phone, Photographed, Deleted, DateDeleted, DeletedBy, Season, CurrentStatus, [Update], Notes )
SELECT Rutgers.Field1 AS Expr1, Rutgers.Field2 AS Expr2, Rutgers.Field3 AS Expr3, Rutgers.Field4 AS Expr4, Rutgers.Field5 AS Expr5, Rutgers.Field6 AS Expr6, Rutgers.Field7 AS Expr7, Rutgers.Field8 AS Expr8, Rutgers.Field9 AS Expr9, Rutgers.Field10 AS Expr10, Rutgers.Field11 AS Expr11, Rutgers.Field12 AS Expr12, Rutgers.Field13 AS Expr13, Rutgers.Field14 AS Expr14, Rutgers.Field15 AS Expr15, Rutgers.Field16 AS Expr16, Rutgers.Field17 AS Expr17, Rutgers.Field18 AS Expr18, Rutgers.Field19 AS Expr19
FROM Rutgers;

