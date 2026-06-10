-- Query: qSchoolOrder1
SELECT qSessionReport2.School, qSchoolOrder_SessionCount.CountOfSessionID AS SessionCount, Count(qSessionReport2.SessionID) AS SessionCountOld, Sum(SessionDetail.LineTotal) AS SessionSales
FROM ((qSessionReport2 INNER JOIN SessionDetail ON qSessionReport2.SessionID = SessionDetail.SessionID) LEFT JOIN ResitReasons ON qSessionReport2.ResitID = ResitReasons.ResitID) LEFT JOIN qSchoolOrder_SessionCount ON qSessionReport2.School = qSchoolOrder_SessionCount.School
WHERE (((qSessionReport2.DateTime) >= #3/24/2002# And (qSessionReport2.DateTime) <= #3/24/2003#) And ((ResitReasons.Charge) = True Or (ResitReasons.Charge) Is Null))
GROUP BY qSessionReport2.School, qSchoolOrder_SessionCount.CountOfSessionID;

