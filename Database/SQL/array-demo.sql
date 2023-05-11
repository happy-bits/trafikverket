-- Cleanup

drop table if exists contacts;
drop table if exists person;

-- Setup

CREATE TABLE contacts (
	id serial PRIMARY KEY,
	name VARCHAR (100),
	phones TEXT []
);

-- Add a contact which contains an array of phone numbers

INSERT INTO contacts (id, name, phones)
VALUES(1,'John Doe',ARRAY [ '070-1111222','070-3333444' ]);

-- Shorter syntax

INSERT INTO contacts (id, name, phones)
VALUES(2, 'Lily Bush','{"08-11 11 11"}'),
      (3,'William Gate','{"031-22 22 22","031-33 44 55"}');

-- Filter on second element
select name from contacts
where phones[2] = '031-33 44 55';

-- Modify by content of an array
update contacts
set phones[2] = '070-4444444'
where id=1;

-- Modify the whole array
update contacts
set phones = '{"020 11 11 11", "020 77 77 77"}'
where id=1;

select * from contacts;

-- Search regardless of position

select * from contacts
where '020 77 77 77' = any(phones);

-- Expand to a list of rows

select name, unnest(phones) from contacts;

--- One more example with array on int's

create table person (
	id int primary key,
	name VARCHAR (100),
	score int[]
);

insert into person(id, name, score) values
	(1, 'John Doe', array[7, 9, 8]);
	
-- alternative syntax

insert into person(id, name, score) values
	(2, 'John Toe', '{5, 5, 4}'),
	(3, 'John Boe', '{3, 8, 14}');
		
select * from person;

-- Pick the first value of the array

select name, score[1] from person;

-- Expand

select name, unnest(score) from 
person 
where id=1;

-- Just another usecase (array of text for alias)

CREATE TABLE people
(
   id serial,
   full_name text,
   aliases text[]
);

-- You can make two dimensional arrays(!)
-- https://www.postgresql.org/docs/current/arrays.html

CREATE TABLE sal_emp (
    name            text,
    pay_by_quarter  integer[],
    schedule        text[][]
);

CREATE TABLE tictactoe (
    squares   integer[3][3]
);
