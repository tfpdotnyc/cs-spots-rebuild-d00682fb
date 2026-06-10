-- Query: qMLabel_Ord_CustList
SELECT qMLabel_Ord.School, qMLabel_Ord.FirstName, qMLabel_Ord.LastName, qMLabel_Ord.Address, qMLabel_Ord.City, qMLabel_Ord.State, qMLabel_Ord.ZipCode, qMLabel_Ord.CustomerID, CustomerListData.ListID
FROM qMLabel_Ord INNER JOIN CustomerListData ON qMLabel_Ord.CustomerID = CustomerListData.CustomerID;

