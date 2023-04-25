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

-- Solution

CREATE TABLE color(
	id int,
	name varchar(50)
);

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

-- Solution

insert into person
values
('Mia', 91),
('Olivia', 91),
('James', 92),
('Liam', 93),
('Ava',	null),
(null, 91);

select * from person;
	
-- List all info of both tables:

select * from person;
select * from color;

-- Run the command below:

select * 
from person 
join color 
on person.favorite_color_id = color.id

-- Exercise: what result do you get?

/*

Solution

	Inner join
	- Only the people that has a favorite color is included in the result
	- So Ava in not in the result
	- "join" = "inner join"
	- (Person with name "null" will be included)

*/


-- Run the command below:

select * 
from person 
left join color 
on person.favorite_color_id = color.id

-- Exercise: what result do you get?

/*

Solution

	Left join
	- Same as above but all from the left table is in the result
	- So Ava is in the result even if she doesn't have a favorite color 

*/

-- Exercise: execute a SELECT with "right join". What result do you get?

-- Solution 

select * 
from person 
right join color 
on person.favorite_color_id = color.id

/*

Solution

	Right join:
	- All from the right table is in the result
	- So the colors that no one likes (Purple and Indigo) is in the result
	- (Ava is not in the result)
	
*/

-- Exercise: execute a SELECT with "full join". What result do you get?

-- Solution

select * 
from person 
full join color 
on person.favorite_color_id = color.id

/*

Solution

	Full join
	- All rows from both tables is included (at least ones)
	- So Ava is include. And Purple and Indigo
	- All people + a nullrow for green = 3+1=4 rows
	- "full join" == "full outer join"  

*/