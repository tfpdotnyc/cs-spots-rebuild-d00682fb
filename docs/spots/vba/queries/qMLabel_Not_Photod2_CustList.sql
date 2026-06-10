-- Query: qMLabel_Not_Photod2_CustList
SELECT qMLabel_Not_Photod2.School, qMLabel_Not_Photod2.FirstName, qMLabel_Not_Photod2.LastName, qMLabel_Not_Photod2.Address, qMLabel_Not_Photod2.City, qMLabel_Not_Photod2.State, qMLabel_Not_Photod2.ZipCode, qMLabel_Not_Photod2.CustomerID, qMLabel_Not_Photod2.EffDate, qMLabel_Not_Photod2.Phone, qMLabel_Not_Photod2.SchoolID, qMLabel_Not_Photod2.YBJobNumber, CustomerListData.ListID
FROM qMLabel_Not_Photod2 INNER JOIN CustomerListData ON qMLabel_Not_Photod2.CustomerID = CustomerListData.CustomerID;

