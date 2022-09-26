use sakila;

-- Drop column picture from staff.
alter table staff drop column picture;

-- A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
insert into staff (staff_id, first_name, last_name, address_id, email, store_id, username, last_update)
select customer_id, first_name, last_name, address_id, email, store_id, first_name, last_update 
from customer where customer.first_name = "tammy" and customer.last_name = "sanders";

-- Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. Hint: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. For eg., you would notice that you need customer_id information as well. To get that you can use the following query:
-- select customer_id from sakila.customer
-- where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
-- Use similar method to get inventory_id, film_id, and staff_id.
insert into rental (rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
select customer_id from sakila.customer
where customer.first_name = "charlotte" and customer.last_name = "hunter"
select staff_id from sakila.staff
where staff.first_name = "mike" and staff.last_name = "hillyer";

--  Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:
-- Check if there are any non-active users
-- Create a table backup table as suggested
-- Insert the non active users in the table backup table
-- Delete the non active users from the table customer
create table deleted_users(customer_id int unique not null, email char(50) default null, create_date datetime);
insert into deleted_users (customer_id, email, create_date)
select customer_id, email, create_date from sakila.customer where active = 0;
delete from customer where active = 0;