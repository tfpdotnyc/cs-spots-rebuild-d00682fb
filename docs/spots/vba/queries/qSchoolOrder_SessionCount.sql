-- Query: qSchoolOrder_SessionCount
SELECT qSessionReport2.School, Count(qSessionReport2.SessionID) AS CountOfSessionID
FROM qSessionReport2 LEFT JOIN ResitReasons ON qSessionReport2.ResitID = ResitReasons.ResitID
WHERE (((qSessionReport2.DateTime) >= #3/24/2002# And (qSessionReport2.DateTime) <= #3/24/2003#) And ((ResitReasons.Charge) = True Or (ResitReasons.Charge) Is Null))
GROUP BY qSessionReport2.School;

