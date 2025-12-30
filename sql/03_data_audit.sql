-- Data Audit: Bank Marketing Dataset
-- Purpose: Validate raw data quality before cleaning and analysis
-- Source table: `fintech.data`.bank

/* 
STEP 1:
This confirms that the raw table exists while also showing a baseline row count to compare back to after cleaning
We limit this to 10, so we don't have thousands of rows, because we only need to see what the rows look like and confirm the table isn't empty
*/
SHOW TABLES 
FROM `fintech.data`;
SELECT COUNT(*) 
FROM `fintech.data`.bank;
SELECT * 
FROM `fintech.data`.bank LIMIT 10;
 
 /*
 STEP 2:
 Describe is a statement used to retrieve the column names and data types within the columns, and shows whether they contain nulls or not
 This gives us an idea of how to clean our data later on
 */
DESC `fintech.data`.bank;

/*
STEP 3:
TRIM and LOWER function is used to remove spaces and handle capitalizations
SUM adds up all unknown values within the column
What this does is it shows how many unknowns are within each column, and this leads to how we clean our data later on
*/
SELECT
  SUM(LOWER(TRIM(job)) = 'unknown') AS job_unknowns,
  SUM(LOWER(TRIM(education)) = 'unknown') AS education_unknowns,
  SUM(LOWER(TRIM(marital)) = 'unknown') AS marital_unknowns,
  SUM(LOWER(TRIM(housing)) = 'unknown') AS housing_unknowns,
  SUM(LOWER(TRIM(loan)) = 'unknown') AS loan_unknowns,
  SUM(LOWER(TRIM(deposit)) = 'unknown') AS deposit_unknowns
FROM `fintech.data`.bank;

/*
STEP 4:
This project is an EDA, and based on previous information found, I determined that the columns needed are balance and campaign
	- Campaign means how many times the bank has contacted the customer
This shows the summarized ranges, so I know what filters are needed
*/
SELECT
  MIN(age) AS min_age, MAX(age) AS max_age,
  MIN(balance) AS min_balance, MAX(balance) AS max_balance,
  MIN(campaign) AS min_campaign, MAX(campaign) AS max_campaign
FROM `fintech.data`.bank;
