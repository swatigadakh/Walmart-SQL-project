/*Build a database*/
create database  if not exists  SalesDataWalmart;

/*Create table and insert the data.*/

Create table if not exists sales (
 invoice_id  varchar(30) Not null primary Key,
 branch  varchar (5) not null,
    city varchar (30) not null,
    customer_type varchar (30) not null,
    gender  varchar(10) not null,
    product_line varchar (100) not null,
    unit_price  decimal(10,2) not null,
    quantity int not null,
    VAT  float(6,4) not null,
    total decimal (12,4) not null,
    date datetime not null,
    time TIME not null,
    payment_method varchar (15)  not null, 
    cogs  decimal (10, 2) not null,
    gross_margin_pct float (11,9),
    gross_income decimal(12, 4) not null,
    rating float (2, 1)
);

/*Feature Engineering*/
--- time_of_day

select
   time,
   (case
	when `time` between "00:00:00" AND "12:00:00" then "Morning"
    when `time` between "12:01:00" AND "16:00:00" then "Afternoon"
    ELSE"Evening"
    END
   )AS time_of_date
from sales;

ALTER TABlE sales ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day=(
  case 
    when `time` between "00:00:00" and "12:00:00" then "Morning"
    when `time` between "12:01:00" and "16:00:00" then "Afternoon"
    else  "Evening" 
    end
);

/*2. Add a new column named `day_name` that contains the extracted days of the week on which 
the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the 
question on which week of the day each branch is busiest.*/

/*day_name*/
select date,
  DAYNAME(date) AS day_name
from sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales 
SET day_name=DAYNAME(DATE);

/*Add a new column named `month_name` that contains the extracted months of the year on which
 the given transaction took place (Jan, Feb, Mar). Help determine which month of the year 
 has the most sales and profit.*/
 
 SELECT date,MONTHNAME(date) from sales;
 
 ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);
 
 UPDATE sales 
 SET month_name=MONTHNAME(date);
 
 ----------------------------------------------------------------------
 /*How many unique cities does the data have?*/
 
 SELECT DISTINCT CITY FROM SALES;
 
 /*In which city is each branch?*/
 SELECT DISTINCT branch FROM SALES;
 
 SELECT DISTINCT CITY,
 BRANCH
 FROM SALES;
 
 ----------------------------------------------------------
 /*1. How many unique product lines does the data have?*/
 SELECT COUNT(DISTINCT PRODUCT_LINE) FROM SALES;

/*2. What is the most common payment method?*/
SELECT Payment_method,
 COUNT(Payment_method)FROM SALES
 Group by Payment_method;

/*3. What is the most selling product line?*/
SELECT Product_line,
 COUNT(Product_line)AS count
 FROM SALES
 GROUP BY Product_line
 ORDER BY count DESC;
 
/* 4. What is the total revenue by month?*/

SELECT 
  month_name AS Month,
  SUM(total) AS total_revenue
FROM sales
GROUP BY month_name
ORDER BY total_revenue;

/*5. What month had the largest COGS(cost of good source)?*/
select 
 month_name as month,
    sum(cogs) as cogs
from sales
group by month_name
order by cogs desc;

/*6. What product line had the largest revenue?*/
select 
 product_line,
    sum(total) as Total_revenue 
from sales
group by product_line
order by Total_revenue  desc;

/*7. What is the city with the largest revenue?*/
select 
 city,
    sum(total) as Total_revenue 
from sales
group by city
order by Total_revenue  desc;

/*8. What product line had the largest VAT(valueble_tax)?*/
select 
 product_line,
    sum(VAT) as Valueable_Tax
from sales
group by product_line
order by Valueable_Tax  desc;

/*10. Which branch sold more products than average product sold?*/
select 
 branch ,
    sum(quantity) as qty
from sales
group by branch
having sum(quantity) > (select  avg(quantity) from sales);
 
 /*11. What is the most common product line by gender?*/
 select
 gender,
    product_line,
    count(gender) as total_count
from sales
group by gender, product_line
order by total_count desc;


/*12. What is the average rating of each product line?*/
select
 round(avg (rating) , 2) as avg_rating,
    product_line
from sales
group by product_line
order by avg_rating desc;
select
 round(avg (rating) , 2) as avg_rating,
    product_line
from sales
group by product_line
order by avg_rating desc;