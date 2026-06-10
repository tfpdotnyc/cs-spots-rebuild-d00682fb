-- Query: Query6
SELECT SessionReportByDate.*, SessionDetail.SessionItemID, SessionItems.Description
FROM SessionReportByDate INNER JOIN (SessionDetail INNER JOIN SessionItems ON SessionDetail.SessionItemID = SessionItems.SessionItemID) ON SessionReportByDate.SessionID = SessionDetail.SessionID
WHERE (((SessionDetail.SessionItemID)="SE") AND ((SessionReportByDate.CustomerID)=90001))
ORDER BY SessionReportByDate.CustomerID, SessionReportByDate.Date;

