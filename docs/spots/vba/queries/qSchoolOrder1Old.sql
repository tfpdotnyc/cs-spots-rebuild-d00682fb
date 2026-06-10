-- Query: qSchoolOrder1Old
SELECT qSessionReport2.School, Count(qSessionReport2.SessionID) AS SessionCount, Sum(SessionDetail.LineTotal) AS SessionSales
FROM qSessionReport2 INNER JOIN SessionDetail ON qSessionReport2.SessionID = SessionDetail.SessionID
WHERE (((qSessionReport2.DateTime)>=#3/24/2002# And (qSessionReport2.DateTime)<=#3/24/2003#))
GROUP BY qSessionReport2.School;

