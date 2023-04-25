/*

KEYS

Purpose: intro to "keys". See the difference when keys are used or not

https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-primary-key/
https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-foreign-key/

*/

CREATE DATABASE demo_keys;

/*

Exercise: color table

Create a table "color" with the columns:
- id
- name

*/

-- Solution

CREATE TABLE color(
	id INT, 
	name VARCHAR(50)
);

/*

Exercise: person table

Create a table "person" with:
- name
- favorite_color_id 

*/

-- Solution

CREATE TABLE person(
	name VARCHAR(50),
	favorite_color_id INT 
);

/*

Exercise: add colors

Add the following colors:
- 91 Red
- 92 Green
- 93 Blue
- 94 Purple
- 95 Indigo

*/

-- Solution

INSERT INTO color 
VALUES
(91, 'Red'),
(92, 'Green'),
(93, 'Blue'),
(94, 'Purple'),
(95, 'Indigo');

/*

Exercise: add people

Add this people:
- Mia likes Red
- James likes Green
- Liam likes Blue

*/

-- Solution

INSERT INTO person
VALUES
('Mia', 91),
('James', 92),
('Liam', 93);

/*

Exercise:

Add the color Yellow with id=91:

What's the problem with the data now?

*/

-- Solution

INSERT INTO color VALUES (91, 'Yellow');

SELECT * FROM color;

/*

Solution:

Now it's not cleared what the color with Id=91 is. Is it red or yellow? Not good.

*/

/*

Exercise: add Joe

Add Joe with which likes the color 666666

What's the problem with the data now?

*/

-- Solution

INSERT INTO person VALUES ('Joe', 666666);
SELECT * FROM person;

/*

Solution

Joe like the color 666666, but what color is that?
No one knows...

*/

/*

Recreate with keys

Now we will restart this example but use "primary key" and "foreign key"

*/

 
CREATE DATABASE demo_key2;

-- Don't forget to change connection to "demo_key2" before you continue...

/*
Add the following two tables with data:
*/

CREATE TABLE color(
	id INT PRIMARY KEY, --- new!
	name VARCHAR(50)
);

CREATE TABLE person(
	name VARCHAR(50),
	favorite_color_id INT,
	FOREIGN KEY(favorite_color_id) REFERENCES color(id) --- new!
);

INSERT INTO color 
VALUES
(91, 'Red'),
(92, 'Green'),
(93, 'Blue'),
(94, 'Purple'),
(95, 'Indigo');

INSERT INTO person
VALUES
('Mia', 91),
('James', 92),
('Liam', 93);

/*

Exercise: add yellow

Try to add "Yellow" with Id 91

What happens? 

*/

-- Solution

INSERT INTO color VALUES (91, 'Yellow');

/*

Solution

We get this

	ERROR:  duplicate key value violates unique constraint "color_pkey"
	DETAIL:  Key (id)=(91) already exists.

Problem solved! This is not allowed anymore because of out "primary key" above. Good!

If you now run 

	select * from color

...you see that the color Yellow wasn't inserted (good)

*/

/*

Exercise: add Joe

Try to add the person
- Joe 666666

What happens? Good/bad?
*/

-- Solution

INSERT INTO person VALUES ('Joe', 666666);

/*

Solution

We get

	ERROR:  insert or update on table "person" violates foreign key constraint "person_favorite_color_id_fkey"
	DETAIL:  Key (favorite_color_id)=(666666) is not present in table "color".

Problem solved! This is now allowed anymore because of out "foreign key" above. Good!

*/