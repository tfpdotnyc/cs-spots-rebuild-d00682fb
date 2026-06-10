-- Query: q_SessionOrderOverview_Back
PARAMETERS pSessionID Long;
SELECT SessionDetail.Units AS Qty, SessionItems.Description AS ItemType, SessionDetail.UnitCost AS Price, SessionDetail.Discount, SessionDetail.LineTotal AS Total, SessionDetail.SessionDetailID
FROM SessionDetail INNER JOIN SessionItems ON SessionDetail.SessionItemID = SessionItems.SessionItemID
WHERE (((SessionDetail.SessionID)=[pSessionID]))
ORDER BY SessionDetail.SessionDetailID;

