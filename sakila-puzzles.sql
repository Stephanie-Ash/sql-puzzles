-- Sakila Challenge SQL
USE sakila;

-- List all actors
SELECT * FROM actor;

-- Find the surname of the actor with the forename 'John'
SELECT last_name FROM actor WHERE first_name='John';

-- Find all actors with surname 'Neeson'
SELECT * FROM actor WHERE last_name='Neeson';

-- Find all actors with ID numbers divisible by 10
SELECT * FROM actor WHERE actor_id%10=0;

-- What is the description of the movie with an ID of 100?
SELECT `description` FROM film WHERE film_id=100;

-- Find every R-rated movie
SELECT * FROM film WHERE rating='R';

-- Find every non-R-rated movie
SELECT * FROM film WHERE rating!='R';

-- Find the ten shortest movies
SELECT * FROM film ORDER BY length ASC LIMIT 10;

-- Find  the movies with the longest runtime, without using LIMIT
SELECT * FROM film
WHERE length=(
	SELECT MAX(length) FROM film
);
-- Find all movies that have deleted scenes
SELECT * FROM film WHERE special_features LIKE '%deleted scenes%';

-- Using HAVING , reverse-alphabetically list the last names that are not repeated.
SELECT last_name, COUNT(last_name) FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1
ORDER BY last_name DESC;

-- Using HAVING , list the last names that appear more than once, from highest to lowest frequency.
SELECT last_name, COUNT(last_name) FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1
ORDER BY COUNT(last_name) DESC;

-- Which actor has appeared in the most films
SELECT * FROM actor
WHERE actor_id = (
	SELECT actor_id FROM film_actor GROUP BY actor_id ORDER BY COUNT(actor_id) DESC LIMIT 1
);

-- 'Academy Dinosaur' has been rented out, when is it due to be returned?
SELECT f.title, DATE_ADD(r.rental_date, INTERVAL f.rental_duration DAY) AS due_date
FROM rental r
INNER JOIN inventory i ON r.inventory_id=i.inventory_id
INNER JOIN film f ON f.film_id=i.film_id
WHERE f.title='Academy Dinosaur'
AND r.return_date IS NULL
AND r.rental_date IS NOT NULL;

-- What is the average runtime of all films?
SELECT AVG(length) FROM film;

-- List the average runtime for every film category
SELECT c.`name`, AVG(f.length) AS average_runtime FROM category c
INNER JOIN film_category fc ON c.category_id=fc.category_id
INNER JOIN film f ON f.film_id=fc.film_id
GROUP BY c.category_id;

-- List all movies featuring a robot
SELECT * FROM film WHERE description LIKE '%robot%';

-- How many movies were released in 2010?
SELECT COUNT(film_id) FROM film WHERE release_year=2010;

-- Find the titles of all the horror movies.
SELECT f.title FROM film f
INNER JOIN film_category fc ON f.film_id=fc.film_id
INNER JOIN category c ON fc.category_id=c.category_id
WHERE c.`name` = 'horror';

-- List the full name of the staff member with the ID of 2.
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM staff WHERE staff_id=2;

-- List all the movies that Fred Costner has appeared in.
SELECT f.title FROM film f
INNER JOIN film_actor fa ON f.film_id=fa.film_id
INNER JOIN actor a ON fa.actor_id=a.actor_id
WHERE a.first_name = 'Fred' AND a.last_name = 'Costner';

-- How many distinct countries are there?
SELECT DISTINCT (COUNT country) FROM country;

-- List the name of every language in reverse-alphabetical order.
SELECT `name` FROM `language` ORDER BY `name` DESC;

-- List the full names of every actor whose surname ends with '-son' in alphabetical order by their forename
SELECT CONCAT(first_name, ' ', last_name) AS full_name from actor WHERE last_name LIKE '%son' ORDER BY first_name ASC;

-- Which category contains the most films?
SELECT * FROM category
WHERE category_id = (
	SELECT category_id FROM film_category GROUP BY category_id ORDER BY COUNT(category_id) DESC LIMIT 1
);
