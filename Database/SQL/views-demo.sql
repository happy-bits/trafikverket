/*

VIEW

Purpose: learn to use views and create updatable views

https://www.postgresqltutorial.com/postgresql-views/
https://www.postgresqltutorial.com/postgresql-views/postgresql-updatable-views/

*/

-- Use the database "dvdrentals" and create the following view

CREATE VIEW customer_master AS
	SELECT 
		cu.customer_id AS id,
		cu.first_name || ' ' || cu.last_name AS name,
		a.address,
		a.postal_code AS "zip code",
		a.phone,
		city.city,
		country.country,
			CASE
				WHEN cu.activebool THEN 'active'
				ELSE ''
			END AS notes,
		cu.store_id AS sid
	FROM customer cu
		INNER JOIN address a USING (address_id)
		INNER JOIN city USING (city_id)
		INNER JOIN country USING (country_id);

-- Try the view

SELECT * FROM customer_master

-- Change the view by adding a column (email)

CREATE OR REPLACE VIEW customer_master AS ----------> new
	SELECT 
		cu.customer_id AS id,
		cu.first_name || ' ' || cu.last_name AS name,
		a.address,
		a.postal_code AS "zip code",
		a.phone,
		city.city,
		country.country,
			CASE
				WHEN cu.activebool THEN 'active'
				ELSE ''
			END AS notes,
		cu.store_id AS sid,
		cu.email ----------> new
	FROM customer cu
		INNER JOIN address a USING (address_id)
		INNER JOIN city USING (city_id)
		INNER JOIN country USING (country_id);

-- Detail: you can't drop a column from an existing view

-- Rename the view to "customer_info"
ALTER VIEW customer_master RENAME TO customer_info

-- Get all rows from customer_info

SELECT * FROM customer_info

-- Remove the view

DROP VIEW customer_info 

-- Remove the view, if you don't know if it exists or not

DROP VIEW IF EXISTS customer_info 

-- Create an updatable view

CREATE VIEW usa_cities AS 
    SELECT
        city,
        country_id
    FROM
	    city
    WHERE
	    country_id = 103;

-- Select all

SELECT * FROM usa_cities;

-- Just to see the change...
SELECT * FROM city WHERE city LIKE 'San %'

-- Insert a row in the view, it will affect "city" (!)

INSERT INTO usa_cities (city, country_id)
VALUES('San Jose', 103);

-- Just to see the change...
SELECT * FROM city WHERE city LIKE 'San %'


-- Remove San Jose

DELETE
FROM
	usa_cities
WHERE
	city = 'San Jose';