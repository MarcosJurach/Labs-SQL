use sakila;

-- Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
select title, length, rank() over(order by length desc) as rank_by_length from film;

-- Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
-- In your output, only select the columns title, length, rating and rank.
select title, film.length, rating, rank() over(partition by rating order by film.length desc) as 'rank'
from film
where film.length is not null and film.length <> 0;

-- Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
select a.actor_id, a.first_name, a.last_name, count(f.actor_id) as counter
from actor a left join film_actor f
on f.actor_id = a.actor_id
group by a.actor_id, a.first_name, a.last_name
order by counter desc;

-- Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
select c.customer_id, c.first_name, c.last_name, count(r.rental_id) as counter
from customer c left join rental r
on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by counter desc;

