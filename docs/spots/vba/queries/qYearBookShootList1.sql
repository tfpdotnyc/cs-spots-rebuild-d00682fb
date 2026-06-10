-- Query: qYearBookShootList1
SELECT Orders.CustomerID, Max(Actions.Date) AS MatchDate
FROM Actions INNER JOIN Orders ON Actions.OrderID = Orders.OrderID
WHERE (((Actions.Action) = 4))
GROUP BY Orders.CustomerID
HAVING (((Orders.CustomerID)<99999999));

