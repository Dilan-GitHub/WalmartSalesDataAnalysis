-- Data cleaning 
SELECT *
  FROM [master].[dbo].[WalmartSalesData.csv];

-- Add the time_of_day column

SELECT 
    time,
    CASE 
        WHEN CAST(time AS TIME) BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN CAST(time AS TIME) BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_date
  FROM [master].[dbo].[WalmartSalesData.csv]

ALTER TABLE [master].[dbo].[WalmartSalesData.csv] ADD time_of_day VARCHAR(20);

UPDATE [master].[dbo].[WalmartSalesData.csv]
SET time_of_day = CASE 
                      WHEN CAST(time AS TIME) BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
                      WHEN CAST(time AS TIME) BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
                      ELSE 'Evening'
                  END;


-- Add day_name column

SELECT
    date,
    DATENAME(WEEKDAY, date) AS day_of_week
FROM [master].[dbo].[WalmartSalesData.csv];

ALTER TABLE [master].[dbo].[WalmartSalesData.csv] ADD day_name VARCHAR(10);

UPDATE [master].[dbo].[WalmartSalesData.csv]
SET day_name = DATENAME(WEEKDAY, date);

-- Add month_name column

SELECT
    date,
    DATENAME(MONTH, date) AS month_name
FROM [master].[dbo].[WalmartSalesData.csv];

ALTER TABLE [master].[dbo].[WalmartSalesData.csv]
ADD month_name VARCHAR(10);

UPDATE [master].[dbo].[WalmartSalesData.csv]
SET month_name = DATENAME(MONTH, date);

-- How many unique cities does the data have?

SELECT DISTINCT city 
FROM [master].[dbo].[WalmartSalesData.csv];

-- In which city is each branch?

SELECT DISTINCT city, branch 
FROM [master].[dbo].[WalmartSalesData.csv];

-- How many unique product lines does the data have?

SELECT DISTINCT product_line
FROM [master].[dbo].[WalmartSalesData.csv];

-- What is the most common payment method?

SELECT DISTINCT payment, COUNT(*) AS payment_method
FROM [master].[dbo].[WalmartSalesData.csv]
GROUP BY payment
ORDER BY payment_method DESC;

-- What is the most common product line?

SELECT DISTINCT product_line, COUNT(*) AS cnt
FROM [master].[dbo].[WalmartSalesData.csv]
GROUP BY product_line
ORDER BY cnt DESC;

-- What is the total number of sales transactions per month?

SELECT [month_name], COUNT(*) AS sales_by_month
FROM [master].[dbo].[WalmartSalesData.csv]
GROUP BY [month_name]
ORDER BY sales_by_month DESC;

-- What is the total revenue by month?

SELECT month_name, ROUND(SUM(Total), 2) AS revenue_total
FROM [master].[dbo].[WalmartSalesData.csv]
GROUP BY month_name
ORDER BY revenue_total DESC;

-- Which month had the largest cogs(cost of goods sold?)

SELECT month_name, ROUND(SUM(cogs), 2) AS cogs_total
FROM [master].[dbo].[WalmartSalesData.csv]
GROUP BY month_name
ORDER BY cogs_total DESC;

-- What product line had the largest revenue?

SELECT product_line, ROUND(SUM(total), 2) AS total_revenue
FROM [master].[dbo].[WalmartSalesData.csv]
GROUP BY product_line
ORDER BY total_revenue DESC;

-- Which city had the largest revenue?

SELECT branch, city, ROUND(SUM(total), 2) AS total_revenue
FROM [master].[dbo].[WalmartSalesData.csv]
GROUP BY city, branch
ORDER BY total_revenue DESC;

-- What was the average tax for each product line?

SELECT product_line,
       ROUND(AVG(Tax_5), 2) AS avg_tax
FROM [master].[dbo].[WalmartSalesData.csv]
GROUP BY product_line
ORDER BY avg_tax DESC;

-- Which branch sold more products than average products sold?

SELECT
branch,
SUM(quantity) AS qty
FROM [master].[dbo].[WalmartSalesData.csv]
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM [master].[dbo].[WalmartSalesData.csv]);

-- What is the most common product line by gender?

