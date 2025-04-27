# SQL-Assignment
 
 PostgreSQL Data Exploration Project For International_Debt_Dataset

📌 Project Overview

This assignment involved:

Connecting to a PostgreSQL database using a provided connection string.

Exploring the structure and contents of the database.

Writing SQL queries to answer specific key questions.

🔗 Database Connection

I connected to the PostgreSQL database using DBeaver.

The connection information provided included:

Host: ``your_host_here``

Database Name: ``your_db_name_here``

Username: ``your_db_user_here``

Password: ``your_password_here``

Port: ``your_port_here``

Steps to Connect:

1. Opened DBeaver.

2. Clicked on New Database Connection and selected PostgreSQL. (Ctrl + Shift + N)

3. Entered the provided host, port, database name, username, and password.

4. Clicked Test Connection to ensure successful connection.

5. Saved the connection and started exploring the database.

🔍 Dataset Exploration

Before writing SQL queries to answer the key questions, I performed an initial exploration of the dataset.

1. Previewed the Data I retrieved a sample of the records to understand the structure of the table:

```sql
SELECT * 
FROM dataanalytics.international_debt_with_missing_values;
```
This allowed me to:

View all columns.

Understand the type of data available.

Identify any missing or null values visually.

2. Checked the Number of Rows To know the size of the dataset, I ran:

```sql
SELECT COUNT(*) 
FROM dataanalytics.international_debt_with_missing_values;
```
This provided the total number of rows in the table, giving me an idea of the dataset's scale.

🧠 Key Questions and Answers
Question 1: What is the total amount of debt owed by all countries in the dataset?
```sql
SELECT SUM(debt) AS total_debt
FROM dataanalytics.international_debt_with_missing_values;
```
Explanation:
I used the SUM() aggregate function on the debt column to calculate the total amount of debt owed by all countries combined.
This provides a single value representing the overall debt across the dataset.

Question 2: How many distinct countries are recorded in the dataset?
```sql
SELECT COUNT(DISTINCT country_name) AS distinct_countries
FROM dataanalytics.international_debt_with_missing_values;
```
Explanation:
I used the COUNT(DISTINCT column_name) function to count the number of unique country names recorded in the dataset.
This ensures that repeated country entries are only counted once.

Question 3: What are the distinct types of debt indicators, and what do they represent?
```sql
SELECT DISTINCT(indicator_name) AS types_of_debt_indicators
FROM dataanalytics.international_debt_with_missing_values;
```
Explanation:
I used the DISTINCT keyword on the indicator_name column to retrieve all unique debt indicators listed in the dataset.
This helps understand the various types of debt measurements and the categories they represent.

Question 4: Which country has the highest total debt, and how much does it owe?
```sql
SELECT country_name, MAX(debt) AS total_debt
FROM dataanalytics.international_debt_with_missing_values
GROUP BY country_name
ORDER BY total_debt DESC
LIMIT 1;
```
Explanation:
I grouped the dataset by country_name and used the MAX() function to find the maximum debt value for each country.
Then, I ordered the results in descending order using ORDER BY total_debt DESC and limited the output to just one result (LIMIT 1) —
giving the country with the highest total debt along with the amount owed.

Question 5: What is the average debt across different debt indicators?
```sql
SELECT indicator_name, AVG(debt) AS avg_debt_indicator
FROM dataanalytics.international_debt_with_missing_values
GROUP BY indicator_name;
```
Explanation:
I grouped the records by indicator_name and applied the AVG() function to calculate the average debt for each indicator.
This gives insights into the typical debt amount associated with each type of debt indicator.

Question 6: Which country has made the highest amount of principal repayments?
```sql
SELECT country_name,
       SUM(debt) AS total_debt
FROM dataanalytics.international_debt_with_missing_values
WHERE indicator_name LIKE 'Principal%' 
  AND debt IS NOT NULL
GROUP BY country_name
ORDER BY total_debt DESC
LIMIT 1;
```
Explanation:
I filtered the data using WHERE indicator_name LIKE 'Principal%' to focus on rows related to principal repayments.
Then, I summed the debt values for each country using the SUM() function and excluded NULL values to get accurate totals.
The query orders the results in descending order by total_debt and limits the result to just one — showing the country with the highest amount of principal repayments.

Question 7: What is the most common debt indicator across all countries?
```sql
SELECT indicator_name, COUNT(*) AS common_debt_indicator
FROM dataanalytics.international_debt_with_missing_values
WHERE indicator_name IS NOT NULL AND indicator_name <> ''
GROUP BY indicator_name
ORDER BY common_debt_indicator DESC
LIMIT 1;
```
OR

```sql
SELECT indicator_code, COUNT(*) AS common_debt_indicator
FROM dataanalytics.international_debt_with_missing_values
WHERE indicator_code IS NOT NULL AND indicator_code <> ''
GROUP BY indicator_code
ORDER BY common_debt_indicator DESC
LIMIT 1;
```
Explanation:
I ran two versions of this query.
In Option 1, I focused on indicator_name and counted the occurrences of each debt indicator using COUNT(*).
In Option 2, I used indicator_code instead of indicator_name, as the dataset might have these codes for the debt indicators.

Both queries exclude NULL or empty values from the count, ensuring only valid debt indicators are considered.
The results are ordered in descending order, with the most common debt indicator listed at the top.

Question 8: Identify any other key debt trends and summarize your findings.
```sql
SELECT 
  CASE
    WHEN indicator_name ILIKE '%official creditor%' THEN 'Official Creditors'
    WHEN indicator_name ILIKE '%bilateral%' THEN 'Bilateral'
    WHEN indicator_name ILIKE '%multilateral%' THEN 'Multilateral'
    WHEN indicator_name ILIKE '%bond%' THEN 'Bonds'
    WHEN indicator_name ILIKE '%commercial bank%' THEN 'Commercial Banks'
    WHEN indicator_name ILIKE '%private creditor%' THEN 'Private Creditors'
    WHEN indicator_name ILIKE '%interest%' THEN 'Interest Payments'
    WHEN indicator_name ILIKE '%principal%' THEN 'Principal Repayments'
    WHEN indicator_name ILIKE '%disbursement%' OR indicator_name ILIKE '%disburs%' THEN 'Disbursements'
    ELSE 'Other'
  END AS debt_category,
  SUM(debt) AS total_debt
FROM dataanalytics.international_debt_with_missing_values
WHERE indicator_name IS NOT NULL AND debt IS NOT NULL
GROUP BY debt_category
ORDER BY total_debt DESC;
```

OR
```sql
SELECT country_name, SUM(debt) AS total_debt
FROM dataanalytics.international_debt
GROUP BY country_name
ORDER BY total_debt DESC
LIMIT 5;
```
Explanation:
In Option 1, I used a CASE statement to categorize different debt indicators into broader categories, such as 'Official Creditors,' 'Bilateral,' and 'Commercial Banks.'
I then summed the total debt for each of these categories to identify key trends in the types of debt across the dataset.

In Option 2, I focused on identifying the top 5 countries with the highest total debt, providing a broader view of which countries are carrying the most significant debt burdens.

Both queries exclude NULL values for both indicator_name and debt.

📌 Conclusion
In this analysis, I explored the international debt dataset to answer several key questions about global debt trends. Through SQL queries, I was able to identify:

The total debt owed by all countries, highlighting the overall scale of global debt.

The number of distinct countries in the dataset, and the country with the highest total debt.

Insights into the most common debt indicators, and which countries have made the highest principal repayments.

Debt trends based on categories like official creditors, bilateral debts, and commercial banks.

These findings offer valuable insights into how different countries manage debt and which types of creditors are most involved in global lending.
