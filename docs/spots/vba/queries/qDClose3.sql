-- Query: qDClose3
SELECT DateValue(Format([DateTime],"mm/dd/yyyy")) AS TstDate, Sum(Sessions.YearbookFee) AS SumOfYearbookFee
FROM Sessions
WHERE (((DateValue(Format([DateTime],"mm/dd/yyyy")))=#8/6/1997#) AND ((Sessions.Studio)=1))
GROUP BY DateValue(Format([DateTime],"mm/dd/yyyy"));

