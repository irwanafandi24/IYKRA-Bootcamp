--Question 1
--if we want to get all the existing film lists
select * from film where fulltext @@ to_tsquery('astronaut');
--if we want to know the number of astronout film
select count(film_id) number_of_astronaut_film from film where fulltext @@ to_tsquery('astronaut');

--Quetion 2
-- if we want to get all the existing film lists which have a rating of "R" and a replacement cost betwen $5 and $15
select title, description, rating, replacement_cost from film where rating = 'R' and replacement_cost between 5 and 15;
--The number of films which have a rating of "R" and a replacement cost betwen $5 and $15
select count(film_id) number_of_film from film where rating = 'R' and replacement_cost between 5 and 15;

--Question 3
-- The number of payment_number and payment_amount handled by the staff
select staff_id, count(payment_id)payment_number, sum(amount) payment_amount 
from payment group by staff_id order by payment_amount desc;
-- if we want to know the staff name
select s.staff_id, first_name, count(payment_id)payment_number, sum(amount) payment_amount 
from payment p inner join staff s on p.staff_id = s.staff_id 
group by s.staff_id order by payment_amount desc;

--Question 4
-- Find the average replacement cost of the movies by rating
select rating, avg(replacement_cost) average_cost from film group by rating order by average_cost desc;

--Question 5
--Find the customers name and email who have spent the most amount of money
select concat(c.first_name,' ',c.last_name) customer_name, email, sum(amount) total_payment_amount
from customer c inner join payment p on c.customer_id = p.customer_id
group by customer_name, email order by total_payment_amount desc limit 5;

--Question 6
--Get the copies number of each movies in each stores
select store_id, f.film_id, title, count(inventory_id) as copies_number 
from inventory i inner join film f on i.film_id = f.film_id 
group by store_id, f.film_id order by f.film_id;

--Question 7
--Find the customers name and email who have at least  40 transaction payment
select concat(c.first_name,' ',c.last_name) customer_name, email, count(payment_id) total_transaction
from customer c inner join payment p on c.customer_id = p.customer_id
group by customer_name, email having count(payment_id) >= 40  order by total_transaction desc;
