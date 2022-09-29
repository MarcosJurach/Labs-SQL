use sakila;

drop table if exists rentals_may;
create table rentals_may as
select * from rental where rental_date like '____-05-%';

select * from rentals_may; -- sanity check
select customer_id, count(rental_id) as number_of_rentals from rentals_may group by customer_id;

drop table if exists rentals_june;
create table rentals_june as
select * from rental where rental_date like '____-06-%';