SELECT gender,
        product_line,
        COUNT(gender) AS total_cnt
FROM [master].[dbo].[WalmartSalesData.csv]
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

-- What is the average rating of each product line?

SELECT ROUND(AVG(rating), 2) AS avg_rating,
product_line
FROM [master].[dbo].[WalmartSalesData.csv]
GROUP BY product_line
ORDER BY avg_rating DESC;

-- Number of sales made in each time of the day per weekday

SELECT time_of_day, COUNT(*) AS total_sales
FROM [master].[dbo].[WalmartSalesData.csv]
WHERE day_name = 'Monday'
GROUP BY time_of_day
ORDER BY total_sales DESC;

-- Which customer type bring the most revenue?

SELECT customer_type,
ROUND(SUM(total), 2) AS total_revenue
FROM [master].[dbo].[WalmartSalesData.csv]
GROUP BY customer_type
ORDER BY total_revenue DESC;

-- Which city has the largest Tax/VAT?

SELECT city, 
ROUND(AVG(tax_5), 2) AS VAT
FROM [master].[dbo].[WalmartSalesData.csv]
GROUP BY city 
ORDER BY VAT DESC;

-- Which customer type pays the most in VAT?

SELECT customer_type,
ROUND(AVG(tax_5), 2) AS VAT
FROM [master].[dbo].[WalmartSalesData.csv]
GROUP BY customer_type
ORDER BY VAT DESC;

-- How many unique customer types are there in the data?

SELECT DISTINCT customer_type
FROM [master].[dbo].[WalmartSalesData.csv];

-- How many unique payment methods does the data have?

SELECT DISTINCT payment AS payment_method
FROM [master].[dbo].[WalmartSalesData.csv];

-- Which customer type makes the most purchases?

SELECT customer_type,
        COUNT(*) AS cstm_cnt
FROM [master].[dbo].[WalmartSalesData.csv]
GROUP BY customer_type;

-- What is the gender count of customers?

SELECT gender,
    COUNT(*) AS gender_cnt
FROM [master].[dbo].[WalmartSalesData.csv]
GROUP BY gender
ORDER BY gender_cnt DESC;

-- What is the gender distribution per branch?

SELECT gender, 
    COUNT(*) AS gender_cnt
    FROM [master].[dbo].[WalmartSalesData.csv]
    WHERE branch = 'A'
    GROUP BY gender
    ORDER BY gender_cnt DESC;

SELECT gender, 
    COUNT(*) AS gender_cnt
    FROM [master].[dbo].[WalmartSalesData.csv]
    WHERE branch = 'B'
    GROUP BY gender
    ORDER BY gender_cnt DESC;


SELECT gender, 
    COUNT(*) AS gender_cnt
    FROM [master].[dbo].[WalmartSalesData.csv]
    WHERE branch = 'C'
    GROUP BY gender
    ORDER BY gender_cnt DESC;

-- At what part of the day do customers give the highest rating?

SELECT time_of_day,
    AVG(rating) AS avg_rating
FROM [master].[dbo].[WalmartSalesData.csv]
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- At what part of the day do customers give the highest ratings for each branch?

SELECT time_of_day,
    AVG(rating) AS avg_rating
FROM [master].[dbo].[WalmartSalesData.csv]
WHERE branch = 'A'
GROUP BY time_of_day
ORDER BY avg_rating DESC;

SELECT time_of_day,
    AVG(rating) AS avg_rating
FROM [master].[dbo].[WalmartSalesData.csv]
WHERE branch = 'B'
GROUP BY time_of_day
ORDER BY avg_rating DESC;

SELECT time_of_day,
    AVG(rating) AS avg_rating
FROM [master].[dbo].[WalmartSalesData.csv]
WHERE branch = 'C'
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which day of the week has the highest average rating?

SELECT day_name,
    AVG(rating) AS avg_rating
FROM [master].[dbo].[WalmartSalesData.csv]
GROUP BY day_name
ORDER BY avg_rating DESC;

-- Which day of the week has the most profit?

SELECT day_name,
    SUM(gross_income) AS profit_per_day
FROM [master].[dbo].[WalmartSalesData.csv]
GROUP BY day_name
ORDER BY profit_per_day DESC;
