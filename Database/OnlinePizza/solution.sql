
-- CLEAN DATABASE

DROP TABLE IF EXISTS extra_ingredience;
DROP TABLE IF EXISTS ordered_pizza;
DROP TABLE IF EXISTS "order";
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS pizzeria;
DROP TABLE IF EXISTS ingredience;
DROP TABLE IF EXISTS pizza;
DROP TABLE IF EXISTS city;

-- CREATE TABLES (no references)

CREATE TABLE city (
    id INT PRIMARY KEY,
    name VARCHAR(20)
);

CREATE TABLE pizza (
    id INT PRIMARY KEY,
    name VARCHAR(50),
	price NUMERIC(3,0)
);

CREATE TABLE ingredience (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    price NUMERIC(3, 0)
);

-- CREATE TABLES (one reference)

CREATE TABLE pizzeria (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(200),
    city_id INT REFERENCES city(id)
);

CREATE TABLE customer (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(200),
    city_id INT REFERENCES city(id),
    phone_number VARCHAR(20)
);

-- CREATE TABLES (two references)

CREATE TABLE "order" (
    id INT PRIMARY KEY,
    pizzeria_id INT REFERENCES pizzeria(id),
    customer_id INT REFERENCES customer(id),
	created_at TIMESTAMP,
	delivered_at TIMESTAMP,
	note VARCHAR(100)
);

CREATE TABLE ordered_pizza (
    id INT PRIMARY KEY,
    order_id INT REFERENCES "order"(id),
    pizza_id INT REFERENCES pizza(id),
	note VARCHAR(100)
);

CREATE TABLE extra_ingredience (
    ordered_pizza_id INT REFERENCES ordered_pizza(id),
    ingredience_id INT REFERENCES ingredience(id),
	PRIMARY KEY(ordered_pizza_id, ingredience_id)
);

-- INSERT DATA
	
INSERT INTO city(id, name) VALUES
	(301, 'Stockholm'),
	(302, 'Linköping'),
	(303, 'Göteborg');

INSERT INTO pizza(id, name, price) VALUES
	(101, 'Margarita', 89),
	(102, 'Fungi', 94),
	(103, 'Vesuvio', 94),
	(104, 'Hawaii', 99);

INSERT INTO ingredience(id, name, price) VALUES
	(201, 'Pommes frites', 20),
	(202, 'Double dough', 40),
	(203, 'Garlic sauce', 15);
	
INSERT INTO pizzeria(id, name, address, city_id) VALUES
	(601, 'Formaggio', 'Flemingsgatan 73', 301),
	(602, 'Pizzeria Venedig', 'Risbrinksgatan 4', 302),
	(603, 'Pizzeria Mini Mac', 'Fjällgatan 28', 303);
	
INSERT INTO customer(id, name, address, city_id, phone_number) VALUES
	(1, 'Alice', 'Storgatan 3', 301, '073-111 2222'),
	(2, 'Wilma', 'Lilla torget 4B', 302, '070-222 3333'),
	(3, 'Lukas', 'Fjällgatan 5', 303, '070-666 7777');

INSERT INTO "order"(id, pizzeria_id, customer_id, created_at, delivered_at, note) VALUES
	(501, 601, 1, '2023-02-10 12:00',  '2023-02-10 12:25', 'Make them vegan!'),
	(502, 601, 1, '2023-02-10 12:02',  '2023-02-10 12:15', 'Not so much cheese!'),
	(503, 601, 3, '2023-02-10 12:05',  null, null);

INSERT INTO ordered_pizza(id, order_id, pizza_id, note) VALUES
	(401, 501, 101, null),
	(402, 501, 101, null),
	(403, 501, 102, null),
	(404, 501, 102, null),
	(405, 501, 102, null),
	(406, 502, 102, 'Without cheese'),
	(407, 502, 103, null),
	(408, 502, 103, null),
	(409, 503, 104, null);
		
INSERT INTO extra_ingredience(ordered_pizza_id, ingredience_id) VALUES
	(408, 201),
	(409, 202),
	(409, 203);

-- SHOW DATA

SELECT * FROM city;
SELECT * FROM pizza;
SELECT * FROM ingredience;
SELECT * FROM pizzeria;
SELECT * FROM customer;
SELECT * FROM ordered_pizza;
SELECT * FROM "order";
SELECT * FROM extra_ingredience;
