USE bank_churn_project;
SELECT COUNT(*) FROM churn;
SELECT COUNT(*) AS total_rows, COUNT(DISTINCT CustomerId) AS unique_customers FROM churn;
SELECT VERSION();
SELECT COUNT(*) - COUNT(CreditScore) AS missing_credit,
       COUNT(*) - COUNT(Geography)   AS missing_geo,
       COUNT(*) - COUNT(Age)         AS missing_age,
       COUNT(*) - COUNT(Balance)     AS missing_balance,
       COUNT(*) - COUNT(Exited)      AS missing_exited
FROM churn;
SELECT MIN(CreditScore), MAX(CreditScore), MIN(Age), MAX(Age),
       MIN(Tenure), MAX(Tenure), MIN(NumOfProducts), MAX(NumOfProducts) FROM churn;
       SELECT DISTINCT Geography FROM churn;
SELECT DISTINCT Gender FROM churn;
SELECT COUNT(*) AS customers, SUM(Exited) AS churned,
       ROUND(AVG(Exited)*100,2) AS churn_rate_pct
FROM churn;
SELECT Geography, COUNT(*) AS customers, SUM(Exited) AS churned,
       ROUND(AVG(Exited)*100,2) AS churn_rate_pct
FROM churn GROUP BY Geography ORDER BY churn_rate_pct DESC;
SELECT Gender, COUNT(*) AS customers, ROUND(AVG(Exited)*100,2) AS churn_rate_pct
FROM churn GROUP BY Gender;
SELECT CASE WHEN Age < 30 THEN '18-29'
            WHEN Age < 40 THEN '30-39'
            WHEN Age < 50 THEN '40-49'
            WHEN Age < 60 THEN '50-59'
            ELSE '60+' END AS age_band,
       COUNT(*) AS customers, ROUND(AVG(Exited)*100,2) AS churn_rate_pct
FROM churn GROUP BY age_band ORDER BY age_band;
SELECT NumOfProducts, COUNT(*) AS customers, ROUND(AVG(Exited)*100,2) AS churn_rate_pct
FROM churn GROUP BY NumOfProducts ORDER BY NumOfProducts;
SELECT IsActiveMember, COUNT(*) AS customers, ROUND(AVG(Exited)*100,2) AS churn_rate_pct
FROM churn GROUP BY IsActiveMember;
SELECT Geography, ROUND(SUM(Balance),2) AS balance_at_risk
FROM churn WHERE Exited = 1
GROUP BY Geography ORDER BY balance_at_risk DESC;
SELECT Geography, age_band, customers, churn_rate_pct,
       RANK() OVER (PARTITION BY Geography ORDER BY churn_rate_pct DESC) AS rank_in_country
FROM (
  SELECT Geography,
         CASE WHEN Age < 30 THEN '18-29' WHEN Age < 40 THEN '30-39'
              WHEN Age < 50 THEN '40-49' WHEN Age < 60 THEN '50-59'
              ELSE '60+' END AS age_band,
         COUNT(*) AS customers,
         ROUND(AVG(Exited)*100,2) AS churn_rate_pct
  FROM churn GROUP BY Geography, age_band) t;
DROP TABLE IF EXISTS targets;
CREATE TABLE targets (Geography VARCHAR(20), target_pct DECIMAL(5,2));
INSERT INTO targets VALUES ('France',15),('Germany',20),('Spain',15);
SELECT c.Geography,
       ROUND(AVG(c.Exited)*100,2) AS actual_pct,
       t.target_pct,
       ROUND(AVG(c.Exited)*100 - t.target_pct,2) AS vs_target_pts
FROM churn c
JOIN targets t ON c.Geography = t.Geography
GROUP BY c.Geography, t.target_pct;
SELECT * FROM targets;