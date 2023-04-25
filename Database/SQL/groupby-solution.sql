/*

GROUP BY

Purpose: show the usage of "GROUP BY" to extract info about groups of rows

References
- https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-group-by/
- https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-having/
*/

/*

Exercise: Person table

Create a new database and name it Demo

Create a table "Person" with columns:
- Name
- Country    (a string)
- Income     (a whole number)

*/

-- Solution

CREATE DATABASE demo_groupby;

CREATE TABLE person(
	name VARCHAR(50),
	country VARCHAR(50),
	income INT
);

/*

Exercise: add data

Add the following data:

	Mia 	Sweden 	20000
	Olivia 	Iceland 50000
	James 	Sweden 	25000
	Liam 	Sweden 	28000
	Ava		Iceland 60000
	Lisa 	Spain 	10000

*/


-- Solution

INSERT INTO person
VALUES
	('Mia', 'Sweden', 20000),
	('Olivia', 'Iceland', 50000),
	('James', 'Sweden', 25000),
	('Liam', 'Sweden', 28000),
	('Ava',	'Iceland', 60000),
	('Lisa', 'Spain', 10000);

SELECT * FROM person;

/*

Count

Use "count" to count number of rows in each group, so you get:

	3
	2
	1

Try this:

*/

SELECT COUNT(*) 
FROM person 
GROUP BY country;

-- and try

SELECT COUNT(*) as inhabitants
FROM person 
GROUP BY country;

/*

Exercise: two columns

Adjust the query so you get.

	Sweden	 3
	Iceland	 2
	Spain	 1

*/

-- Solution

SELECT country, COUNT(*) as inhabitants
FROM person 
GROUP BY country;

/*

Exercise: show the average income

Show the average of income by nation:

	Sweden	24333	3
	Iceland	55000	2
	Spain	10000	1

Hint: use AVG(MyColumnName) to get the average
Hint: use ROUND(SomeValue) to round a value
*/

-- Solution

SELECT country, ROUND(AVG(income)) AS average, COUNT(*) AS inhabitants
FROM person 
GROUP BY country;

/*

Exercise: filter with HAVING

Continue, but only show countries with at least 2 inhabitants

	Sweden	24333	3
	Iceland	55000	2


Filter the groups with "HAVING" (you can't use "WHERE" in this case)

*/

-- Solution

SELECT country, ROUND(AVG(income)) AS average, COUNT(*)  AS inhabitants
FROM person 
GROUP BY country
HAVING COUNT(*)>=2

/*

Exercise: filter with WHERE

Get all countries that starts with the letter "S"

	Spain	1
	Sweden	3

"WHERE" is used to filter rows before the grouping. (in this case "HAVING" would work as well)

*/

-- Solution

SELECT country, COUNT(*)  AS inhabitants
FROM person 
WHERE Country LIKE 'S%'
GROUP BY country

/*

HAVING and WHERE are similar. Both are about filtering.

HAVING is about filtering *groups*

WHERE is about filtering *rows*

*/

/*

Exercise: start with L

Get number of inhabitants with names starting with "L" in each country

	Spain	1
	Sweden	1

*/

-- Solution

SELECT country, COUNT(*)  AS inhabitants
FROM person 
WHERE name LIKE 'L%'
GROUP BY country

-- (HAVING wouldn't work in this case)
	
/*

Group by - common errors (SELECT)

Below follows some common errors when dealing with GROUP BY

Try the following. What's the problem here?

*/

	SELECT count(*) as inhabitants, income 
	FROM person 
	GROUP BY country

/*
You'll get:

	ERROR:  column "person.income" must appear in the GROUP BY clause or be used in an aggregate function
	LINE 1:  SELECT count(*) as inhabitants, income 
	
Explanation:

	The columns in "SELECT" can't be anything you like
	In the example above it doesn't work. E.g in Sweden not everyone has the same income.
*/

/*

Group by - common errors (HAVING)

Try the following. What's the problem here?
*/

SELECT country, count(*) AS inhabitants
FROM person 
GROUP BY country 
HAVING name LIKE 'L%'

/*
You'll get:

	ERROR:  column "person.name" must appear in the GROUP BY clause or be used in an aggregate function
	LINE 4: HAVING name LIKE 'L%'

Explanation:

	The columns in "HAVING" can't refer to any column

	In the example above it doesn't work. E.g in Island not everyone has the same name.
*/