╭───────────────╮
│  Error codes  │
╰───────────────╯

https://www.postgresql.org/docs/current/errcodes-appendix.html

╭─────────────╮
│  Exception  │
╰─────────────╯

/*

select ... intro strict ... means:

If the STRICT option is specified, the command must return exactly one row or a run-time error will be reported, either NO_DATA_FOUND (no rows) or TOO_MANY_ROWS (more than one row). 


*/

/*
   This will issue and error because the film with id 2000 doesn't exist
   Postgres will output the error code P0002
   If you look at the errorcode-link above, you see that this is "no_data_found"
*/
do
$$
declare
	rec record;
	v_film_id int = 2000;
begin
	-- select a film 
	select film_id, title 
	into strict rec
	from film
	where film_id = v_film_id;
end;
$$
language plpgsql;

-- Same example, but here we catch the exception

do
$$
declare
	rec record;
	v_film_id int = 2000;
begin
	-- select a film 
	select film_id, title 
	into strict rec
	from film
	where film_id = v_film_id;
    -- catch exception
	exception 
	   --when sqlstate 'P0002' then  --> this is same as the row below
	   when no_data_found then 
	      raise exception 'Film % not found', v_film_id;
end;
$$
language plpgsql;

-- "too_many_rows" occurs below, because "select into" returns more than one row

do
$$
declare
	rec record;
begin
	-- select film 
	select film_id, title 
	into strict rec
	from film
	where title LIKE 'A%';
	
	exception 
	   when too_many_rows then
	      raise exception 'Search query returns too many rows';
end;
$$

-- Handling multiple exceptions

do
$$
declare
	rec record;
	v_length int = 90;
begin
	-- select a film 
	select film_id, title 
	into strict rec
	from film
	where length = v_length;
	
    -- catch exception
	exception 
	   when no_data_found then 
	      raise exception 'film with length % not found', v_length;
	   when too_many_rows then 
	      raise exception 'The film with length % is not unique', v_length;
end;
$$


╭───────────────────╮
│  Create function  │
╰───────────────────╯
/*
Create function
*/

create function get_film_count(len_from int, len_to int)
	returns int
	language plpgsql  --> which procedural language used
	as
$$
declare
   film_count integer;
begin
   select count(*) 
   into film_count
   from film
   where length between len_from and len_to;
   
   return film_count;
end;
$$;

-- You will now find it under Schemas => public => Functions

-- Calling a user-defined function

-- Positional notation
select get_film_count(40,90);

-- Named notation

select get_film_count(
	len_from => 40,
	len_to => 90
)

-- Mixed notation

select get_film_count(40, len_to => 90);


╭────────────────────────────╮
│  Function parameter modes  │
╰────────────────────────────╯

/*
Modes: IN, OUT, INOUT
*/


-- IN is default, so "p_film_id" is "IN"
create or replace function find_film_by_id(p_film_id int)
	returns varchar
	language plpgsql
as $$
declare
   film_title film.title%type;
begin
  -- find film title by id
  select title 
  into film_title
  from film
  where film_id = p_film_id;
  
  if not found then
     raise 'Film with id % not found', p_film_id;
  end if;
  
  return title;
  
end;$$

-- OUT

create or replace function get_film_stat(
    out min_len int,
    out max_len int,
    out avg_len numeric) 
language plpgsql
as $$
begin
  
  select min(length),
         max(length),
		 avg(length)::numeric(5,1)
  into min_len, max_len, avg_len
  from film;

end;$$

-- Here we get a record back 

select get_film_stat();

-- To seperate as columns use "select *" (the column names will be min_len etc.)

select * from get_film_stat();

-- INOUT
-- The caller can pass an argument + the function changes the argument

create or replace function swap(
	inout x int,
	inout y int
) 
language plpgsql	
as $$
begin
   select x,y into y,x;
end; $$;

select * from swap(10,20);

╭────────────────────────╮
│  Function Overloading  │
╰────────────────────────╯

/*
Function Overloading

PostgreSQL allows multiple functions to share the same name as long as they have different arguments.

If two or more functions share the same name, the function names are overloaded

*/

-- Here is two functions with the same name

create or replace function get_rental_duration(
	p_customer_id integer
)
	returns integer 
	language plpgsql
as $$
declare 
	rental_duration integer; 
begin
	select 
		sum( extract(day from return_date - rental_date)) 
	into rental_duration 
    from rental 
	where customer_id = p_customer_id;

	return rental_duration;
end; $$

-- The other function (takes one more parameters)

create or replace function get_rental_duration(
	p_customer_id integer, 
	p_from_date date
)
returns integer 
language plpgsql
as $$
declare 
	rental_duration integer;
begin
	-- get the rental duration based on customer_id 
	-- and rental date
	select sum( extract( day from return_date + '12:00:00' - rental_date)) 
	into rental_duration
	from rental 
	where customer_id = p_customer_id and 
		  rental_date >= p_from_date;
	
	-- return the rental duration in days
	return rental_duration;
end; $$

-- This calls the first function
SELECT get_rental_duration(232);

-- This calls the second function
SELECT get_rental_duration(232,'2005-07-01');


╭──────────────────╮
│  Return a table  │
╰──────────────────╯

create or replace function get_film (
  p_pattern varchar
) 
	returns table (
		film_title varchar,
		film_release_year int
	) 
	language plpgsql
as $$
begin
	return query 
		select
			title,
			release_year::integer  --> cast to an integer
		from
			film
		where
			title ilike p_pattern;
end;$$


SELECT * FROM get_film ('Al%');


-- In practice, you often process each individual row before returning

create or replace function get_film (
	p_pattern varchar,
	p_year int
) 
	returns table (
		film_title varchar,
		film_release_year int
	) 
	language plpgsql
as $$
declare 
    var_r record;
begin
	for var_r in(
		select title, release_year 
		from film 
	    where title ilike p_pattern and 
		    release_year = p_year
        ) 
	loop  
		-- Here we process one row at a time
		film_title := upper(var_r.title) ;  
		film_release_year := var_r.release_year;
    	return next; --> adds a row to the returned table
 	end loop;
end; $$ 

SELECT * FROM get_film ('%er', 2006);

╭─────────────────╮
│  Drop function  │
╰─────────────────╯

-- If there is only one
drop function swap;

-- ..otherwise you have to be specific
drop function get_film(varchar, int);