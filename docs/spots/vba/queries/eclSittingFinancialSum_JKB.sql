-- Query: eclSittingFinancialSum_JKB
SELECT eclSittingFinancailDetail.CustomerID AS Expr1, eclSittingFinancailDetail.Method AS Expr2, Sum(eclSittingFinancailDetail.Amount) AS SumOfAmount
FROM eclSittingFinancailDetail
GROUP BY eclSittingFinancailDetail.CustomerID, eclSittingFinancailDetail.Method;

