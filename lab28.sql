-- Lab | SQL Join (Part II)
-- In this lab, you will be using the Sakila database of movie rentals.
USE sakila;


-- Instructions
-- Write a query to display for each store its store ID, city, and country.
SELECT 
    store.store_id, 
    city.city, 
    country.country
FROM store
JOIN address
    ON store.address_id = address.address_id
JOIN city
    ON address.city_id = city.city_id
JOIN country
    ON city.country_id = country.country_id;


-- Write a query to display how much business, in dollars, each store brought in.
SELECT 
    store.store_id, 
    SUM(payment.amount) as total_amount
FROM store
JOIN staff
    ON store.manager_staff_id = staff.staff_id
JOIN payment
    ON staff.staff_id = payment.staff_id
GROUP BY store.store_id
ORDER BY total_amount DESC;
-- not sure how to add "dollars" in the query however


-- Which film categories are longest?
SELECT 
    category.name as category, 
    MAX(film.length) as longest_film
FROM category
JOIN film_category
    ON category.category_id = film_category.category_id
JOIN film
    ON film_category.film_id = film.film_id
GROUP BY category
ORDER BY longest_film DESC;


-- Display the most frequently rented movies in descending order.
SELECT 
    film.title as film_title, 
    COUNT(*) as number_of_rentals
FROM film
JOIN inventory
    ON film.film_id = inventory.film_id
JOIN rental
    ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id
ORDER BY number_of_rentals DESC;


-- List the top five genres in gross revenue in descending order.
SELECT 
    category.name as category, 
    SUM(payment.amount) as total_amount
FROM category
JOIN film_category
    ON category.category_id = film_category.category_id
JOIN film
    ON film_category.film_id = film.film_id
JOIN inventory
    ON film.film_id = inventory.film_id
JOIN rental
    ON inventory.inventory_id = rental.inventory_id
JOIN payment
    ON rental.rental_id = payment.rental_id
GROUP BY category
ORDER BY total_amount DESC
LIMIT 5;

-- Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
    film.title as film_title, 
    count(rental.inventory_id) as available
FROM film as film
JOIN inventory as inventory
	ON film.film_id = inventory.film_id
JOIN rental as rental
	ON inventory.inventory_id = rental.inventory_id
WHERE film.title = 'ACADEMY DINOSAUR' 
	AND store_id = 1 


-- Get all pairs of actors that worked together.
SELECT 
    concat(actor1.first_name, ' ', actor1.last_name) as actor1, 
    concat(actor2.first_name, ' ', actor2.last_name) as actor2
FROM actor as actor1
JOIN film_actor as film_actor1
    ON actor1.actor_id = film_actor1.actor_id
JOIN film_actor as film_actor2
    ON film_actor1.film_id = film_actor2.film_id
JOIN actor as actor2
    ON film_actor2.actor_id = actor2.actor_id
WHERE actor1.actor_id < actor2.actor_id
ORDER BY actor1.actor_id, actor2.actor_id;



-- Bonus:
-- These questions are tricky, you can wait until after Monday's lesson to use new techniques to answer them!



-- Get all pairs of customers that have rented the same film more than 3 times.


-- For each film, list actor that has acted in more films.

