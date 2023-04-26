/*
Errors and Messages

Syntax:

    raise level format

level can be
- debug
- log
- notice
- info
- warning
- exception

(default is exception)

"format" is a string with your message
*/

╭──────────────────╮
│  Raising errors  │
╰──────────────────╯

do $$ 
begin 
  raise info 'information message %', now() ; -- to client
  raise log 'log message %', now();
  raise debug 'debug message %', now();
  raise warning 'warning message %', now();   -- to client
  raise notice 'notice message %', now();     -- to client
end $$;

/*
What is reported is controlled by settings
- client_min_messages
- log_min_messages


"hint" provide the hint message so that the root cause of the error is easier to be discovered.

Besides "hint" you can use other options to give more inforation e.g: message, detail, errcode. 

*/

do $$ 
declare
  email varchar(255) := 'info@postgresqltutorial.com';
begin 
  -- check email for duplicate
  -- ...
  -- report duplicate email
  raise exception 'duplicate email: %', email 
      using hint = 'check the email again';

end $$;

-- There exist some build in exception like "invalid_regular_expression"

do $$ 
begin 
	--...
	raise invalid_regular_expression;
end $$;


╭─────────────────────╮
│  Assert statements  │
╰─────────────────────╯

/*

To insert debugging checks in the code.
Use it only for debugging.

*/

-- This assertion will pass 

do $$
declare 
   film_count integer;
begin
   select count(*)
   into film_count
   from film;
   
   assert film_count > 0, 'Film not found, check the film table';
end$$;


-- This will give errormessage (since there are not so many films)

do $$
declare 
   film_count integer;
begin
   select count(*)
   into film_count
   from film;
   
   assert film_count > 1000, 'Didn''t expect so few films';
end$$;



╭──────╮
│  If  │
╰──────╯
/*
if statements
*/

-- "found" is a global variable that is set by "select into"

do $$
declare
  selected_film film%rowtype;
  input_film_id film.film_id%type := 0;
begin  

  select * from film
  into selected_film
  where film_id = input_film_id;
  
  if not found then
     raise notice'The film % could not be found', 
	    input_film_id;
  end if;
end $$


╭───────────╮
│  If-else  │
╰───────────╯
-- if-else

do $$
declare
  selected_film film%rowtype;
  input_film_id film.film_id%type := 100;
begin  

  select * from film
  into selected_film
  where film_id = input_film_id;
  
  if not found then
     raise notice 'The film % could not be found', 
	    input_film_id;
  else
     raise notice 'The film title is %', selected_film.title;
  end if;
end $$



╭─────────────────╮
│  If-then-elsif  │
╰─────────────────╯
-- if-then-elsif

do $$
declare
   v_film film%rowtype;
   len_description varchar(100);
begin  

  select * from film
  into v_film
  where film_id = 100;
  
  if not found then
     raise notice 'Film not found';
  else
      if v_film.length >0 and v_film.length <= 50 then
		 len_description := 'Short';
	  elsif v_film.length > 50 and v_film.length < 120 then
		 len_description := 'Medium';
	  elsif v_film.length > 120 then
		 len_description := 'Long';
	  else 
		 len_description := 'N/A';
	  end if;
    
	  raise notice 'The % film is %.',
	     v_film.title,  
	     len_description;
  end if;
end $$


╭────────╮
│  Case  │
╰────────╯

do $$
declare 
	rate   film.rental_rate%type;
	price_segment varchar(50);
begin
    -- get the rental rate (get one row from the "film" table)
    select rental_rate into rate 
    from film 
    where film_id = 100;
	
	-- assign the price segment
	if found then
		case rate
		   when 0.99 then
              price_segment =  'Mass';
		   when 2.99 then
              price_segment = 'Mainstream';
		   when 4.99 then
              price_segment = 'High End';
		   else
	    	  price_segment = 'Unspecified';
		   end case;
		raise notice '%', price_segment;  
    end if;
end; $$


╭─────────────╮
│  Case when  │
╰─────────────╯

do $$ 
declare
    total_payment numeric; 
    service_level varchar(25) ;
