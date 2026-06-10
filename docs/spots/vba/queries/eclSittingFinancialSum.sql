-- Query: eclSittingFinancialSum
SELECT eclSittingFinancialDetail.CustomerID, eclSittingFinancialDetail.Method, Sum(eclSittingFinancialDetail.Amount) AS SumOfAmount
FROM eclSittingFinancialDetail
GROUP BY eclSittingFinancialDetail.CustomerID, eclSittingFinancialDetail.Method;

