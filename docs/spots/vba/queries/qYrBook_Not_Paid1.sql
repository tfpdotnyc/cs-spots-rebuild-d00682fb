-- Query: qYrBook_Not_Paid1
SELECT Customers.SchoolID, IIf([Customers].[CustomerID]<99999999,Int([Customers].[CustomerID]/1000)*1000,Int(Val(Mid$(Trim$(Str([Customers].[CustomerID])),5))/1000)*1000) AS SchoolIDOld, Customers.LastName, Customers.FirstName, Sessions.CustomerID, Sessions.SessionID, Sessions.SessionNumber, Format([DateTime],'mm/dd/yy') AS EffDate, Sessions.YearbookFee
FROM Sessions INNER JOIN Customers ON Sessions.CustomerID = Customers.CustomerID
WHERE (((Sessions.SessionNumber) = 'SA') And ((Sessions.YearbookFee) = 0))
ORDER BY Customers.SchoolID, Customers.LastName;

