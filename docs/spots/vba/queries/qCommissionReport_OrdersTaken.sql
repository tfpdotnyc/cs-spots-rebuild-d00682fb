-- Query: qCommissionReport_OrdersTaken
SELECT Orders.UserID, Count(Orders.OrderID) AS OrdersTaken
FROM Orders
WHERE (((Orders.OrderDate) >= #8/6/2000# And (Orders.OrderDate) <= #8/6/2004 11:59:59 PM#) And ((Orders.Studio) <> 99))
GROUP BY Orders.UserID;

