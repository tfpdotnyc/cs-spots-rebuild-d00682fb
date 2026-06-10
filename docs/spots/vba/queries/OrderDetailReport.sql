-- Query: OrderDetailReport
SELECT Orders.OrderDate, Orders.CustomerID, OrderDetails.OrderID, Orders.SalesTaxRate, Sum(IIf(IsNull([orderdetails].[LineTotal]),0,[orderdetails].[LineTotal])) AS SubTotal, IIf(IsNull([Cost]),0,[cost]) AS Shipping, Sum(CCur(Round(IIf(IsNull([OrderDetails].[LineTotal]),0,[OrderDetails].[LineTotal]+[shipping])*(IIf([OrderItems].[Taxable]=False,0,[Orders].[SalesTaxRate])+1),2))) AS Total, Schools.School, Customers.LastName, Customers.FirstName
FROM ((((OrderDetails RIGHT JOIN Orders ON OrderDetails.OrderID = Orders.OrderID) LEFT JOIN Customers ON Orders.CustomerID = Customers.CustomerID) LEFT JOIN Schools ON Customers.SchoolID = Schools.SchoolID) LEFT JOIN Shipping ON Orders.OrderID = Shipping.OrderID) LEFT JOIN OrderItems ON OrderDetails.OrderItemID = OrderItems.OrderItemID
GROUP BY Orders.OrderDate, Orders.CustomerID, OrderDetails.OrderID, Orders.SalesTaxRate, IIf(IsNull([Cost]),0,[cost]), Schools.School, Customers.LastName, Customers.FirstName;

