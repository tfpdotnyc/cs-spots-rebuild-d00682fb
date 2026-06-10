-- Query: AccountReceivable1_CONTINENTAL
SELECT Sum(Round(IIf([OrderItems].[Taxable]=False,[OrderDetails].[LineTotal],[OrderDetails].[LineTotal]*(1+[Orders].[SalesTaxRate])),2)+IIf(IsNull([Shipping].[ShippingId]),0,Round(IIf([Shipping].[Taxable]=False,[Shipping].[Cost],[Shipping].[Cost]*(1+[Orders].[SalesTaxRate])),2))) AS OrderTotal, Orders.CustomerID, Orders.OrderNumber, OrderDetails.OrderID
FROM ((OrderDetails INNER JOIN Orders ON OrderDetails.OrderID = Orders.OrderID) INNER JOIN OrderItems ON OrderDetails.OrderItemID = OrderItems.OrderItemID) LEFT JOIN Shipping ON Orders.OrderID = Shipping.OrderID
GROUP BY Orders.CustomerID, Orders.OrderNumber, OrderDetails.OrderID
HAVING (((Sum(Round(IIf([OrderItems].[Taxable]=False,[OrderDetails].[LineTotal],[OrderDetails].[LineTotal]*(1+[Orders].[SalesTaxRate])),2)+IIf(IsNull([Shipping].[ShippingId]),0,Round(IIf([Shipping].[Taxable]=False,[Shipping].[Cost],[Shipping].[Cost]*(1+[Orders].[SalesTaxRate])),2))))<>0));

