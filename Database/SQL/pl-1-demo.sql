
/*
PostgreSQL PL/pgSQL (Procedural Language/PostgreSQL)

Used to develop user-defined functions and stored procedures.

PL/pgSQL procedural language that adds many procedural elements, e.g., control structures, loops, and complex computations, to extend standard SQL. It allows you to develop complex functions and stored procedures in PostgreSQL that may not be possible using plain SQL.

https://www.postgresqltutorial.com/postgresql-plpgsql/

*/

╭───────────╮
│  Strings  │
╰───────────╯
-- A normal select

select 'String constant';

-- Double fnutt if you want one fnutt

select 'I''m also a string constant';

/*

With dollar quotes $$ you kan put ' and \ without doubling

select $$I'm a string constant$$;
select $$I'm a string constant that contains a backslash \$$;

*/

╭───────────────────╮
│  Anonymous block  │
╰───────────────────╯

/*
"do" executes an anonymous block

a block contains a declaration (optional) and a body. 
*/

do $$ 
<<first_block>>
declare
  film_count integer := 0;
begin
   -- get the number of films
   select count(*) 
   into film_count
   from film;
   -- display a message (% is a placeholder)
   raise notice 'The number of films is %', film_count;
end first_block $$;


╭─────────────╮
│  Variables  │
╰─────────────╯

-- Every variable has a datatype like: integer, numeric, varchar, char

do $$ 
declare
   counter    integer := 1;
   first_name varchar(50) := 'John';
   last_name  varchar(50) := 'Doe';
   payment    numeric(11,2) := 20.5;
begin 
   raise notice '% % % has been paid % USD', 
      counter, 
	   first_name, 
	   last_name, 
	   payment;
end $$;

-- now, pg_sleep and variable assignment

do $$ 
declare
   created_at time := now();
begin 
   raise notice '%', created_at;
   perform pg_sleep(3);          -- waits for 3 seconds
   raise notice '%', created_at; -- the same value
end $$;

╭──────────────────────╮
│  Copying data types  │
╰──────────────────────╯

do $$ 
declare
	-- film_title get the datatype of the column film.title
   -- great because then we don't need to know the exact type here
   film_title film.title%type; 
   
begin 
   -- get title of the film id 100
   select title
   from film
   into film_title       --> set the variable "film_title"
   where film_id = 100;
   
   -- show the film title
   raise notice 'Film title id 100: %s', film_title;
end; $$


╭──────────────────────╮
│  Block and subblock  │
╰──────────────────────╯


do $$ 
<<outer_block>>
declare
  counter integer := 0;
begin
   counter := counter + 1;
   raise notice 'The current value of the counter is %', counter;

   declare
       counter integer := 0;
   begin
       counter := counter + 10; ---> this affects only the local variable
       raise notice 'Counter in the subblock is %', counter;
       raise notice 'Counter in the outer block is %', outer_block.counter;
   end;

   raise notice 'Counter in the outer block is %', counter;
   
end outer_block $$;

╭────────────────────────╮
│  Select into variable  │
╰────────────────────────╯

-- select data and assign it to a variable

do $$
declare
   actor_count integer; 
begin
   -- select the number of actors from the actor table
   select count(*)
   into actor_count
   from actor;

   -- show the number of actors
   raise notice 'The number of actors: %', actor_count;
end; $$


╭────────────────╮
│  Row variable  │
╰────────────────╯

/*
Declare a row variable that hold a complete row
*/

do $$
declare
	-- "selected_actor" gets the datatype of a row in "actor"
   selected_actor actor%rowtype;
   
   -- "record" works as well
begin
   -- select actor with id 10   
   select * 
   from actor
   into selected_actor
   where actor_id = 10;

   -- show the number of actor
   raise notice 'The actor name is % %',
      selected_actor.first_name,
      selected_actor.last_name;
	  
	  -- selected_actor.xxxxxxx would give the error
	  -- record "selected_actor" has no field "xxxxxxx"
end; $$

╭────────────────╮
│  Record types  │
╰────────────────╯

/*
Similar to row-type but it doesn't have a predefined structure
*/

do
$$
declare
	rec record;
begin
	-- select the film 
	select film_id, title, length 
	into rec
	from film
	where film_id = 200;
	
	raise notice '% % %', rec.film_id, rec.title, rec.length;   
	-- you get error if you try to access a field that doesn't exist
end;
$$


╭──────────────────╮
│  Record and for  │
╰──────────────────╯
/*
Using record variables in the for loop statement
*/

do
$$
declare
	rec record;
begin
	for rec in select title, length 
			from film 
			where length > 50
			order by length
	loop --> Start of loop
		raise notice '% (%)', rec.title, rec.length;	
	end loop;
end;
$$

╭─────────────╮
│  Constants  │
╰─────────────╯

do $$ 
declare
   vat constant numeric := 0.1;
   net_price    numeric := 20.5;
begin
   raise notice 'The selling price is %', net_price * ( 1 + vat );
end $$;
