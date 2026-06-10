-- Query: eclSittingFinancialCustList
SELECT CustomerListData.ListID, eclSittingFinancialSum.CustomerID, eclSittingFinancialSum.Method, eclSittingFinancialSum.SumOfAmount
FROM CustomerListData INNER JOIN eclSittingFinancialSum ON CustomerListData.CustomerID = eclSittingFinancialSum.CustomerID;

