-- Query: qMLabel_PrfOut2_CustList
SELECT qMLabel_PrfOut2.School, qMLabel_PrfOut2.FirstName, qMLabel_PrfOut2.LastName, qMLabel_PrfOut2.CustomerID, qMLabel_PrfOut2.Address, qMLabel_PrfOut2.City, qMLabel_PrfOut2.State, qMLabel_PrfOut2.ZipCode, qMLabel_PrfOut2.EffDate, qMLabel_PrfOut2.Phone, qMLabel_PrfOut2.EMail, qMLabel_PrfOut2.SchoolID, CustomerListData.ListID
FROM qMLabel_PrfOut2 INNER JOIN CustomerListData ON qMLabel_PrfOut2.CustomerID = CustomerListData.CustomerID;

