# Select all the actors with the first name ‘Scarlett’.
select * from actor
where first_name = 'scarlett';

# How many films (movies) are available for rent and how many films have been rented?
select count(distinct i.inventory_id) from inventory i;
select count(distinct r.rental_id) from rental r;

# What are the shortest and longest movie duration? Name the values max_duration and min_duration.
select min(f.length) as min_duration, max(f.length) as max_duration from film f;

# What's the average movie duration expressed in format (hours, minutes)?
select substring_index(sec_to_time(AVG(f.length)*60), ':', 2) as average_duration from film f;

# How many distinct (different) actors' last names are there?
select count(distinct a.last_name) from actor a;

# Since how many days has the company been operating (check DATEDIFF() function)?
select datediff(max(r.rental_date), min(r.rental_date)) from rental r;

# Show rental info with additional columns month and weekday. Get 20 results.
SELECT *,
date_format(convert(rental_date, date), '%M') as month,
date_format(convert(rental_date, date), '%W') as day,
# Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
CASE
/* ALTERNATIVE: WHEN date_format(convert(rental_date, date), '%w') = 0 or 
date_format(convert(rental_date, date), '%w') = 6   */
WHEN WEEKDAY(rental_date) = 5 or WEEKDAY(rental_date) = 6
THEN 'weekend'
ELSE 'workday'
END
AS day_type 
FROM rental
LIMIT 20;

# How many rentals were in the last month of activity?
SELECT max(rental_date) from rental;
SELECT count(*) from rental
WHERE rental_date LIKE '2006-02%';


