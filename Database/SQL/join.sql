/*

JOIN

Purpose: compare different types of "joins" + read data and create tables

Read more:

https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-joins/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-inner-join/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-left-join/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-right-join/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-full-outer-join/

*/

-- Create a database

CREATE DATABASE demo_join;

/*

Create a table "Person" with two columns:
- name (a string)
- favorite_color_id (a number)

*/

CREATE TABLE person(
	name varchar(50),
	favorite_color_id int
);

/*

Exercise: Color table 

Create a table "Color" with two columns:
- id (a number)
- name (a string)

*/

/*

Add colors

Add the following to the Color table:

- 91 Red
- 92 Green
- 93 Blue
- 94 Purple
- 95 Indigo

...then show the content of the table using "select"
*/

INSERT INTO color 
VALUES
(91, 'Red'),
(92, 'Green'),
(93, 'Blue'),
(94, 'Purple'),
(95, 'Indigo');
	
SELECT * FROM color

/*

Exercise: add people

Add the following People: 
- Mia and Olivia like red
- James likes green
- Liam likes blue
- Ava don't know
- An undefined person likes red

...the list all People

*/
	
-- List all info of both tables:

select * from person;
select * from color;

-- Run the command below:

select * 
from person 
join color 
on person.favorite_color_id = color.id

-- Exercise: what result do you get?

-- Run the command below:

select * 
from person 
left join color 
on person.favorite_color_id = color.id

-- Exercise: what result do you get?

-- Exercise: execute a SELECT with "right join". What result do you get?

-- Exercise: execute a SELECT with "full join". What result do you get?
