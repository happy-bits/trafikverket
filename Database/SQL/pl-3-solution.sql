╭────────────╮
│  Exercise  │
╰────────────╯
/*

Declare a variable "a_first_name" and set it to a value, e.g "Bette".

Write a program that writes the last name of that actor. If there are no actors with that first name or more than one, give different responses.

Exampeles below:

a_first_name is set to "Adam"
NOTICE:  More than one actor found with first name: Adam

a_first_name is set to "xxxxx"
NOTICE:  Actor xxxxx not found

a_first_name is set to "Bette"
NOTICE:  Actor Bette has the lastname Nicholson

Hint, start like this:

	do
	$$
	declare
		rec record;
		a_first_name actor.first_name%type := 'Bette';
	begin
		
		-- Write code here

	end;
	$$

*/

-- Solution

do
$$
declare
	rec record;
	a_first_name actor.first_name%type := 'Bette';
begin
	
	select first_name, last_name
	into strict rec
	from actor
	where first_name = a_first_name;

	raise notice 'Actor % has the lastname %', a_first_name, rec.last_name;

	exception 
	   when no_data_found then 
	      raise notice 'Actor % not found', a_first_name;
	   when too_many_rows then 
	      raise notice 'More than one actor found with first name: %', a_first_name;
end;
$$



╭────────────╮
│  Exercise  │
╰────────────╯
/*
Create a function from the previous exercise. Name it "get_actor_by_firstname"

The function should return a string. Here you see three statements and the expected result.

select get_actor_by_firstname('Adam')
"More than one actor found with first name: Adam"

select get_actor_by_firstname('Bette')
"Actor Bette has the lastname Nicholson"

select get_actor_by_firstname('xxxx')
"Actor xxxx not found"

Hint:

To combine a string you can use "format" and "%s" as shown below:

format('Actor %s has the lastname %s', a, b)

*/

-- Solution

drop function get_actor_by_firstname;

create function get_actor_by_firstname(a_first_name varchar(100))
	returns varchar(100)
	language plpgsql --> must have this line
	as
$$	
declare
	rec record;
begin
	select first_name, last_name
	into strict rec
	from actor
	where first_name = a_first_name;

	return format('Actor %s has the lastname %s', a_first_name, rec.last_name);

	exception 
	   when no_data_found then 
	      return format('Actor %s not found', a_first_name);
	   when too_many_rows then 
	      return format('More than one actor found with first name: %s', a_first_name);

	
end;
$$;


╭────────────╮
│  Exercise  │
╰────────────╯
/*

Create a function "get_city" which takes two parameters.

It should return a table with the cities that with id's between the two numbers.

Example:

select * from get_city(1, 5)

1	"A Corua (La Corua)"
2	"Abha"
3	"Abu Dhabi"
4	"Acua"
5	"Adana"


select * from get_city(20, 22)

20	"Almirante Brown"
21	"Alvorada"
22	"Ambattur"


*/

-- Solution

DROP FUNCTION get_city(integer,integer);

create or replace function get_city (
  from_id integer,
  to_id integer
) 
	returns table (
		city_id int,
		city varchar
	) 
	language plpgsql
as $$
begin
	return query 
		select
			city.city_id,
			city.city
		from
			city
		where
			city.city_id between from_id and to_id;
end;$$;

