-- Create table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
		(
		transactions_id	INT PRIMARY KEY,
		sale_date DATE,
		sale_time TIME,
		customer_id	INT,
		gender VARCHAR(15),
		age	INT,
		category VARCHAR(15),
		quantity INT,
		price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT
		)
SELECT * FROM retail_sales
-- No data showing as we need to import the data
-- From the database right click on the table 
-- Import data -- select file path for data table

SELECT * FROM retail_sales

-- UNDERSTANDING OUR DATA -- 

-- Checking total rows to compare to origonal data
-- By doing this we can confirm all data imported
-- This cal also be done by looking at total rows on the bottom left
SELECT
	COUNT(*)
FROM retail_sales

-- Seeing what NULL values we have in each column
SELECT * FROM retail_sales
WHERE transactions_id IS NULL

SELECT * FROM retail_sales
WHERE sale_date IS NULL

-- There is a quicker way to do this
-- Instead of checking each column individually
-- We can check them all at once using OR
SELECT * FROM retail_sales
WHERE transactions_id IS NULL
OR
sale_date IS NULL
OR
gender IS NULL
OR
age IS NULL
OR
category IS NULL
OR
quantity IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL

-- Removing NULL values
DELETE FROM retail_sales
WHERE transactions_id IS NULL
OR
sale_date IS NULL
OR
gender IS NULL
OR
age IS NULL
OR
category IS NULL
OR
quantity IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL

-- Checking how many rows of data we have left
SELECT
	COUNT(*)
FROM retail_sales

-- DATA EXPLORATION -- 
-- How many sales we have
SELECT COUNT(*) as total_sales FROM retail_sales

-- How many unique customers we have
SELECT COUNT(DISTINCT customer_id) as customer_ttl FROM retail_sales

-- How many unique catogorys we have
SELECT COUNT (DISTINCT category) as category_ttl FROM retail_sales
-- What the categorys are
SELECT DISTINCT category FROM retail_sales


-- Data Analysis & Business Key Problems & Answers --

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Show all relevant data
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05'

-- Show the number of sales
SELECT COUNT(*) AS number_of_sales
FROM retail_sales
WHERE sale_date = '2022-11-05' 

-- Show the total revenue for sales this day
SELECT SUM(total_sale) AS revenue_ttl
FROM retail_sales
WHERE sale_date = '2022-11-05' 


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
SELECT *
FROM retail_sales
	WHERE category = 'Clothing'
	AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	AND quantity >= 3

-- How many sales fall into this group?
SELECT COUNT(*) AS nov_high_vol_clothing_sales
FROM retail_sales
	WHERE category = 'Clothing'
	AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	AND quantity >= 3

-- Total revenue in this group
SELECT SUM(total_sale) AS revenue_nov_high_vol_clothing_sales
FROM retail_sales
	WHERE category = 'Clothing'
	AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	AND quantity >= 3

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
	category, 
	COUNT (*) as total_orders,
	SUM(total_sale) as revenue_ttl
FROM retail_sales
GROUP BY category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
	ROUND(AVG(age),2) as avg_beauty_age 
FROM retail_sales
WHERE category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM retail_sales
WHERE total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT
	category,
	gender,
	COUNT(*) as ttl_trans
FROM retail_sales
GROUP BY 
	category,
	gender
ORDER BY category

-- Q.7 Write a SQL query to calculate the average sale for each month. 
SELECT
	EXTRACT(YEAR FROM sale_date) as year,
	EXTRACT(MONTH FROM sale_date) as month,
	AVG(total_sale) as avg_sale
FROM retail_sales
GROUP BY YEAR, MONTH
ORDER BY YEAR, avg_sale DESC

-- Find out best selling month in each year
SELECT * FROM
	(SELECT
		EXTRACT(YEAR FROM sale_date) as year,
		EXTRACT(MONTH FROM sale_date) as month,
		AVG(total_sale) as avg_sale,
		RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC ) as rank
	FROM retail_sales
	GROUP BY YEAR, MONTH
	) as t1
WHERE rank = 1


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
SELECT
	customer_id,
	SUM(total_sale) as ttl_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT
	category,
	COUNT(DISTINCT customer_id) as cnt_unique_cx
FROM retail_sales
GROUP BY category


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sales
AS
	(
	SELECT *,
		CASE
			WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
			WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
		END as shift
	FROM retail_sales
	)
SELECT
	shift,
	COUNT(*) as ttl_orders
FROM hourly_sales
GROUP BY shift

-- END OF PROJECT -- 