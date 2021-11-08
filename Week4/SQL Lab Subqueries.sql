# How many copies of the film Hunchback Impossible exist in the inventory system?
use sakila;

# get the film_id of the film
select film_id from film
where title = 'Hunchback Impossible';

# count the number of distinct inventory ids with the film id
select count(distinct inventory_id) from inventory
where film_id = 
(select film_id from film
where title = 'Hunchback Impossible');

# List all films whose length is longer than the average of all the films.
select * from film f
where f.length >
# find the average length of films
(select avg(f.length) as avg_length from film f);

# Use subqueries to display all actors who appear in the film Alone Trip.
select a.last_name from actor a
where a.actor_id in
# Alternative: find corresponding actor_ids from juncture table
(select fa.actor_id from film_actor fa
where fa.film_id =
# find film_id of Alone Trip
(select film_id from film
where title = 'Alone Trip') );

# Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
# Identify all movies categorized as family films.
SELECT 
    title
FROM
    film
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            film_category
        WHERE
            category_id IN (SELECT 
                    category_id
                FROM
                    category
                WHERE
                    name LIKE '%family%'));
                    
/*Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, 
you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the 
relevant information.*/
# Get name and email from customers with the corresponding address ids
select last_name, first_name, email from customer where address_id in
# Get the address ids that are in Canada
(select address_id from address where city_id in
# Get the city ids that are in the country
(select city_id from city where country_id in
# Get the country id of Canada
(select country_id from country where country = 'Canada')));

# Do it via joins
select c.last_name, c.first_name, c.email, co.country from customer c
join address using(address_id)
join city using(city_id)
join country co using(country_id)
where co.country = 'Canada';

/* Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted 
in the most number of films. First you will have to find the most prolific actor and then use that actor_id 
to find the different films that he/she starred.*/
select title from film where film_id in
# identify film_ids in which the actor has starred
(select film_id from film_actor where actor_id =
# identify actor id with max number of films
(select actor_id from 
# identify actor with most films
(select actor_id, count(film_id) as no_films from film_actor
group by actor_id
order by no_films desc 
limit 1) t1));


/*Films rented by most profitable customer. You can use the customer table and payment table to find the most 
profitable customer ie the customer that has made the largest sum of payments*/
# get film names
select title from film where film_id in
# get film ids associated with inventory ids
(select distinct film_id from inventory where inventory_id in
# get inventory ids of film rentals from most profitable customer
(select distinct inventory_id from rental where customer_id =
# get the customer id from the most profitable customer
(select customer_id from
# find the most profitable customer
(select customer_id, sum(amount) as sum from payment
group by customer_id
order by sum desc limit 1) t1 )));


# Customers who spent more than the average payments.
# find corresponding names
select last_name, first_name from customer where customer_id in
# find customer_ids where payment is above average 
(select distinct customer_id from payment where amount>
# find average payment 
(select avg(amount) from payment));