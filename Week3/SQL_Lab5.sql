# List number of films per category.
select c.name, count(distinct f.film_id) from film f
join film_category fc
on fc.film_id = f.film_id
join category c
on c.category_id = fc.category_id
group by c.name;

# Display the first and last names, as well as the address, of each staff member.
select s.first_name, s.last_name, a.address
from staff s
join address a
on a.address_id = s.address_id;

# Display the total amount rung up by each staff member in August of 2005.
select * from payment;
select s.last_name, sum(p.amount) as total_amount 
from staff s
join payment p
on s.staff_id = p.staff_id
where month(p.payment_date)=8 and year(p.payment_date)=2005
group by s.last_name;
# will not show all staff???

use sakila;
# List each film and the number of actors who are listed for that film.
select f.title, count(distinct a.actor_id) from film f
join film_actor
using(film_id)
join actor a
using(actor_id)
group by f.title;

select * from staff;

select *, year(payment_date) as month from payment;

# Using the tables payment and custommer, list the total paid by each customer. List the customers alphabetically by last name.
select c.last_name, sum(p.amount) as total_paid
from payment p
join customer c
using(customer_id)
group by c.last_name
order by c.last_name;
