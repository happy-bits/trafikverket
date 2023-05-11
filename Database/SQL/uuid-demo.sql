-- Install the uuid-ossp module (needed for generating UUIDs)
-- You will see this under "Extensions" in the database
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- To generate the UUID values based on the combination of computer’s MAC address, current timestamp, and a random value, you use the uuid_generate_v1() function:

SELECT uuid_generate_v1();

-- Generate a UUID value solely based on random numbers
SELECT uuid_generate_v4();

-- Setup two tables contacts, and people. Pretend that "people" comes from another database

CREATE TABLE contacts (
    contact_id uuid DEFAULT uuid_generate_v4(), --> Will autogenerate uuid's
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    phone VARCHAR,
    PRIMARY KEY (contact_id)
);

CREATE TABLE people (
    contact_id uuid DEFAULT uuid_generate_v4(), 
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    phone VARCHAR,
    PRIMARY KEY (contact_id)
);



INSERT INTO contacts (
    first_name,
    last_name,
    email,
    phone
)
VALUES
    (
        'John',
        'Smith',
        'john.smith@example.com',
        '408-237-2345'
    ),
    (
        'Jane',
        'Smith',
        'jane.smith@example.com',
        '408-237-2344'
    ),
    (
        'Alex',
        'Smith',
        'alex.smith@example.com',
        '408-237-2343'
    );

INSERT INTO people (
    first_name,
    last_name,
    email,
    phone
)
VALUES
    (
        'Mary',
        'Jones',
        'mary.jones@example.com',
        '444-333-2222'
    ),
    (
        'Peter',
        'Gray',
        'peter.gray@example.com',
        '888-777-6666'
    );


-- Let's merge the tables
-- Extrem low risk that the id's will collide

SELECT * 
INTO result_table
FROM contacts
UNION
SELECT * FROM people;


SELECT * FROM result_table

