create table city(
	id int primary key,
	name varchar(20),
	founded smallint
);

create table person(
	id int primary key,
	first_name varchar(50),
	last_name varchar(50),
	city_id int references city(id)
);

insert into city values
	(1, 'Göteborg', 1621),
	(2, 'Stockholm', 1252),		
	(3, 'Malmö', 1275);	
	
insert into person values
	(100, 'Kalle', 'Larsson', 2),
	(101, 'Lisa', 'Andersson', 2),
	(102, 'Emma', 'Johansson', 3);
	
select * from city;
select * from person;

select person.first_name, person.last_name, city.name, city.founded 
from person join city 
on person.city_id = city.id;

/*

The last query will output:

"Kalle"	"Larsson"	"Stockholm"	1252
"Lisa"	"Andersson"	"Stockholm"	1252
"Emma"	"Johansson"	"Malmö"		1275

*/