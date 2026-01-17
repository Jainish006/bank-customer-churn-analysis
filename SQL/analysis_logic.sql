CREATE TABLE bank_churn (
    RowNumber INT,
    CustomerId INT PRIMARY KEY, -- Unique ID for each customer
    Surname VARCHAR(50),
    CreditScore INT,
    Geography VARCHAR(50),
    Gender VARCHAR(20),
    Age INT,
    Tenure INT,
    Balance NUMERIC(15, 2), -- Using numeric for financial accuracy
    NumOfProducts INT,
    HasCrCard INT,           -- 1 = Yes, 0 = No
    IsActiveMember INT,      -- 1 = Active, 0 = Inactive
    EstimatedSalary NUMERIC(15, 2),
    Exited INT               -- 1 = Churned, 0 = Stayed (Our Target)
);


SELECT *
FROM bank_churn
LIMIT 10;


SELECT 
    Geography,
    COUNT(*) AS total_customers,
    SUM(exited) AS total_churned,
    -- Multiplying by 100.0 automatically converts it to a decimal
    ROUND((SUM(exited) * 100.0 / COUNT(*)), 2) AS churn_rate
FROM bank_churn
GROUP BY Geography
ORDER BY churn_rate DESC;


SELECT 
    CustomerId, 
    Surname, 
    Geography, 
    Balance,
    CreditScore
FROM bank_churn
WHERE Balance > (SELECT AVG(Balance) FROM bank_churn) 
  AND Exited = 0 
  AND IsActiveMember = 0
ORDER BY Balance DESC; -- Biggest "whales" first



SELECT 
    NumOfProducts, 
    COUNT(*) AS total_customers,
    SUM(Exited) AS total_churned,
    ROUND((SUM(Exited) * 100.0 / COUNT(*)), 2) AS churn_rate_pct
FROM bank_churn
GROUP BY NumOfProducts
ORDER BY NumOfProducts;



SELECT 
    CASE 
        WHEN Age < 30 THEN 'Young Adult'
        WHEN Age BETWEEN 30 AND 50 THEN 'Adult'
        WHEN Age > 50 THEN 'Senior'
    END AS Age_Group,
    COUNT(*) AS total_customers,
    SUM(Exited) AS total_churned,
    ROUND((SUM(Exited) * 100.0 / COUNT(*)), 2) AS churn_rate_pct
FROM bank_churn
GROUP BY Age_Group
ORDER BY churn_rate_pct DESC;


WITH RankedWhales AS (
    SELECT 
        CustomerId, 
        Surname, 
        Geography, 
        Balance,
        -- This ranks customers within each country by balance
        DENSE_RANK() OVER(PARTITION BY Geography ORDER BY Balance DESC) as rank_in_country
    FROM bank_churn
    WHERE Exited = 0 AND IsActiveMember = 0 -- Still here but inactive
)
SELECT * FROM RankedWhales
WHERE rank_in_country <= 5;


CREATE OR REPLACE VIEW v_bank_churn_analysis AS
SELECT 
    CustomerId,
    Surname,
    CreditScore,
    Geography,
    Gender,
    Age,
    -- Age Bucketing (From our previous SQL exercise)
    CASE 
        WHEN Age < 30 THEN 'Young Adult'
        WHEN Age BETWEEN 30 AND 50 THEN 'Adult'
        ELSE 'Senior' 
    END AS Age_Group,
    Tenure,
    Balance,
    NumOfProducts,
    -- Changing 0/1 to readable text
    CASE WHEN HasCrCard = 1 THEN 'Credit Card' ELSE 'No Credit Card' END AS Credit_Card_Status,
    CASE WHEN IsActiveMember = 1 THEN 'Active' ELSE 'Inactive' END AS Activity_Status,
    EstimatedSalary,
    -- The Target Label
    CASE WHEN Exited = 1 THEN 'Churned' ELSE 'Retained' END AS Churn_Status,
    Exited -- Keep the numeric version for DAX calculations
FROM bank_churn;


