-- Query: qMLabel_Photod_CustList
SELECT qMLabel_Photod.School, qMLabel_Photod.FirstName, qMLabel_Photod.LastName, qMLabel_Photod.Address, qMLabel_Photod.City, qMLabel_Photod.State, qMLabel_Photod.ZipCode, qMLabel_Photod.Phone, qMLabel_Photod.CustomerID, qMLabel_Photod.SchoolID, qMLabel_Photod.YBJobNumber, CustomerListData.ListID
FROM qMLabel_Photod INNER JOIN CustomerListData ON qMLabel_Photod.CustomerID = CustomerListData.CustomerID;

