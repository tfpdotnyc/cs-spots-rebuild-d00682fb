-- Query: qDClose1
SELECT DateValue(Format([DateTime],"mm/dd/yyyy")) AS TstDate, Sum(SessionDetail.LineTotal) AS SumOfLineTotal
FROM Sessions INNER JOIN SessionDetail ON Sessions.SessionID = SessionDetail.SessionID
WHERE (((DateValue(Format([DateTime],"mm/dd/yyyy")))=#8/6/1997#) AND ((Sessions.Studio)=1))
GROUP BY DateValue(Format([DateTime],"mm/dd/yyyy"));

