/*

Chinook 01

Exercises with one table at a time

*/


-- 1) Create a database named chinook. Run the script "Chinook_PostgreSql-NoQuotes.sql" to create the music database

-- 2) List all rows (and columns) from the artist table

SELECT * 
FROM artist

-- 3) List all artists' names. Sort by name. 

SELECT name as artistname 
FROM artist 
ORDER BY name

-- 4) List the artists with id 3, 4, 5, 6 or 7

SELECT * FROM artist
WHERE artistid>=3 AND artistid<=7

-- Alternative

SELECT * FROM artist
WHERE artistid between 3 and 7

-- 5) List the artist that have a name that starts with the capital letters B or R 


SELECT * FROM artist
WHERE name like 'B%' or name like 'R%'
ORDER BY name

-- Alternative (with regular expressions)

SELECT * FROM artist
WHERE name ~ '^[BR].*'
ORDER BY name

-- Alternative (with SIMILAR) 

SELECT * FROM artist
WHERE name SIMILAR TO '[BR]%'
ORDER BY name

-- Alternative (with LEFT) 

SELECT * FROM artist
WHERE Left(name, 1)='B' or Left(name,1)='R'
ORDER BY name

-- Alternative (with LEFT and IN) 

SELECT * FROM artist
WHERE Left(name, 1) IN ('B', 'R')
ORDER BY name

-- 6) List title of all albums where the second letter of the title is lowercase "a" and the third letter is lowercsae "r" 

SELECT title 
FROM album 
WHERE title like '_ar%'

-- 7) List email of customers that lives in Copenhagen or Paris

SELECT email FROM customer
WHERE city='Copenhagen' or city='Paris'

-- Alternative

SELECT email FROM customer
WHERE city in ('Copenhagen', 'Paris')

-- 8) Figure out how many invoices that are missing postal code.

SELECT count(*)
FROM Invoice
WHERE billingpostalcode is null

-- 9)  List the first names (in order) for all customers that have Jane or Steve as support representatives. 
--     You don't need to do any join. Start looking at the content of the Employee table

SELECT firstname
FROM customer
WHERE supportrepid in (3,5)
ORDER BY firstname

-- 10) List all cities that customers live in. Only show the cities that contains multiple words: 

/*

"New York"
"Salt Lake City"
"Fort Worth"
"Mountain View"
"São Paulo"
"Buenos Aires"
"São José dos Campos"
"Rio de Janeiro"

*/

SELECT distinct city FROM customer
WHERE city like '% %'
    