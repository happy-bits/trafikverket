
# Checkpoint - Churches

## Intro

Create a database from the instructions below.

Add suitable foreign keys and primary keys.

Just hand in one solution. (E.g if you do level 2, just hand in level 2)

Submit one file **checkpoint.sql** which contains these three parts:
- CREATE TABLE
- INSERT INTO 
- SELECT

When you're done, verify your code:
1) Create a new database
2) Open **checkpoint.sql** and press F5 (to execute)
3) Verify that you can run the script without errors

## Time

2h

## Level 1

In this task you should create **two tables** + add key(s)

The database should be able to store:

	Oscar-Fredriks church is located in Göteborg and is built 1893
	Masthuggs church is located in Göteborg and is built 1914
	Sankt Georgios church is located in Stockholm and is built 1890
	Matteus church is located in Norrköping and is built 1892

Insert rows in the tables for the content above.

Write a SELECT-statement to get info about the churches. Sort the result by built year:

	1890	 Sankt Georgios church 	 	Stockholm 
	1892	 Matteus church 	 		Norrköping 
	1893	 Oscar-Fredriks church 	 	Göteborg 
	1914	 Masthuggs church 	 		Göteborg 

## Level 2

In this level you should add two more tables, so a total of **four tables** + add relation(s)

Start solving Level 1. Then continue with the instructions below.

The database should also be able to store:

    Linnea lives in Göteborg
    Harry lives in Stockholm

	Linnea likes Oscar-Fredriks church and Matteus church
	Harry likes Matteus church

Insert rows in the tables for the content above.

Write a SELECT-statement to get where the inhabitants lives. Sort by the name of the person:

    Harry       Stockholm
    Linnea      Göteborg

Write a SELECT-statement to get all inhabitants and the churches that they like. Sort by the name of the person and then sort by name of the church:

	Harry	Matteus church              1892
	Linnea	Matteus church              1892
	Linnea	Oscar-Fredriks church       1893

So the final solution should have four tables and three select-queries.


## Level 3

Add one more table + relation(s) so you can store this info:

    Oscar Fredrik church was repainted 1905
    Oscar Fredrik church cleaned the windows at 1910
    Matteus church changed roof 1975

Insert the data above and make a join which shows the info above the renovated churches (three columns and three rows), sort by renovation year:

	Oscar-Fredriks church	1905	Repainted
	Oscar-Fredriks church	1910	Cleaned the windows
	Matteus church			1975	Changed roof

Create a view **churches_in_gothenburg** that shows all churches in Göteborg, the use the view

	SELECT * FROM churches_in_gothenburg;

...which should show:

	1893	Oscar-Fredriks church
	1914	Masthuggs church

Create a procedure **add_people** that accepts two parameters: number of people and cityid. When it's called like this

	call add_people(5, 2)

...five people should be added with cityid=2. The name of the people should be

	Person 1
	Person 2
	Person 3
	Person 4
	Person 5

Detail: if you call the function again e.g

	call add_people(3,2)

...then the new names should be

	Person 1
	Person 2
	Person 3
	
Hint for the last task: you might need to update the sequence of the person table, something like this

	SELECT SETVAL('public.person_id_seq', COALESCE(MAX(id), 1)) FROM public.person;