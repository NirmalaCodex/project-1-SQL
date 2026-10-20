--SQL Retail Sales Analysis -P1 
CREATE DATABASE sql_project_p2 

--Create Table 
CREATE TABLE retails_sales(
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id	INT,
gender	VARCHAR(15),
age INT,
category VARCHAR(15), 
quantiy INT,
price_per_unit FLOAT,	
cogs	FLOAT,
total_sale FLOAT

);
SELECT * FROM retails_sales;

--DATA CLEANINGF
--DATA CLEANING
SELECT * FROM retails_sales 
WHERE transactions_id is NULL
OR 
sale_date IS NULL
OR 
sale_time IS NULL 
OR 
customer_id IS NULL
OR 
gender IS NULL
OR 
age IS NULL 
OR
category IS NULL 
OR 
quantiy IS NULL 
OR 
price_per_unit IS NULL
OR 
cogs IS NULL 
OR 
total_sale IS NULL ;

DELETE FROM retails_sales 
WHERE transactions_id is NULL
OR 
sale_date IS NULL
OR 
sale_time IS NULL 
OR 
customer_id IS NULL
OR 
gender IS NULL
OR 
age IS NULL 
OR
category IS NULL 
OR 
quantiy IS NULL 
OR 
price_per_unit IS NULL
OR 
cogs IS NULL 
OR 
total_sale IS NULL ;

SELECT * from retails_sales;

--DATA EXPLORATION 
--How many customer do we have ? 
SELECT COUNT( DISTINCT customer_id)  as totalCustomer
FROM retails_sales;

--How many catgory we have >? 
SELECT COUNT(DISTINCT category) AS TotalCategory 
FROM retails_sales;

--DATA ANALYSIS AND Business key analysis 
--Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT * from retails_sales 
WHERE sale_date = '2022-11-05';

--Write a SQL to retrieve ll transaction where the category is 'Clothing' and the quantity sold is more than 10 in the month of
--Nov-2022
SELECT * FROM retails_sales 
WHERE category ='Clothing'
AND quantiy >2
AND TO_CHAR (sale_date,'YYYY-MM') ='2022-11';

--Ques 3. Write a SQL query to calculate the total sale for each category 
SELECT category, SUM(total_sale) AS totalSale,COUNT(*) AS totalORders 
FROM retails_sales 
GROUP BY category;

-- Write a SQL query to find out  average age of cutsomers who purchased items from the 'Beauty' category
SELECT  Round(Avg (age),2)  AS AvgAge , 
category , COUNT(*) AS totalCount 
FROM retails_sales 
WHERE category = 'Beauty'
GROUP BY category; 

-- Ques 5 Write a SQL query to find all transactions where the total sales is greater than 1000;
SELECT *  FROM retails_sales 
WHERE total_sale >1000

-- Ques 6  Write a SQL query to find out the total number of transaction made by each gender in each category 
SELECT gender, category,COUNT(transactions_id) as CountTransaction
FROM retails_sales 
GROUP BY gender, category
ORDER BY 1;

--Ques 7 Write a SQL query to calculate the average sale for each month. Find out best selling month each year 

SELECT TO_CHAR(sale_date,'YYYY-MM') ,AVG(total_sale) AS AvgSales
FROM retails_sales 
GROUP BY TO_CHAR(sale_date,'YYYY-MM')
ORDER BY AVG(total_sale) DESC
LIMIT 1;

--Find out best selliing month each year 
SELECT year,month,avg_sale 
FROM ( SELECT 
EXTRACT(YEAR FROM sale_date) AS year,
EXTRACT (Month FROM sale_date) AS month,
AVG(total_sale)as avg_sale,
RANK() OVER(
PARTITION BY EXTRACT(YEAR FROM sale_date) 
ORDER BY AVG(total_sale) DESC) AS rnk
FROM retails_sales
GROUP BY EXTRACT(YEAR FROM sale_date),
EXTRACT (MONTH FROM sale_date))
AS MonthlySales
WHERE rnk = 1
ORDER BY year

--Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id ,SUM(total_sale) AS highSales 
FROM retails_sales 
GROUP BY customer_id
ORDER BY SUM(total_sale)  DESC
LIMIT 5;



--Write a SSQL query to find out number of unique customers who purchased items from each category 
SELECT category, COUNT(DISTINCT customer_id) AS customers
FROM retails_sales 
GROUP BY 1

--Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17 , Evening >17)
SELECT CASE 
WHEN EXTRACT (HOUR FROM sale_time) <=12 THEN 'Morning' 
WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 13 AND 17 THEN 'AFTERNOON' 
ELSE 'Evening' 
END AS Shift, 
COUNT (transactions_id) AS TotalOrder
FROM retails_sales 
GROUP BY 1;

--END OF THE PROJECT 