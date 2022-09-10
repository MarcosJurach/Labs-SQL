use sakila;

-- Select all the actors with the first name ‘Scarlett’.
select first_name, last_name from actor where first_name='Scarlett';

-- Select all the actors with the last name ‘Johansson’.
select first_name, last_name from actor where last_name='Johansson';

-- How many films (movies) are available for rent?
select distinct count(film_ID) from inventory;

-- How many films have been rented?
select distinct count(rental_ID) from rental;

-- What is the shortest and longest rental period?
select min(rental_duration), max(rental_duration) from film;

-- What are the shortest and longest movie duration? Name the values max_duration and min_duration.
select min(length) as min_duration, max(length) as max_duration from film;

-- What's the average movie duration?
select avg(length) from film;

-- What's the average movie duration expressed in format (hours, minutes)?
select avg(length)/60 as hours from film
select avg(length) as minutes from film
select avg(length)*60 as seconds from film;

-- How many movies longer than 3 hours?
select count(length) from film where length > 180;

-- Get the name and email formatted. Example: Mary SMITH - mary.smith@sakilacustomer.org.
select first_name, last_name, email from customer;

-- What's the length of the longest film title?
select max(length(title)) from film;