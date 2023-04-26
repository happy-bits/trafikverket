
╭────────────╮
│  Exercise  │
╰────────────╯
/*
Create a PL-script that writes Hello world 

Hint: use "do", "begin", "raise" and "end"
*/

-- Solution

do
$$
begin
	raise notice 'Hello world';
end
$$



╭────────────╮
│  Exercise  │
╰────────────╯
/*
Create a PL-script with a constant s_id and a variable s_name

Set s_id to 1

Use "raise notice" to write the name of the staff like this:

"Mike has id 1"

*/

-- Solution

do  
$$
declare
	s_id constant integer := 1;
	s_name staff.first_name%type;
	-- or:
	--s_name varchar(45);
begin 
   select first_name into s_name
   from staff
   where staff_id=s_id;
   raise notice ' % has id %', s_name, s_id;
end;
$$

╭────────────╮
│  Exercise  │
╰────────────╯
/*

Create a variable that sets a variable num_orders to 100. Write this:
NOTICE:  The number of orders is 100

Increase the value by 8. Write this:
NOTICE:  The number of orders is 108
*/

-- Solution
do  
$$
declare
	num_orders integer := 100;
	
begin   
   raise notice 'The number of orders is %', num_orders;
   num_orders := num_orders + 8;
   raise notice 'The number of orders is %', num_orders;
end;
$$



╭────────────╮
│  Exercise  │
╰────────────╯
/*
Declare a constant "selected_city_id" and set it to 102
Declare a variable "selected_city"

Get city name and last updated time. Expected message:

NOTICE:  Caracas was last updated 2006-02-15 09:45:25
*/

-- Solution

do $$
declare
   selected_city_id constant integer := 102;
   selected_city city%rowtype;
   
begin
 
   select * 
   from city
   into selected_city
   where city_id=selected_city_id;

   raise notice '% was last updated %',
      selected_city.city,
      selected_city.last_update;
	  
end; $$

╭────────────╮
│  Exercise  │
╰────────────╯
/*
Get the actors with id less than or equal to 3. Sort them by firstname. Write their first and last names.

Expected message:

NOTICE:  Ed has lastname Chase
NOTICE:  Nick has lastname Wahlberg
NOTICE:  Penelope has lastname Guiness
*/

-- Solution

do
$$
declare
	rec record;
begin
	for rec in select first_name, last_name
			from actor 
			where actor_id<=3
			order by first_name
	loop 
		raise notice '% has lastname %', rec.first_name, rec.last_name;	
	end loop;
end;
$$

