use sakila;

-- How many distinct (different) actors' last names are there?
select distinct last_name from actor;

-- In how many different languages where the films originally produced? (Use the column language_id from the film table)
select distinct language_id from film;

-- How many movies were released with "PG-13" rating?
select count(*) from film where rating = "PG-13";

-- Get 10 the longest movies from 2006.
select length from film order by length desc limit 10;

-- How many days has been the company operating (check DATEDIFF() function)?
select max(rental_date) from rental;

-- Show rental info with additional columns month and weekday. Get 20.
select *, date_format(rental_date, '%b') as month, date_format(rental_date, '%a') as weekday from rental limit 20;

-- Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.

-- How many rentals were in the last month of activity?