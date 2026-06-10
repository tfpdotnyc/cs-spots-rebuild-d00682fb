-- Query: qAllRetouch1
SELECT Retouchers.Name, [Orders].[CustomerID] & [OrderNumber] AS OrderNo, Customers.LastName, Customers.FirstName, Orders.OrderDate, qAction5.Date, Customers.CustomerID, Customers.SchoolID, IIf([Customers].[CustomerID]<99999999,Int([Customers].[CustomerID]/1000)*1000,Int(Val(Mid$(Trim$(Str([Customers].[CustomerID])),5))/1000)*1000) AS SchoolIDOld, Orders.Negatives, qAction5.Update
FROM (((qAction5 LEFT JOIN qAction6 ON qAction5.OrderID = qAction6.OrderID) INNER JOIN Orders ON qAction5.OrderID = Orders.OrderID) INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID) INNER JOIN Retouchers ON qAction5.ExtraID = Retouchers.Retoucher
WHERE (((qAction6.OrderID) Is Null))
ORDER BY Retouchers.Name, [Orders].[CustomerID] & [OrderNumber];

