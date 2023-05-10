
create table person(
	id int primary key,
	name varchar(50)
);

create table country(
	id int primary key,
	name varchar(50)
);

create table passport(
	person_id int not null references person(id), 
	country_id int not null references country(id), 
	created_at timestamp,
	valid_to timestamp,
	primary key(person_id, country_id)
);

insert into person values
	(1, 'Anna'),
	(2, 'Maria'),		
	(3, 'Lisa');	
	
insert into country values
	(100, 'Sweden'),
	(101, 'Denmark');
	
insert into passport values
	(1, 100, '2023-03-08', '2028-03-08'),
	(1, 101, '2022-01-01', '2027-01-01'),
	(3, 100, '2019-01-01', '2024-01-01');
	
select * from student;
select * from course;

select  person.name, passport.created_at, passport.valid_to, country.name
from person join passport on person.id = passport.person_id
join country on passport.country_id = country.id;

/*

The last query will output:

"Anna"	"2023-03-08 00:00:00"	"2028-03-08 00:00:00"	"Sweden"
"Anna"	"2022-01-01 00:00:00"	"2027-01-01 00:00:00"	"Denmark"
"Lisa"	"2019-01-01 00:00:00"	"2024-01-01 00:00:00"	"Sweden"

*/