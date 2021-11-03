
# Get release years.
select f.release_year from film  f;

# Get all films with ARMAGEDDON in the title.
select * from film f
where f.title like "%ARMAGEDDON%";

# Get all films which title ends with APOLLO.
select * from film f
where f.title like "%APOLLO";

# Get 10 the longest films.
select * from film f
order by f.length desc
limit 10;

# How many films include Behind the Scenes content?
select count(distinct f.film_id) from film f
where f.special_features like '%behind the scenes%';

# Drop column picture from staff.
Alter table staff DROP COLUMN picture;


select * from staff;

# A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
select * from customer
where first_name = 'TAMMY' and last_name = 'SANDERS';

Insert into staff (first_name, last_name, email, address_id, store_id, active, username)
VALUES
('Tammy', 'Sanders', 'TAMMY.SANDERS@sakilacustomer.org', 79, 2, 1, 'Tammy');

/* Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date 
for the rental_date column in the rental table. */

select * from rental;

select * from customer
where first_name= 'charlotte' and last_name = 'hunter';

Insert into rental (rental_date, customer_id, staff_id, inventory_id)
VALUES
(curdate(), 130, 2, 5);

# Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:


# Check if there are any non-active users
select * from customer c
where c.active <>1 ;

#  Create a table backup table as suggested
drop table if exists sakila.deleted_users;
# Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:
CREATE TABLE deleted_users LIKE customer;

# Insert the non active users in the table backup table
INSERT deleted_users SELECT * FROM customer c
where c.active <>1 ;

# Delete the non active users from the table customer 
SET SQL_SAFE_UPDATES = 0;
SET FOREIGN_KEY_CHECKS= 0;

# LONG VERSION??
/*ALTER TABLE `customer`
ADD CONSTRAINT `fk_payment_customer`
FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
ON DELETE CASCADE;*/

DELETE FROM customer
where active <>1 ;

SET SQL_SAFE_UPDATES = 1;
SET FOREIGN_KEY_CHECKS= 1;


