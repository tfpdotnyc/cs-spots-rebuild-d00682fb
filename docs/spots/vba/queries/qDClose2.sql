-- Query: qDClose2
SELECT DateValue(Format([OrderDate],"mm/dd/yyyy")) AS TstDate, Sum(OrderDetails.LineTotal) AS SumOfLineTotal
FROM Orders INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
WHERE (((DateValue(Format([OrderDate],"mm/dd/yyyy")))=#8/6/1997#) AND ((Orders.Studio)=1))
GROUP BY DateValue(Format([OrderDate],"mm/dd/yyyy"));

