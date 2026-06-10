-- Query: qMLabel_NoAppts_CustList
SELECT qMLabel_NoAppts.School, qMLabel_NoAppts.FirstName, qMLabel_NoAppts.LastName, qMLabel_NoAppts.CustomerID, qMLabel_NoAppts.Address, qMLabel_NoAppts.City, qMLabel_NoAppts.State, qMLabel_NoAppts.ZipCode, qMLabel_NoAppts.EffDate, qMLabel_NoAppts.Phone, qMLabel_NoAppts.EMail, qMLabel_NoAppts.StudentID, qMLabel_NoAppts.YBJobNumber, CustomerListData.ListID
FROM qMLabel_NoAppts INNER JOIN CustomerListData ON qMLabel_NoAppts.CustomerID = CustomerListData.CustomerID;

