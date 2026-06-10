-- Query: 000AuditSessionsDetail
SELECT SessionDetail.SessionID, SessionDetail.SessionItemID, SessionDetail.Units, SessionDetail.UnitCost, SessionDetail.Discount, SessionDetail.LineTotal, SessionItems.Description, SessionItems.UnitPrice
FROM SessionDetail INNER JOIN SessionItems ON SessionDetail.SessionItemID = SessionItems.SessionItemID
ORDER BY SessionDetail.SessionID;

