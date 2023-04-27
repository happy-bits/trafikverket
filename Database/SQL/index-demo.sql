/*

https://www.postgresqltutorial.com/postgresql-indexes/

PostgreSQL indexes are effective tools to enhance database performance. Indexes help the database server find specific rows much faster than it could do without indexes. 

However, indexes add write and storage overheads to the database system. Therefore, using them appropriately is very important. 

Index is a separated data structure.

*/

╭────────────────────────────╮
│ Create index               │
╰────────────────────────────╯

SELECT * FROM address
WHERE phone = '223664661973';

-- Show query plan

EXPLAIN SELECT * FROM address
WHERE phone = '223664661973';

/*
Seq Scan on address  (cost=0.00..15.54 rows=1 width=61)
Filter: ((phone)::text = '223664661973'::text)

Seq Scan is slow
*/

CREATE INDEX idx_address_phone 
ON address(phone);

EXPLAIN SELECT * FROM address
WHERE phone = '223664661973';

/*
Index Scan using idx_address_phone on address  (cost=0.28..8.29 rows=1 width=61)
Index Cond: ((phone)::text = '223664661973'::text)

Index Scan is fast
*/

╭────────────────────────────╮
│ Drop index                 │
╰────────────────────────────╯

DROP INDEX IF EXISTS idx_address_phone 

-- Note: we don't mention which table

╭────────────────────────────╮
│ List index                 │
╰────────────────────────────╯

-- PostgreSQL List Indexes using pg_indexes View


-- List all indexes of the schema public in the current database

SELECT
    tablename,
    indexname,
    indexdef
FROM
    pg_indexes
WHERE
    schemaname = 'public'
ORDER BY
    tablename,
    indexname;

-- List all indexes for the customer table

SELECT
    indexname,
    indexdef
FROM
    pg_indexes
WHERE
    tablename = 'customer';

/*
Using psql, you can use the \d command. To return info about the address table:

	\d address

You get info about the columns and other info like:

Indexes:
    "address_pkey" PRIMARY KEY, btree (address_id)
    "idx_address_phone" btree (phone)
    "idx_fk_city_id" btree (city_id)
	
*/

╭────────────────────────────╮
│ Index types                │
╰────────────────────────────╯

/*
When you use the CREATE INDEX statement without specifying the index type, PostgreSQL uses the B-tree index type by default because it is best to fit the most common queries.

If you have started using an index to optimize your PostgreSQL database, B-tree is probably the one that you want.

Query planner consider using index for operators:

	< <= = >= between in
	is null, is not null

...and LIKE if the text start with a pattern


Other index types
- Hash: only works for =
- GIN: multiple values in a single column (hstore, array, jsonb, range)
- BRIN: on very large tables
- GiST: geometric data or full-text searches
- SP-GiST: GIS, multimedia, IP routing

*/


╭────────────────────────────╮
│ Unique index               │
╰────────────────────────────╯

/*

Only B-tree indexes can be declared as unique indexes.
 
When you define an UNIQUE index for a column, the column cannot store multiple rows with the same values.

If you define a UNIQUE index for two or more columns, the combined values in these columns cannot be duplicated in multiple rows.

PostgreSQL treats NULLs as distinct values, therefore, you can have multiple NULL values in a column with a UNIQUE index.

When you define a primary key or a unique constraint for a table, PostgreSQL automatically creates a corresponding UNIQUE index.

*/

drop table if exists employees;

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
	mobile_phone VARCHAR(20),
	work_phone VARCHAR(20),
	extension VARCHAR(5)	
);

CREATE UNIQUE INDEX idx_employees_mobile_phone
ON employees(mobile_phone);

INSERT INTO employees(first_name, last_name, email, mobile_phone)
VALUES ('John','Doe','john.doe@postgresqltutorial.com', '(408)-555-1234');

-- The following will fail:
INSERT INTO employees(first_name, last_name, email, mobile_phone)
VALUES ('Mary','Jane','mary.jane@postgresqltutorial.com', '(408)-555-1234');

/*
ERROR:  duplicate key value violates unique constraint "idx_employees_mobile_phone"
DETAIL:  Key (mobile_phone)=((408)-555-1234) already exists.
*/

-- Multiple columns example

CREATE UNIQUE INDEX idx_employees_workphone
ON employees(work_phone, extension);

