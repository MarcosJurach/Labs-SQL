use sakila;

-- How many copies of the film Hunchback Impossible exist in the inventory system?
select count(inventory_id) as number_of_copies from inventory
where film_id = (select film_id from film where title = 'Hunchback Impossible');

-- List all films whose length is longer than the average of all the films.
select film_id, title, length from film 
where length > (
select avg(length) as average_length from film
);

-- Use subqueries to display all actors who appear in the film Alone Trip.
select first_name, last_name from actor
where actor_id in (
select actor_id from (
select actor_id from film_actor 
where film_id = (select film_id from film where title = "Alone Trip") 
) sub1
);

-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
select title from film
where film_id in (
select film_id from (
select film_id from film_category
where category_id = (select category_id from category where name = "Family") 
) sub1
);

-- Get name and email from customers from Canada using subqueries. Do the same with joins. 
-- Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
select first_name, last_name, email from customer where address_id in (
select address_id from (
select address_id from address where city_id in (
select city_id from (
select city_id from city where country_id = (
select country_id from country where country = "Canada")
) sub2
)
) sub1
);

-- Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. 
-- First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
select title from film
where film_id in (
select film_id from (
select film_id from film_actor where actor_id = (
select actor_id from ( 
select actor_id, count(film_id), rank() over(order by count(film_id) desc) as actor_ranking from film_actor
group by actor_id
) sub2
where actor_ranking = 1
) 
) sub1
);

-- Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

-- Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.