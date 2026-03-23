---- SQL retail sales analytics 
 CREATE DATABASE sql_project_p1;
 DROP TABLE IF EXISTS retail_sales;
 create table retail_sales(
							transactions_id INT PRIMARY KEY,
							sale_date DATE,
							
							customer_id INT,
							gender VARCHAR(15),
							age INT,
							category VARCHAR(15),
							quantiy INT,
							price_per_unit FLOAT,
							cogs FLOAT,
							total_sale FLOAT,
							sale_time TIME

						 );
select * from retail_sales;
-- data cleaning 
select * from retail_sales 
where 
transactions_id is null
or
sale_date is null
or
gender is null
or 
category is null
or
quantiy is null
or cogs is null
or total_sale is null
or sale_time is null

delete from retail_sales where transactions_id is null
or
sale_date is null
or
gender is null
or 
category is null
or
quantiy is null
or cogs is null
or total_sale is null
or sale_time is null

--data exploration

---- how many sales we have 
select count(*) as total_sale from retail_sales;

--- how many customers we have 
select count( customer_id) as total_sale from retail_sales;

--- how many unique customers we have 
select count(distinct customer_id) as total_sale from retail_sales;

select distinct category as total_sale from retail_sales;

---data analysis & business key problems


--1 sql query to retrive all coloumns for sales made on '2022-11-05'
select *
from retail_sales where sale_date = '2022-11-05';

--2 sql query to retrieve all transactions where category is clothing and the quantity sold is more than or equal to 4 in the month of nov-2022
select * from retail_sales 
where 
	category = 'Clothing'
	and quantiy>= 4
	and sale_date>= '2022-11-01'
	and sale_date< '2022-12-01';

--3 sql query to calculate the total_sales(total_sale) for each category
select 
	category,sum(total_sale) as total_sales, 
	count(*) as total_orders
	from retail_sales group by category;


--4 sql query to find the average age of customers who purchased items from beauty category
select round (avg(age), 2) as avg_sales 
from retail_sales 
where category = 'Beauty'

--5 sql query to find all the transaction where total_sale is greater than 1000
select * from retail_sales where total_sale > 1000;

--6 sql query to find the total number of transactions (transaction_id)made by each gender in each category 
select 
	category,
	gender,
	count(*) as total_trans from retail_sales
	group by 
		category,gender
		order by 1

--7 sql query to calculate the average sale for each month.find the best selling month in each year
SELECT year, month, total_sales
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        SUM(total_sale) AS total_sales,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY SUM(total_sale) DESC
        ) AS rank
    FROM retail_sales
    GROUP BY year, month
) sub
WHERE rank = 1;

---8 sql query to find the top 5 customers based on highest total sales 
select customer_id, 
sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc limit 5;

--9 write a sql query to find th enumber of unique customers who purchased items from each category
select category, 
count( distinct customer_id)as cnt_unique_customer
from retail_sales
group by category

----end of project---