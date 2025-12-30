-- EDA Queries: Financial Behavior vs Subscription Likelihood
-- Dataset: Bank Marketing (cleaned)
-- Source table: `fintech.data`.bank_clean
-- Target: deposit_flag (1 = subscribed, 0 = not subscribed)

/*
STEP 11:
This confirms if we created that clean table and that the data within it exist
*/
SHOW TABLES FROM `fintech.data`;


SELECT COUNT(*) FROM `fintech.data`.bank_clean;
SELECT * FROM `fintech.data`.bank_clean LIMIT 10;

/*
STEP 12: QUERYING FOR FINANCIAL BEHAVIOR VS SUBSCRIPTION LIKELIHOOD
This shows overall customers, subscribers, and the conversion rate (%)
We need this as a baseline conversion rate to compare every segment against
*/
SELECT
  COUNT(*) AS customers,
  SUM(deposit_flag) AS subscribers,
  ROUND(100 * AVG(deposit_flag), 2) AS subscription_rate_pct
FROM `fintech.data`.bank_clean;

/*
STEP 13:
This tests whether subscribers have different balances than non-subscribers
It splits the dataset by subscription outcome and summarizes the balances through avg, min, and max
*/
SELECT
  deposit_flag,
  COUNT(*) AS n,
  ROUND(AVG(balance), 2) AS avg_balance,
  MIN(balance) AS min_balance,
  MAX(balance) AS max_balance
FROM `fintech.data`.bank_clean
GROUP BY deposit_flag;

/*
STEP 14:
This shows the subscription rate between customers of differing balance tiers (financial health)
The reason for the Order By Case is to show logical ordering instead of alphabetical
*/
SELECT
  balance_tier,
  COUNT(*) AS customers,
  ROUND(100 * AVG(deposit_flag), 2) AS subscription_rate_pct
FROM `fintech.data`.bank_clean
GROUP BY balance_tier
ORDER BY
  CASE balance_tier
    WHEN 'negative' THEN 1
    WHEN '0-999' THEN 2
    WHEN '1000-4999' THEN 3
    ELSE 4
  END;
  
/*
STEP 15:
This shows whether loan exposure correlates with subscription rate between customers
*/
SELECT
  debt_profile,
  COUNT(*) AS customers,
  ROUND(100 * AVG(deposit_flag), 2) AS subscription_rate_pct
FROM `fintech.data`.bank_clean
GROUP BY debt_profile
ORDER BY subscription_rate_pct DESC;

/*
STEP 16:
This goes more in depth by showing how both balance tier and debt profiles correlates with subscription rates
*/
SELECT
  balance_tier,
  debt_profile,
  COUNT(*) AS customers,
  ROUND(100 * AVG(deposit_flag), 2) AS subscription_rate_pct
FROM `fintech.data`.bank_clean
GROUP BY balance_tier, debt_profile
HAVING COUNT(*) >= 50
ORDER BY balance_tier, subscription_rate_pct DESC;
