-- Query: qMLabel_Not_Ord2_CustList
SELECT qMLabel_Not_Ord2.School, qMLabel_Not_Ord2.FirstName, qMLabel_Not_Ord2.LastName, qMLabel_Not_Ord2.Address, qMLabel_Not_Ord2.City, qMLabel_Not_Ord2.State, qMLabel_Not_Ord2.ZipCode, qMLabel_Not_Ord2.CustomerID, qMLabel_Not_Ord2.EffDate, qMLabel_Not_Ord2.Phone, qMLabel_Not_Ord2.SchoolID, CustomerListData.ListID
FROM qMLabel_Not_Ord2 INNER JOIN CustomerListData ON qMLabel_Not_Ord2.CustomerID = CustomerListData.CustomerID;

