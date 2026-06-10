-- Query: q_SessionOrderOverview
PARAMETERS pCustomerID IEEEDouble, pSessionNo Text ( 255 );
SELECT SessionDetail.Units AS Qty, SessionDetail.SessionItemID AS ItemType, SessionDetail.UnitCost AS Price, SessionDetail.Discount, SessionDetail.LineTotal AS Total, SessionDetail.SessionDetailID, Sessions.SessionNumber
FROM SessionDetail INNER JOIN Sessions ON SessionDetail.SessionID = Sessions.SessionID
WHERE (((Sessions.SessionNumber)=[pSessionNo]) AND ((Sessions.CustomerID)=[pCustomerID]))
ORDER BY SessionDetail.SessionDetailID;

