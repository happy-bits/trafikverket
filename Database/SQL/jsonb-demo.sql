
CREATE TABLE orders (
	id serial NOT NULL PRIMARY KEY,
	info json NOT NULL
);

-- Add orders with some json data (productname and quantity)
INSERT INTO orders (info)
VALUES
	('{ "customer": "John Doe", "items": {"product": "Beer","qty": 6}}'),
	('{ "customer": "Lily Bush", "items": {"product": "Diaper","qty": 24}}'),
    ('{ "customer": "Josh William", "items": {"product": "Toy Car","qty": 1}}'),
    ('{ "customer": "Mary Clark", "items": {"product": "Toy Train","qty": 2}}');

-- Get the column "info" 
SELECT info FROM orders;

-- Get the value from the key 'customer' - in json format
select info -> 'customer' from orders;

-- The same but in text format
select info ->> 'customer' from orders;

-- Chain expressions. Dig into the json

select 
	info -> 'items' ->> 'product',
	info -> 'items' ->> 'qty'
from orders

-- Filtering, by look at values in the json

select info ->> 'customer' as customer
from orders
where info -> 'items' ->> 'product' = 'Diaper';

-- Filtering with cast (convert a string to an integer)

SELECT * 
FROM orders
WHERE CAST ( info -> 'items' ->> 'qty' AS INTEGER) = 2

-- Aggregate functions to JSON data

select
	min( cast ( info -> 'items' ->> 'qty' AS INTEGER)), -- 1
	max( cast ( info -> 'items' ->> 'qty' AS INTEGER)), -- 24
	sum( cast ( info -> 'items' ->> 'qty' AS INTEGER)), -- 33
	avg( cast ( info -> 'items' ->> 'qty' AS INTEGER))  -- 8.25
	
from orders

/*
Note, the first customer (id=1) has this json
'{ "customer": "John Doe", "items": {"product": "Beer","qty": 6}}

"json_each" expands (outmost) json object into a set of key-value pairs
Here we get two rows from one json cell (customer and items)
*/

select json_each(info) from orders where id=1

-- We only get the keys here (as strings)
select json_object_keys(info) from orders where id=1
/*
customer
items
*/

-- Get the keys within a json object
select json_object_keys(info ->'items') from orders where id=1
/*
product
qty
*/

/*
Check the type of a part of a json, e.g
- object
- string
- null
*/

select json_typeof (info) from orders where id=1
--object

select json_typeof (info -> 'customer') from orders where id=1
-- string

select json_typeof (info -> 'items' -> 'qty') from orders where id=1
-- number

select json_typeof (info -> 'items' -> 'aaaa' -> 'bbb') from orders where id=1
-- null
