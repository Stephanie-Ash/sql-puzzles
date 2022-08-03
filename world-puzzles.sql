-- World Challenge SQL
USE world;

-- Using COUNT , get the number of cities in the USA
SELECT COUNT(ID) FROM city WHERE CountryCode='USA';

-- Find out the population and life expectancy for people in Argentina
SELECT Population, LifeExpectancy FROM country WHERE `Name`='Argentina';

-- Using IS NOT NULL , ORDER BY , and LIMIT , which country has the highest life expectancy?
SELECT `Name` from country WHERE LifeExpectancy IS NOT NULL ORDER BY LifeExpectancy DESC Limit 1;

-- Using JOIN ... ON , find the capital city of Spain
SELECT ci.`Name` FROM city ci
INNER JOIN country co ON co.Capital=ci.ID
WHERE co.`name`='Spain';

-- Using JOIN ... ON , list all the languages spoken in the Southeast Asia region
SELECT DISTINCT cl.`Language` FROM countrylanguage cl
INNER JOIN country c ON c.`Code`=cl.CountryCode
WHERE Region='Southeast Asia';

-- Using a single query, list 25 cities around the world that start with the letter F
SELECT * FROM city WHERE `Name` LIKE 'F%' LIMIT 25;

-- Using COUNT and JOIN ... ON , get the number of cities in China
SELECT COUNT(ci.ID) AS china_cities FROM city ci
INNER JOIN country c ON c.`Code`=ci.CountryCode
WHERE c.`Name`='China';

-- Using IS NOT NULL , ORDER BY , and LIMIT , which country has the lowest population? Discard non-zero populations
SELECT `Name`, Population
FROM country
WHERE population IS NOT NULL AND population!=0
ORDER BY Population ASC LIMIT 1;

-- Using aggregate functions, return the number of countries the database contains
SELECT COUNT(code) FROM country;

-- What are the top ten largest countries by area?
SELECT * FROM country ORDER BY SurfaceArea DESC LIMIT 10;

-- List the five largest cities by population in Japan.
SELECT * FROM city
WHERE CountryCode=(
	SELECT `Code` FROM country WHERE `Name`='Japan'
)
ORDER BY Population DESC LIMIT 5;

-- List the names and country codes of every country with Elizabeth II as its Head of State. You will need to fix the mistake first!
UPDATE country SET HeadOfState='Elizabeth II' WHERE HeadOfState='Elisabeth II';
SELECT `Name`, `Code` from country WHERE HeadOfState='Elizabeth II';

-- List the top ten countries with the smallest population-to-area ratio. Discard any countries with a ratio of 0
SELECT `Name`, Population/SurfaceArea AS ratio FROM country
WHERE population > 0 ORDER BY ratio ASC LIMIT 10;

-- List every unique world language
SELECT DISTINCT `Language` FROM countrylanguage;

-- List the names and GNP of the world's top 10 richest countries
SELECT `Name`, GNP FROM country ORDER BY GNP DESC LIMIT 10;

-- List the names of, and number of languages spoken by, the top ten most multilingual countries
SELECT c.`Name`, COUNT(cl.CountryCode) FROM country c
INNER JOIN countrylanguage cl ON c.`Code`=cl.CountryCode
GROUP BY cl.CountryCode ORDER BY COUNT(cl.CountryCode) DESC LIMIT 10;

-- List every country where over 50% of its population can speak German
SELECT c.`Name`, cl.Percentage FROM country c
INNER JOIN countrylanguage cl ON c.`Code`=cl.CountryCode
WHERE cl.`Language`='German' AND cl.Percentage>50;

-- Which country has the worst life expectancy? Discard zero or null values
SELECT `Name` FROM country
WHERE LifeExpectancy IS NOT NULL AND LifeExpectancy > 0
ORDER BY LifeExpectancy ASC LIMIT 1;

-- List the top three most common government forms
SELECT GovernmentForm, COUNT(GovernmentForm) FROM country
GROUP BY GovernmentForm ORDER BY COUNT(GovernmentForm) DESC LIMIT 3;

-- How many countries have gained independence since records began?
SELECT COUNT(`Code`) FROM country
WHERE IndepYear IS NOT NULL;