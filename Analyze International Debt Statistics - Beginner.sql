/*
Humans not only take debts to manage necessities. A country may also take debt to manage its economy. For example,
infrastructure spending is one costly ingredient required for a country's citizens to lead comfortable lives.
The World Bank is the organization that provides debt to countries.

In this project, you are going to analyze international debt data collected by The World Bank. The dataset contains
information about the amount of debt (in USD) owed by developing countries across several categories. You are going to
find the answers to the following questions:

What is the number of distinct countries present in the database?
What country has the highest amount of debt?
What country has the lowest amount of repayments?
Below is a description of the table you will be working with:

international_debt table
Column	Definition	Data Type
country_name	Name of the country	varchar
country_code	Code representing the country	varchar
indicator_name	Description of the debt indicator	varchar
indicator_code	Code representing the debt indicator	varchar
debt	Value of the debt indicator for the given country (in current US dollars)	float
You will execute SQL queries to answer three questions, as listed in the instructions.
*/

/*
PART ONE:

What is the number of distinct countries present in the database? The output should be single row and column aliased as total_distinct_countries.
Save the query as num_distinct_countries
*/

SELECT COUNT(DISTINCT country_name) AS total_distinct_countries
FROM international_debt

/*
PART TWO:

What country has the highest amount of debt? Your output should contain two columns: country_name and total_debt and one row. Save the query as highest_debt_country.
*/

SELECT country_name, SUM(debt) AS total_debt 
FROM international_debt 
GROUP BY country_name
ORDER BY sum(debt) DESC
LIMIT 1;

/*
PART THREE:

What country has the lowest amount of principal repayments (indicated by the "DT.AMT.DLXF.CD" indicator code)?
The output table should contain three columns: country_name, indicator_name, and lowest_repayment and one row, saved in the query lowest_principal_repayment.
*/


SELECT country_name, indicator_name, MIN(debt) AS lowest_repayment
FROM international_debt 
WHERE indicator_code = 'DT.AMT.DLXF.CD'
GROUP BY country_name, indicator_name
ORDER BY lowest_repayment
LIMIT 1;



