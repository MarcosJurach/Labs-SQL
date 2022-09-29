use sakila;

-- List the number of films per category.
select c.name, count(fc.category_id) as number_of_films from film_category fc
join category c
on c.category_id = fc.category_id
group by c.name;

-- Display the first and the last names, as well as the address, of each staff member.
select s.first_name, s.last_name, a.address from staff s
join address a
on s.address_id = a.address_id
group by s.first_name, s.last_name;

-- Display the total amount rung up by each staff member in August 2005.
select s.first_name, s.last_name, sum(p.amount) as total_amount from staff s
join payment p
on s.staff_id = p.staff_id
where month(p.payment_date) = 08
group by s.first_name, s.last_name;

-- List all films and the number of actors who are listed for each film.
select f.film_id, f.title, count(fa.actor_id) as number_of_actors from film f
join film_actor fa
on f.film_id = fa.film_id
group by f.title;

-- Using the payment and the customer tables as well as the JOIN command, list the total amount paid by each customer. List the customers alphabetically by their last names.
select c.first_name, c.last_name, sum(p.amount) as total_amount from customer c
join payment p
on c.customer_id = p.customer_id
group by c.first_name, c.last_name
order by c.last_name;
