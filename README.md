# Financial behavior vs. subscription likelihood EDA

This project explores how customer **financial behavior and marketing exposure** influence the likelihood of subscribing to a term deposit product. Using SQL for data cleaning and exploratory analysis, and Tableau for visualization, the project translates raw banking data into actionable business insights.

---

## Business Question
**Which financial and behavioral factors are associated with higher subscription likelihood for term deposit products?**

Specifically, the analysis examines:
- Account balance levels
- Debt exposure (housing and personal loans)
- Marketing campaign intensity
- Differences between subscribers and non-subscribers

---

## Dataset
- **Source:** Kaggle - Bank Marketing Dataset
  https://www.kaggle.com/datasets/janiobachmann/bank-marketing-dataset
- **Description:** Customer demographics, financial attributes, marketing contact history, and term deposit subscription outcome
- **Note:** The raw dataset is not included in this repository due to licensing; SQL scripts assume the raw table is already imported into MySQL.

---

## Tech Stack
- **SQL:** MySQL (data audit, cleaning, feature engineering, EDA)
- **Visualization:** Tableau
- **Version Control:** Git and GitHub

---

## Data Cleaning and Feature Engineering
Key cleaning steps include:
- Standardizing categorical values using 'LOWER()' and 'TRIM()'
- Converting '"unknown"' values to 'NULL'
- Creating binary flags for subscription and loan status
- Filtering unrealistic or invalid records (e.g., age range, missing numeric values)
- Engineering features such as:
  - Balance tiers
  - Debt profile categories
  - Subscription indicator ('deposit_flag')

---

## Exploratory Data Analysis
The EDA focuses on **financial behavior vs subscription likelihood**, including:

- Overall subscription rate
- Subscription rate by **account balance tier**
- Subscription rate by **debt profile**
- Relationship between **campaign intensity** and subscription likelihood
- Comparison of **average account balances** between subscribers and non-subscribers

SQL queries used for analysis are included in the '/sql' folder.

---

## Interactive Dashboard
An interactive Tableau dashboard visualizes the key findings and allows users to:
- Filter views by customer segments
- Compare subscription rates across financial profiles
- Explore campaign's effectiveness
