/*

TODO: Continue adding tables and insert data in the tables. Use your Google-spreadsheet.

Hint: Datatypes to use: 

    NUMERIC
    INT
    TIMESTAMP
    VARCHAR

*/


-- CREATE TABLES 

CREATE TABLE city (
    id INT PRIMARY KEY,
    name VARCHAR(20)
);

CREATE TABLE pizzeria (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(200),
    city_id INT REFERENCES city(id)
);

-- INSERT DATA
	
INSERT INTO city(id, name) VALUES
	(301, 'Stockholm'),
	(302, 'Linköping'),
	(303, 'Göteborg');


INSERT INTO pizzeria(id, name, address, city_id) VALUES
	(601, 'Formaggio', 'Flemingsgatan 73', 301),
	(602, 'Pizzeria Venedig', 'Risbrinksgatan 4', 302),
	(603, 'Pizzeria Mini Mac', 'Fjällgatan 28', 303);
	
-- SHOW DATA

SELECT * FROM city;
SELECT * FROM pizzeria;

