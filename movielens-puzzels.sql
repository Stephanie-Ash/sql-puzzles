-- Movielens Challenge SQL
USE movielens;

-- List the titles and release dates of movies released between 1983-1993 in reverse chronological order
SELECT title, release_date FROM movies
WHERE release_date BETWEEN '1983-01-01' AND '1993-01-01'
ORDER BY release_date DESC;

-- Without using LIMIT , list the titles of the movies with the lowest average rating
SELECT title, AVG(rating) AS average_rating
FROM movies
JOIN ratings ON movies.id = ratings.movie_id
GROUP BY movies.title
HAVING average_rating = (
	SELECT MIN(avg_rating)
	FROM (
		SELECT AVG(rating) AS avg_rating
		FROM ratings
		GROUP BY movie_id
	) AS table1
)
ORDER BY average_rating;

-- List the unique records for Sci-Fi movies where male 24-year-old students have given 5-star ratings
SELECT DISTINCT m.title, g.`name`, u.age, u.gender, r.rating, o.`name` FROM genres g
INNER JOIN genres_movies gm ON g.id=gm.genre_id
INNER JOIN movies m ON m.id=gm.movie_id
INNER JOIN ratings r ON m.id=r.movie_id
INNER JOIN users u ON u.id=r.user_id
INNER JOIN occupations o ON o.id=u.occupation_id
WHERE g.`name`='Sci-Fi' AND u.age=24 AND u.gender='M' AND r.rating=5 AND o.`name`='student';

-- List the unique titles of each of the movies released on the most popular release day
SELECT DISTINCT title, release_date FROM movies
WHERE release_date=(
	SELECT release_date FROM movies
	GROUP BY release_date ORDER BY count(release_date) DESC LIMIT 1);

-- Find the total number of movies in each genre; list the results in ascending numeric order
SELECT g.`name`, COUNT(gm.genre_id) FROM genres_movies gm
INNER JOIN genres g ON g.id=gm.genre_id
GROUP BY gm.genre_id ORDER BY COUNT(gm.genre_id) ASC;
