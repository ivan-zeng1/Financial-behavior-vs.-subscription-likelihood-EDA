-- Data Cleaning Script: Bank Marketing Dataset
-- Purpose: Create an analysis-ready table from the raw data
-- Source table: `fintech.data`.bank
-- Output table: `fintech.data`.bank_clean

/*
STEP 5:
This removes the clean data if present and keeps the raw table untouched
*/
DROP TABLE IF EXISTS `fintech.data`.bank_clean;

/*
STEP 6:
This creates a new clean table without messing with the raw data table
NULLIF function turns unknown data to NULL so it doesn't appear as a misleading data because unknown is not real data
	Ex. unknown is not a job, marital status, education etc...
*/
CREATE TABLE `fintech.data`.bank_clean AS
SELECT
  age,
  balance,
  campaign,
  pdays,
  previous,
  duration,

  NULLIF(LOWER(TRIM(job)), 'unknown') AS job,
  NULLIF(LOWER(TRIM(marital)), 'unknown') AS marital,
  NULLIF(LOWER(TRIM(education)), 'unknown') AS education,
  NULLIF(LOWER(TRIM(contact)), 'unknown') AS contact,
  NULLIF(LOWER(TRIM(poutcome)), 'unknown') AS poutcome,
  NULLIF(LOWER(TRIM(month)), 'unknown') AS month,
  
/*
STEP 7:
Used CASE END statements to return different values based on those conditions
Based on whether it is yes/no it will return as 1/0 if neither, NULL
The reasoning for numeric flags is so it makes KPIs easy
	Housing flag = if customer has housing loan or not
	Loan flag = if customer has personal loan or not
	Deposit flag = if customer is subscribed or not
*/
  CASE
    WHEN LOWER(TRIM(housing)) = 'yes' THEN 1
    WHEN LOWER(TRIM(housing)) = 'no' THEN 0
    ELSE NULL
  END AS housing_flag,

  CASE
    WHEN LOWER(TRIM(loan)) = 'yes' THEN 1
    WHEN LOWER(TRIM(loan)) = 'no' THEN 0
    ELSE NULL
  END AS loan_flag,

  CASE
    WHEN LOWER(TRIM(deposit)) = 'yes' THEN 1
    WHEN LOWER(TRIM(deposit)) = 'no' THEN 0
    ELSE NULL
  END AS deposit_flag,

/*
STEP 8:
Binning balance here simplifies the raw number into readable insights(categories) while mitigating outliers in the data
*/
  CASE
    WHEN balance < 0 THEN 'negative'
    WHEN balance BETWEEN 0 AND 999 THEN '0-999'
    WHEN balance BETWEEN 1000 AND 4999 THEN '1000-4999'
    ELSE '5000+'
  END AS balance_tier,

/*
STEP 9:
This creates a debt profile for each person which is important because loan exposure matters in banking because it creates "risk/obligation" groups
What this CASE END statement essentially does is create a label based on loan status
*/
  CASE
    WHEN LOWER(TRIM(housing))='no' AND LOWER(TRIM(loan))='no'
      THEN 'no_debt'
    WHEN LOWER(TRIM(housing))='yes' AND LOWER(TRIM(loan))='no'
      THEN 'housing_only'
    WHEN LOWER(TRIM(housing))='no' AND LOWER(TRIM(loan))='yes'
      THEN 'personal_only'
    WHEN LOWER(TRIM(housing))='yes' AND LOWER(TRIM(loan))='yes'
      THEN 'housing_and_personal'
    ELSE 'unknown_debt'
  END AS debt_profile

/*
STEP 10:
This is the filter for the clean data which removes outliers like impossible ages or missing numberic values
*/
FROM `fintech.data`.bank
WHERE
  age BETWEEN 18 AND 100
  AND balance IS NOT NULL
  AND campaign IS NOT NULL
  AND campaign >= 1
  AND LOWER(TRIM(deposit)) IN ('yes','no');
