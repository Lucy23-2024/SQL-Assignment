select * from dataanalytics.international_debt_with_missing_values;

 -- check the number of rows that we have in our table
select count(*) from dataanalytics.international_debt_with_missing_values;

--- What is the total amount of debt owed by all countries in the dataset?
select sum(debt) as total_debt
from dataanalytics.international_debt_with_missing_values;

 --- How many distinct countries are recorded in the dataset?
select count(distinct country_name) as distinct_countries
from dataanalytics.international_debt_with_missing_values;

--- What are the distinct types of debt indicators, and what do they represent?
select distinct (indicator_name) as types_of_debt_indicators
from dataanalytics.international_debt_with_missing_values;

----- Which country has the highest total debt, and how much does it owe?
select country_name, max(debt) as total_debt
from dataanalytics.international_debt_with_missing_values
group by country_name
order by total_debt desc
limit 1;

select country_name, max(debt) as total_debt
from dataanalytics.international_debt_with_missing_values
group by country_name;


--- What is the average debt across different debt indicators?
select indicator_name, avg(debt) as avg_debt_indicator
from dataanalytics.international_debt_with_missing_values
group by indicator_name;

 --- Which country has made the highest amount of principal repayments?
select country_name,
sum(debt) as total_debt
from dataanalytics.international_debt_with_missing_values
where indicator_name like 'Principal%' and debt is not null
group by country_name
order by total_debt desc
limit 1;

select distinct country_name,
sum(coalesce(debt, 0)) AS total_debt
from dataanalytics.international_debt_with_missing_values
where indicator_name like '%Principal repayment%'
group by country_name
order by total_debt desc
limit 1;

select distinct country_name,
sum(debt) as total_debt
from dataanalytics.international_debt_with_missing_values
group by country_name
order by sum(debt) desc
limit 1;

 --- What is the most common debt indicator across all countries?
select indicator_name,count (*) as common_debt_indicator
from dataanalytics.international_debt_with_missing_values
where indicator_name is not null
group by indicator_name
order by common_debt_indicator desc
limit 1;

SELECT indicator_name, COUNT(*) AS common_debt_indicator
FROM dataanalytics.international_debt_with_missing_values
WHERE indicator_name IS NOT NULL AND indicator_name <> ''
GROUP BY indicator_name
ORDER BY common_debt_indicator DESC
LIMIT 1;

select indicator_code, count (*) as common_debt_indicator
from dataanalytics.international_debt_with_missing_values
group by indicator_code
order by common_debt_indicator desc
limit 1;

SELECT indicator_code, COUNT(*) AS common_debt_indicator
FROM dataanalytics.international_debt_with_missing_values
WHERE indicator_code IS NOT NULL AND indicator_code <> '' -- This ensures that both NULLs and empty strings are excluded
GROUP BY indicator_code
ORDER BY common_debt_indicator DESC
LIMIT 1;

 --- Identify any other key debt trends and summarize your findings.
select country_name, sum(debt) as total_debt
from dataanalytics.international_debt
group by country_name
order by total_debt desc
limit 5;

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
