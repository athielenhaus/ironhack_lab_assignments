# Add the new films to the database.
drop table if exists films_2020;

select * from films_2020;

# Update information on rental_duration, rental_rate, and replacement_cost.
SET SQL_SAFE_UPDATES = 0;
UPDATE films_2020 
SET rental_duration = 3,
rental_rate = 2.99,
replacement_cost =  8.99;

SET SQL_SAFE_UPDATES = 1;

select * from films_2020;

#In the table actor, what last names are not repeated? 
select a.last_name, count(a.last_name) as ct_last_name from actor a
group by a.last_name
having ct_last_name = 1;

# Which last names appear more than once? 
select a.last_name, count(a.last_name) as ct_last_name from actor a
group by a.last_name
having ct_last_name > 1;

# Using the rental table, find out how many rentals were processed by each employee.
select r.staff_id, count(distinct r.rental_id) as no_rentals from rental r
group by r.staff_id;

# Using the film table, find out how many films were released.
select count(f.film_id) from film f
where release_year <> null;

# Using the film table, find out how many films there are of each rating.
select f.rating, count(distinct f.film_id) as no_films
from film f
group by f.rating;

# What is the mean length of the film for each rating type. Round off the average lengths to two decimal places
select f.rating, round(avg(f.length), 2) as avg_length
from film f
group by f.rating;


# Which kind of movies (rating) have a mean duration of more than two hours? 
select f.rating, round(avg(f.length), 2) as avg_length
from film f
group by f.rating
having avg_length>120;