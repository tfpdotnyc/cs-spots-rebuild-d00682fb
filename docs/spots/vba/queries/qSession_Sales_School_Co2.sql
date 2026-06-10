-- Query: qSession_Sales_School_Co2
SELECT IIf([Sessions].[CustomerID]<99999999,Int([Sessions].[CustomerID]/1000)*1000,Int(Val(Mid$(Trim$(Str([Sessions].[CustomerID])),5))/1000)*1000) AS SchoolID, Count(SessionDetail.SessionDetailID) AS Total
FROM (Sessions INNER JOIN SessionDetail ON Sessions.SessionID = SessionDetail.SessionID) INNER JOIN SessionItems ON SessionDetail.SessionItemID = SessionItems.SessionItemID
GROUP BY IIf([Sessions].[CustomerID]<99999999,Int([Sessions].[CustomerID]/1000)*1000,Int(Val(Mid$(Trim$(Str([Sessions].[CustomerID])),5))/1000)*1000);