begin
     select sum(amount) into total_payment
     from Payment
     where customer_id = 100; 
	 
	 if found then
       case 
          when total_payment > 200 then
                service_level = 'Platinum' ;
          when total_payment > 100 then
               service_level = 'Gold' ;
          else
                service_level = 'Silver' ;
       end case;
		 raise notice 'Service Level: %', service_level;
     else
	    raise notice 'Customer not found';
	 end if;
end; $$ 


╭────────╮
│  Loop  │
╰────────╯
/*
...until "exit" or "return"
*/

do $$
declare
   n integer:= 20; --> Calculate the n'th fibonacci number
   fib integer := 0;
   counter integer := 0 ; 
   i integer := 0 ; 
   j integer := 1 ;
begin
	if (n < 1) then
		fib := 0 ;
	end if; 
	loop 
		exit when counter = n ; 
		counter := counter + 1 ; 
		select j, i + j into i,	j ; -- i := j
		                            -- j := i+j
		
	end loop; 
	fib := i;
    raise notice '%', fib; 
end; $$


╭──────────────╮
│  While loop  │
╰──────────────╯
/*
While loop
*/

do $$
declare 
   counter integer := 0;
begin
   while counter < 5 loop
      raise notice 'Counter %', counter;
	  counter := counter + 1;
   end loop;
end$$;


╭────────────╮
│  For loop  │
╰────────────╯
/*
For loop
*/


do $$
begin
   for counter in 1..5 loop
	   raise notice 'counter: %', counter;
   end loop;
end; $$

do $$
begin
   for counter in reverse 5..1 loop
      raise notice 'counter: %', counter;
   end loop;
end; $$

do $$
begin 
  for counter in 1..6 by 2 loop           --> adds two after each iteration
      raise notice 'counter: %', counter;
  end loop;
end; $$

-- Iterate over a result set

do
$$
declare
    f record;
begin
    for f in select title, length 
	       from film 
	       order by length desc, title
	       limit 10 
    loop 
		raise notice '% (% mins)', f.title, f.length;
    end loop;
end;
$$


╭─────────────────╮
│  Dynamic query  │
╰─────────────────╯

do $$
declare

   sort_type smallint := 1;  --> how to sort
	rec_count int := 10; --> number of films to show
	rec record; --> a record justed in the for loop
   query text; --> dynamic query
begin
		
	query := 'select title, release_year from film ';
	
	if sort_type = 1 then		
		query := query || 'order by title'; --> add text at the end
	elsif sort_type = 2 then
	  query := query || 'order by release_year';
	else 
	   raise 'invalid sort type %s', sort_type;
	end if;

	query := query || ' limit $1';

	for rec in execute query using rec_count
   loop
	     raise notice '% - %', rec.release_year, rec.title;
	end loop;
end;
$$

╭───────────────────╮
│  Exit statements  │
╰───────────────────╯
/*
Exit statements
*/

do
$$
declare 
   i int = 0;
   j int = 0;
begin
  <<outer_loop>>
  loop 
     i = i + 1;
     exit when i > 3;
	 -- inner loop
	 j = 0;
     <<inner_loop>>
     loop 
		j = j + 1;
		exit when j > 3; --> this terminates the current loop (the inner_loop)
		raise notice '(i,j): (%,%)', i, j;
	 end loop inner_loop;
  end loop outer_loop;
end;
$$

-- How to exit a specific block

do
$$
begin  
  <<simple_block>>  
   begin
  	 exit simple_block;
	 raise notice '%', 'unreachable!'; --> This won't happen
   end;
   raise notice '%', 'End of block';
end;
$$


╭────────────╮
│  Continue  │
╰────────────╯
/*
The continue statement prematurely skips the current iteration of the loop and jumps to the next one.
*/

do
$$
declare
   counter int = 0;
begin
  
  loop
     counter = counter + 1;
	 -- exit the loop if counter > 10
	 exit when counter > 10;
	 -- skip the current iteration if counter is an even number
	 continue when mod(counter,2) = 0;
	 -- print out the counter
	 raise notice '%', counter;
  end loop;
end;
$$

