-- Query: qSession_Sales_School_Studio1
SELECT Sessions.Studio, IIf([Sessions].[CustomerID]<99999999,Int([Sessions].[CustomerID]/1000)*1000,Int(Val(Mid$(Trim$(Str([Sessions].[CustomerID])),5))/1000)*1000) AS SchoolID, SessionDetail.SessionItemID, SessionItems.Description, Count(SessionDetail.SessionDetailID) AS CountOfSessionDetailID
FROM (Sessions INNER JOIN SessionDetail ON Sessions.SessionID = SessionDetail.SessionID) INNER JOIN SessionItems ON SessionDetail.SessionItemID = SessionItems.SessionItemID
GROUP BY Sessions.Studio, IIf([Sessions].[CustomerID]<99999999,Int([Sessions].[CustomerID]/1000)*1000,Int(Val(Mid$(Trim$(Str([Sessions].[CustomerID])),5))/1000)*1000), SessionDetail.SessionItemID, SessionItems.Description;

