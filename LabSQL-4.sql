use sakila;

-- Get film ratings.
select title, rating from film;

-- Get release years.
select title, release_year from film;

-- Get all films with ARMAGEDDON in the title.
select title from film where title like '%armageddon%';

-- Get all films with APOLLO in the title
select title from film where title like '%apollo%';

-- Get all films which title ends with APOLLO.
select title from film where title like '%apollo';

-- Get all films with word DATE in the title.
select title from film where title like '%date%';

-- Get 10 films with the longest title.
select title from film order by len(title); -- that doesn't work and i SWEAR i tried to make it work

-- How many films include Behind the Scenes content?
select distinct count(title) from film where special_features = 'behind the scenes';

-- List films ordered by release year and title in alphabetical order.
select title, release_year from film order by title, release_year;