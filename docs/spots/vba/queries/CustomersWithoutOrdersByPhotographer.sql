-- Query: CustomersWithoutOrdersByPhotographer
SELECT DISTINCT [qMLabel_Not_Ord1].[firstname]+' '+[qMLabel_Not_Ord1].[lastname] AS CustomerName, qMLabel_Not_Ord1.CustomerID, Schools.School, Format([Customers].[Phone],'(000) 000-0000') AS Phone, [Photographers].[firstname]+' '+[Photographers].[lastname] AS PhotographerName
FROM ((Sessions LEFT JOIN Photographers ON Sessions.PhotographerID = Photographers.PhotographerID) RIGHT JOIN (qMLabel_Not_Ord1 LEFT JOIN Schools ON qMLabel_Not_Ord1.SchoolID = Schools.SchoolID) ON Sessions.CustomerID = qMLabel_Not_Ord1.CustomerID) LEFT JOIN Customers ON qMLabel_Not_Ord1.CustomerID = Customers.CustomerID;