-- These two inserts works

INSERT INTO employees(first_name, last_name, work_phone, extension)
VALUES('Lily', 'Bush', '(408)-333-1234','1212');

INSERT INTO employees(first_name, last_name, work_phone, extension)
VALUES('Joan', 'Doe', '(408)-333-1234','1211');

-- This wont work
INSERT INTO employees(first_name, last_name, work_phone, extension)
VALUES('Tommy', 'Stark', '(408)-333-1234','1211');

/*
ERROR:  duplicate key value violates unique constraint "idx_employees_workphone"
DETAIL:  Key (work_phone, extension)=((408)-333-1234, 1211) already exists.
*/
╭────────────────────────────╮
│ Index on expressions       │
╰────────────────────────────╯
/*

Index based on an expression that involves table columns. 

Quite expensive

*/

EXPLAIN
SELECT 
    customer_id, 
    first_name, 
    last_name 
FROM 
    customer 
WHERE 
    LOWER(last_name) = 'purdy';

/*
Seq Scan on customer  (cost=0.00..17.98 rows=3 width=17)
Filter: (lower((last_name)::text) = 'purdy'::text)

Seq = slow
*/

drop index if exists idx_ic_last_name;

CREATE INDEX idx_ic_last_name
ON customer(LOWER(last_name));

EXPLAIN
SELECT 
    customer_id, 
    first_name, 
    last_name 
FROM 
    customer 
WHERE 
    LOWER(last_name) = 'purdy';
	
/*
Bitmap Heap Scan on customer  (cost=4.30..11.15 rows=3 width=17)
  Recheck Cond: (lower((last_name)::text) = 'purdy'::text)
  ->  Bitmap Index Scan on idx_ic_last_name  (cost=0.00..4.30 rows=3 width=0)
        Index Cond: (lower((last_name)::text) = 'purdy'::text)

Index Scan = fast        
*/	
╭────────────────────────────╮
│ Partial index              │
╰────────────────────────────╯

/*
Reduces the size of the index, if there are a lot of rows you're not interested in
*/

-- If you often want to find customers that has active = 0, you can instead of creating this index:

CREATE INDEX idx_customer_active
ON customer(active);

-- ... create this partial index. This will reduce the index size.

CREATE INDEX idx_customer_inactive
ON customer(active)
WHERE active = 0;


-- This will show that we use a "Index scan"
EXPLAIN SELECT
    customer_id,
    first_name,
    last_name,
    email
FROM
    customer
WHERE
    active = 0;

-- The following rows isn't indexed, so here we get a slow "Seq Scan"
EXPLAIN SELECT
    customer_id,
    first_name,
    last_name,
    email
FROM
    customer
WHERE
    active = 1;

╭────────────────────────────╮
│ Reindex                    │
╰────────────────────────────╯

-- In practice, an index can become corrupted and no longer contains valid data due to hardware failures or software bugs. 
-- To recover the index, you can use the REINDEX statement:

-- You can recreate indexes on many different levels

REINDEX INDEX index_name;
REINDEX TABLE table_name;   
REINDEX SCHEMA schema_name;
REINDEX DATABASE database_name;

╭────────────────────────────╮
│ Multicolumn index          │
╰────────────────────────────╯
/*

You can create an index on more than one column of a table. 

When defining a multicolumn index, you should place the columns which are often used in the WHERE clause at the beginning of the column list

*/

CREATE TABLE people(
    id INT GENERATED BY DEFAULT AS IDENTITY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

EXPLAIN SELECT
    *
FROM
    people
WHERE
    last_name = 'Adams';
-- Seq Scan :(

-- Run script to insert 10.000 names (10000-names.sql)

EXPLAIN SELECT
    *
FROM
    people
WHERE
    last_name = 'Adams';	
-- Seq Scan :(

--  Add a index for both columns. Assuming that lastname-search is more common

CREATE INDEX idx_people_names 
ON people (last_name, first_name);

EXPLAIN SELECT
    *
FROM
    people
WHERE
    last_name = 'Adams';
	
-- Index Scan :)

EXPLAIN SELECT
    *
FROM
    people
WHERE
    last_name = 'Adams'
AND first_name = 'Lou';
-- Index Scan :)

EXPLAIN SELECT
    *
FROM
    people
WHERE
    first_name = 'Lou';
	
-- Seq Scan :(


