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
