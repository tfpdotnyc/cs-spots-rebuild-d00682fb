-- Query: tmpMLabels_CustList
SELECT tmpMLabels.Id, tmpMLabels.SortField, tmpMLabels.CustomerID, tmpMLabels.School, tmpMLabels.SchoolID, tmpMLabels.FirstName, tmpMLabels.LastName, tmpMLabels.Address, tmpMLabels.City, tmpMLabels.State, tmpMLabels.ZipCode, tmpMLabels.Phone, tmpMLabels.YBJobNumber, CustomerListData.ListID
FROM tmpMLabels INNER JOIN CustomerListData ON tmpMLabels.CustomerID = CustomerListData.CustomerID;

