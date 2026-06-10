-- Query: eclSittingFinancialCustList_JKB
SELECT CustomerListData.ListID, eclSittingFinancialSum.CustomerID, eclSittingFinancialSum.Method, eclSittingFinancialSum.SumOfAmount
FROM CustomerListData INNER JOIN eclSittingFinancialSum ON CustomerListData.CustomerID = eclSittingFinancialSum.CustomerID;

