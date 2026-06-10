-- Query: AccountReceivable1
SELECT Sum(Round([OrderDetails].[LineTotal],5)) AS OrderTotal, Sum(Round(IIf([OrderItems].[Taxable]=False,0,[OrderDetails].[LineTotal]*([Orders].[SalesTaxRate])),5)) AS OrderTotalTax, Avg(IIf([Orders].[ShippingNeeded]=False,0,IIf(IsNull([Shipping].[ShippingId]),0,Round([Shipping].[Cost],5)))) AS ShippingTotal, Avg(IIf([Orders].[ShippingNeeded]=False,0,IIf(IsNull([Shipping].[ShippingId]),0,Round(IIf([Shipping].[Taxable]=False,0,[Shipping].[Cost]*([Orders].[SalesTaxRate])),5)))) AS ShippingTotalTax, Orders.CustomerID, Orders.OrderNumber, OrderDetails.OrderID
FROM ((OrderDetails INNER JOIN Orders ON OrderDetails.OrderID = Orders.OrderID) INNER JOIN OrderItems ON OrderDetails.OrderItemID = OrderItems.OrderItemID) LEFT JOIN Shipping ON Orders.OrderID = Shipping.OrderID
GROUP BY Orders.CustomerID, Orders.OrderNumber, OrderDetails.OrderID
HAVING (((Sum(Round([OrderDetails].[LineTotal],5)))<>0));

