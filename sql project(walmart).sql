/*Sales Analysis*/
/*1. Number of sales made in each time of the day per weekday*/

select *from sales;

select
   time_of_day,
   count(*) AS total_sales
from sales
WHERE day_name="MONDAY"
group by time_of_day
order by total_sales desc;

/*2. Which of the customer types brings the most revenue?*/
SELECT customer_type,
sum(total) AS total_rev
FROM sales
GROUP BY customer_type
order by total_rev DESC

/*3. Which city has the largest tax percent/ VAT (**Value Added Tax**)?*/
SELECT city,
    avg(VAT) as value_added_tax
from sales
group by city
order by value_added_tax desc;

/*4. Which customer type pays the most in VAT?*/
select
 customer_type,
    avg(VAT) as value_added_tax
from Sales
group by customer_type
order by value_added_tax desc;

/*Customer Analysis*/
/*How many unique customer types does the data have?*/
select
 distinct (customer_type)
from sales;

/*2. How many unique payment methods does the data have?*/
select
 distinct (payment_method)
from sales;

/*3. What is the most common customer type?*/

select
 customer_type,
    count(*) as total_count
from sales
group by customer_type
order by total_count;

/*4. Which customer type buys the most?*/
select
 customer_type,
    count(*) as total_count
from sales
group by customer_type
order by total_count;

/*5. What is the gender of most of the customers?*/
select
 gender,
    count(*) as gender_count
from sales
group by gender
order by gender_count desc;

/*6. What is the gender distribution per branch?*/
select
 gender,
    count(*) as gender_count
from sales
where branch = "C"
group by gender
order by gender_count desc;

/*7. Which time of the day do customers give most ratings?*/
select
 time_of_day,
    avg(rating) as avg_rating
from sales
group by time_of_day
order by avg_rating desc;

/* 8. Which time of the day do customers give most ratings per branch?*/
select
 time_of_day,
    branch,
    avg(rating) as avg_rating
from sales
group by time_of_day, branch
order by avg_rating ;


select
 time_of_day,
    avg(rating) as avg_rating
from sales
where branch = "C"
group by time_of_day
order by avg_rating ;

/* 9. Which day of the week has the best avg ratings?*/
select
 day_name,
    avg(rating) as avg_rating
from sales
group by day_name
order by avg_rating desc;

/* 10. Which day of the week has the best average ratings per branch?*/
select
 day_name,
    avg(rating) as avg_rating
from sales
where branch= "A"
group by day_name
order by avg_rating desc;


/* total(gross_sales) */
select
 sum(VAT+cogs) as total_grass_sales
from  sales;


/* gross profit*/
SELECT 
 SUM(VAT + COGS) - sum(COGS) 
FROM sales;

SELECT (SUM(ROUND(VAT, 2) + COGS) - COGS) FROM wmsales;