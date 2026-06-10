-- Query: qYrBook_Paid1_Old
SELECT IIf([Customers].[CustomerID]<10000000,Int([Customers].[CustomerID]/1000)*1000,Int(Val(Mid$(Trim$(Str([Customers].[CustomerID])),5))/1000)*1000) AS SchoolID, Customers.LastName, Customers.FirstName, Sessions.CustomerID, Sessions.SessionID, Sessions.SessionNumber, Format([DateTime],"mm/dd/yy") AS EffDate, Sessions.YearbookFee, Studios.SalesTaxRate
FROM (Sessions INNER JOIN Customers ON Sessions.CustomerID = Customers.CustomerID) INNER JOIN Studios ON Sessions.Studio = Studios.Studio
WHERE (((Sessions.SessionNumber)="SA") AND ((Sessions.YearbookFee)<>0));

