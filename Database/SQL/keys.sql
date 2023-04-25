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

/*

Exercise: person table

Create a table "person" with:
- name
- favorite_color_id 

*/

/*

Exercise: add colors

Add the following colors:
- 91 Red
- 92 Green
- 93 Blue
- 94 Purple
- 95 Indigo

*/

/*

Exercise: add people

Add this people:
- Mia likes Red
- James likes Green
- Liam likes Blue

*/

/*

Exercise:

Add the color Yellow with id=91:

What's the problem with the data now?

*/

/*

Exercise: add Joe

Add Joe with which likes the color 666666

What's the problem with the data now?

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

/*

Exercise: add Joe

Try to add the person
- Joe 666666

What happens? Good/bad?
*/
