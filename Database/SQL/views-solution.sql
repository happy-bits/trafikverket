
╭────────────╮
│  Exercise  │
╰────────────╯
-- Create a new database

CREATE DATABASE demo_views

/*

Create a table "roomsize" which this info:

id    roomtype			  numberofbeds	 extrabeds	price
1	  Single room		  1				 0			700
2	  Double room		  2				 0			900
3	  Double room + 1	  2				 1			920
4	  Double room + 2	  2				 2			940
5	  Suite				  4				 0			1200
6	  Precidential suite  2				 4			1500
7	  Bridal suite		  2				 0			2000
*/

-- Solution

create table roomsize(
	id serial primary key,
	roomtype varchar(50) null,
	numberofbeds int null,
	extrabeds int null,
	price int null
);

insert into roomsize(roomtype, numberofbeds, extrabeds, price) 
values 
	('Single room', 1, 0, 700),
	('Double room', 2, 0, 900),
	('Double room + 1', 2, 1, 920),
	('Double room + 2', 2, 2, 940),
	('Suite', 4, 0, 1200),
	('Precidential suite', 2, 4, 1500),
	('Bridal suite', 2, 0, 2000);

select * from roomsize;

╭────────────╮
│  Exercise  │
╰────────────╯
/*

	Create a view with name "roomswithextrabeds" that gets all rooms with one or more extra beds. The view should show the columns "roomtype" and "price"

	Then show all rows from the view
*/


-- Solution

create or replace view roomswithextrabeds
as
	select roomtype, price
	from roomsize
	where extrabeds>=1;


select * 
from 
roomswithextrabeds;


╭────────────╮
│  Exercise  │
╰────────────╯
/*

Use the last view but only show rooms cheaper than 950 (that have extra beds)

This is an example that you can refer to a view from another view

*/

-- Solution

select * from roomswithextrabeds
where price<=950;

╭────────────╮
│  Exercise  │
╰────────────╯

/*
Create a view "cheaproomswithextrabeds" that show rooms with extra beds that are cheaper than 950

Then show all rows from the view

*/

-- Solution

create view cheaproomswithextrabeds
as

	select * from roomswithextrabeds
	where price<=950;

select * from cheaproomswithextrabeds;

╭────────────╮
│  Exercise  │
╰────────────╯

/*

Create a view "expensive_rooms" which shows all rooms that cost 900 or more using "check option", see here:

https://www.postgresqltutorial.com/postgresql-views/postgresql-views-with-check-option/

Insert a room using the view. Verify that it's only possible to insert a room that cost 900 or more

*/

-- Solution

create view expensive_rooms
as
	select roomtype, price
	from roomsize
	where price>=900
	with check option;



insert into expensive_rooms values('aaaaaaa', 800) -- doesn't work

insert into expensive_rooms values('aaaaaaa', 900) -- does work

