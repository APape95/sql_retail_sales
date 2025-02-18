## 🛍️ Retail Sales Analysis SQL Project  

### 🚀 Project Overview  
In this project, I showcase my SQL skills by exploring, cleaning, and analyzing retail sales data. I set up a retail sales database, perform exploratory data analysis (EDA), and write SQL queries to answer key business questions. This project demonstrates my ability to work with real-world sales data and extract meaningful insights.  

### 🎯 Project Objectives  
- **🛠️ Database Setup**: Create and populate a retail sales database with structured data.  
- **🧹 Data Cleaning**: Identify and remove records with missing or null values.  
- **📊 Exploratory Data Analysis (EDA)**: Understand dataset patterns and trends.  
- **📈 Business Insights**: Answer specific business questions using SQL queries.  

---

## 📂 Project Structure  

### 🔹 1. Database Setup  
- **Database Creation**: Initializing `p1_retail_db`.  
- **Table Creation**: Creating `retail_sales` with key fields such as transaction ID, sale date, customer details, product category, and financial metrics.  

```sql
CREATE DATABASE p1_retail_db;

DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

### 🔹 2. Data Exploration & Cleaning  
- **📌 Total Record Count**:  
```sql
SELECT COUNT(*) FROM retail_sales;
```
- **🆔 Unique Customer Count**:  
```sql
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
```
- **🛒 Product Categories**:  
```sql
SELECT DISTINCT category FROM retail_sales;
```
- **🚨 Null Value Check & Removal**:  
```sql
DELETE FROM retail_sales
WHERE sale_date IS NULL OR customer_id IS NULL OR category IS NULL;
```

### 🔹 3. Data Analysis & Insights  
The following SQL queries help extract business insights:  

📅 **Sales on a Specific Date**  
```sql
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';
SELECT COUNT(*) FROM retail_sales WHERE sale_date = '2022-11-05';
SELECT SUM(total_sale) FROM retail_sales WHERE sale_date = '2022-11-05';
```

👕 **High-Volume Clothing Sales in November**  
```sql
SELECT * FROM retail_sales WHERE category = 'Clothing' AND quantity >= 3 AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';
```

📈 **Total Sales by Category**  
```sql
SELECT category, COUNT(*) AS total_orders, SUM(total_sale) AS revenue FROM retail_sales GROUP BY category;
```

💰 **Top 5 Highest-Spending Customers**  
```sql
SELECT customer_id, SUM(total_sale) AS total_spent FROM retail_sales GROUP BY customer_id ORDER BY total_spent DESC LIMIT 5;
```

⏳ **Sales Trends by Month**  
```sql
SELECT EXTRACT(YEAR FROM sale_date) AS year, EXTRACT(MONTH FROM sale_date) AS month, AVG(total_sale) AS avg_sale 
FROM retail_sales GROUP BY year, month ORDER BY year, avg_sale DESC;
```

🕒 **Sales by Time of Day (Shift Analysis)**  
```sql
WITH hourly_sales AS (
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT shift, COUNT(*) AS total_orders FROM hourly_sales GROUP BY shift;
```

---

## 🔍 Key Findings  
- **🧑‍🤝‍🧑 Customer Demographics**: Sales span across diverse age groups and product categories.  
- **💸 High-Value Transactions**: Identified premium purchases exceeding $1000.  
- **📆 Sales Trends**: Monthly sales variations indicate peak seasons.  
- **🏆 Customer Insights**: Recognized top-spending customers and best-selling categories.  

## 📊 Reports  
- **📄 Sales Summary**: Total sales, customer demographics, and category performance.  
- **📅 Trend Analysis**: Sales trends across different months and shifts.  
- **🛍️ Customer Insights**: Top customers and unique customer counts per category.  

## 🏁 Conclusion  
Through this project, I demonstrated SQL expertise in database setup, data cleaning, EDA, and business-driven queries. These insights help businesses optimize sales strategies, understand customer behavior, and boost performance.  

📬 **Get in Touch!**  
💌 Email: A-C.1995@outlook.com  
🌐 Portfolio: [Amy Pape's Portfolio](#)  
🔗 LinkedIn: [Amy Pape](#)  
