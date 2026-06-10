-- Query: qDClose4
SELECT DateValue(Format([OrderDate],"mm/dd/yyyy")) AS TstDate, Sum(Shipping.Cost) AS SumOfCost
FROM Shipping INNER JOIN Orders ON Shipping.OrderID = Orders.OrderID
WHERE (((DateValue(Format([OrderDate],"mm/dd/yyyy")))=#8/6/1997#) AND ((Orders.Studio)=1))
GROUP BY DateValue(Format([OrderDate],"mm/dd/yyyy"));

