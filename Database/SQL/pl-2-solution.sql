
╭────────────╮
│  Exercise  │
╰────────────╯
/*
Raise a warning. Expected output:

WARNING:  This is a warning
*/

-- Solution

do $$ 
begin 
  raise warning 'This is a warning';
end $$;


╭────────────╮
│  Exercise  │
╰────────────╯
/*

Declare a variable "lang_id" and set it to a number.

Show two different messages depending on if the language exists or not

E.g:

NOTICE:  The language with id 3 is Japanese  

E.g

NOTICE:  The language 555 could not be found
*/

-- Solution

do $$
declare
  selected_language language%rowtype;
  
  lang_id integer := 555;
begin  

  select * from language 
  into selected_language
  where language_id = lang_id;
  
  if not found then
     raise notice 'The language % could not be found', 
	    lang_id;
  else
     raise notice 'The language with id % is %', selected_language.language_id, selected_language.name;
  end if;
end $$


╭────────────╮
│  Exercise  │
╰────────────╯
/*

Declare an integer with the name "value" and another integer with name "iterations"

Write the value, then the value*2 then the value *2*2 etc.

E.g if "value" is 100 and "iterations" is 5, then output:

NOTICE:  100
NOTICE:  200
NOTICE:  400
NOTICE:  800
NOTICE:  1600

*/

-- Solution

do $$
declare
   value integer:= 100; 
   iterations integer:= 5; 
begin
	loop
		exit when iterations = 0; 	
		raise notice '%', value;		
		value := value * 2;	
		iterations := iterations - 1;			
	end loop; 
end; $$


╭────────────╮
│  Exercise  │
╰────────────╯
/*

Write the id and name of the first five cities (sort by the name of the city):

NOTICE:  A Corua (La Corua) has id 1
NOTICE:  Abha has id 2
NOTICE:  Abu Dhabi has id 3
NOTICE:  Acua has id 4
NOTICE:  Adana has id 5

*/

-- Solution

do
$$
declare
    x record;
begin
    for x in 
      select city, city_id
      from city 
      order by city 
      limit 5
    loop 
		raise notice '% has id %', x.city, x.city_id;
    end loop;
end;
$$




