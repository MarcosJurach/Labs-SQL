use sakila;

-- Get number of monthly active customers.
select * from customer;
select * from rental;

-- Find the customer_activity
create or replace view customer_activity as
select customer_id, rental_date as activity_date,
month(rental_date) as activity_month,
year(rental_date) as activity_year
from rental;

select * from customer_activity;

-- Find the montly active customers. We are also including year just to be sure that the active customers are unique per year as well. Basically, as reference. 
create or replace view monthly_active_customers as
select activity_month, activity_year, count(distinct customer_id) as active_customers
from customer_activity
group by activity_year, activity_month
order by activity_year, activity_month;

select * from monthly_active_customers;

-- Active users in the previous month.

select activity_year, activity_month, active_customers,
lag(active_customers) over (order by activity_year, activity_month) as previous_month_customers
from monthly_active_customers;

-- Percentage change in the number of active customers.

-- Find the difference of monthly customers.
create or replace view difference_monthly_active_customers as
  with cte_view as (
	select activity_year, activity_month,
           active_customers,
           lag(active_customers) over (partition by activity_year order by activity_month) as previous_month_customers
	from monthly_active_customers
     )
     select 
        activity_year,
        activity_month,
        active_customers,
        (active_customers - previous_month_customers) as monthly_difference
	from cte_view;
    
    select * from difference_monthly_active_customers;

-- Calculate the percentage.
create or replace view percentage_monthly_active_customers as
select activity_year,
        activity_month,
        active_customers,
        monthly_difference,
        (monthly_difference / (active_customers - monthly_difference)) * 100 as percentage
from difference_monthly_active_customers;

select * from percentage_monthly_active_customers;

-- Retained customers every month.

-- Very similar to the table customer_activity but now we're finding the users for consecutive months too.
create or replace view active_customers_per_month as
select distinct customer_id as active_customer_id, activity_year, activity_month,
row_number() over(order by activity_month, activity_year) as consecutive_month
from customer_activity
order by activity_year, activity_month, customer_id;

select * from active_customers_per_month;

-- Now we have to do a self join on the above table to create the customer_id that exist in consecutive months.
create or replace view retained_users as
select ac1.active_customer_id, ac1.activity_year, ac1.activity_month, ac1.consecutive_month from active_customers_per_month ac1
join active_customers_per_month ac2
on ac1.consecutive_month = ac2.consecutive_month +1 
and ac1.active_customer_id = ac2.active_customer_id 
order by ac1.active_customer_id, ac1.activity_month, ac1.activity_year;

select * from retained_users;

--  Now have everything we need to find the total retained customers per month.
create or replace view total_retained_users as
select activity_year, activity_month, count(active_customer_id) as retained_users
from retained_users
group by activity_year, activity_month;

select * from total_retained_users;

