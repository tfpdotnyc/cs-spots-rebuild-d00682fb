-- Query: tmpMLabelsDateTime_CustList
SELECT tmpMLabelsDateTime.Id, tmpMLabelsDateTime.SortField, tmpMLabelsDateTime.DateTime, tmpMLabelsDateTime.CustomerID, tmpMLabelsDateTime.School, tmpMLabelsDateTime.SchoolID, tmpMLabelsDateTime.FirstName, tmpMLabelsDateTime.LastName, tmpMLabelsDateTime.Address, tmpMLabelsDateTime.City, tmpMLabelsDateTime.State, tmpMLabelsDateTime.ZipCode, tmpMLabelsDateTime.Phone, tmpMLabelsDateTime.YBJobNumber, CustomerListData.ListID
FROM tmpMLabelsDateTime INNER JOIN CustomerListData ON tmpMLabelsDateTime.CustomerID = CustomerListData.CustomerID;

