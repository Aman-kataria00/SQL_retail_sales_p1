CREATE DATABASE sql_project;
use sql_project;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );
           
       -- Data Analysis & Business Key Problems & Answers
-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3

select *
from retail_sales
where category = "cothing"
and 
quantity >= 3;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category,
sum(total_sale) as net_sale,
count(*) as total_orders
from retail_sales
group by 1;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select 
round(avg(age),2) as avg_age
from retail_sales
where category = "beauty";

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT 
    *
FROM
    retail_sales
WHERE
    total_sale > '1000';

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select
 gender,
 category,
 count(*) as total_trans
 from retail_sales
 group by gender,category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select 
year(sale_date) as year,
month(sale_date) as month,
avg(total_sale) as avg_sale
from retail_sales
group by 1,2
order by 1,3 desc;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

select 
customer_id,
sum(total_sale) as total_sale
from retail_sales
group by 1
order by 2 desc
limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select 
category,
count(distinct customer_id ) as unique_customer
from 
retail_sales
group by category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <= 12, Afternoon Between 12 & 17, Evening >17)

with hourly_sales as
 (
SELECT * ,
CASE
WHEN extract(hour from sale_time)< 12 THEN "Morning"
WHEN extract(hour from sale_time) BETWEEN 12 AND 17 THEN "Afternoon"
ELSE "Evening"
END as shift
FROM retail_sales
)
select shift,
count(*) as total_orders

from hourly_sales
group by shift;

