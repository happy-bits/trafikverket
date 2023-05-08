
-- Create database

create table customer_level(
	id serial primary key,
	name varchar(50),
	discount numeric(2,0)
);

insert into customer_level(id, name, discount) values
	(1, 'Gold', 20),
	(2, 'Silver', 15);

create table problem(
	id serial primary key,
	name varchar(50)
);

insert into problem values
	(1, 'Front tire'),
	(2, 'Back tire'),
	(3, 'Lights'),
	(4, 'Battery');

create table model(
	id serial primary key,
	name varchar(50),
	released timestamp,
	battery_power int,
	top_speed int
);

insert into model values
	(1, 'Xiaomi Mi', '2022-01-01', 150, 35);

-- (one foreign key)

create table customer(
	id serial primary key,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(100),
	username varchar(20),
	password varchar(30),
	phonenumber varchar(30),
	customer_level_id int,
	foreign key(customer_level_id) references customer_level(id)
);

insert into customer values
	(1, 'John', 'Doe', 'jd@gmail.com', 'jonny123', 'qwerty', 1);

create table card(
	id serial primary key,
	card_number varchar(50),
	expires timestamp,
	name_on_card varchar(50),
	owned_by_customer_id int references customer(id),
	is_preferred boolean
);

insert into card(id, card_number, expires, name_on_card, owned_by_customer_id, is_preferred) values
	(1, '515300223344', '2023-05-05', 'John Doe',  1, true);

create table scooter(
	id serial primary key,
	article_number varchar(50),
	battery_level numeric(3,1),
	bought timestamp,
	bought_price numeric(5,0),
	model_id int references model(id),
	position point
);

insert into scooter values
	(1, 'ABC-123456', 80, '2023-03-01', 4290, 1, '11.97,57.71');

-- (two foreign keys)

create table scooter_problem(
	scooter_id int references scooter(id),
	problem_id int references problem(id),
	primary key(scooter_id, problem_id)
);

insert into scooter_problem values
	(1, 1),
	(1, 3),
	(1, 4);

create table ride(
	id serial primary key,
	start_position point,
	start_time timestamp,
	end_position point,
	end_time timestamp,
	price numeric(3,0),
	paid_date timestamp,
	rating int,
	customer_id int references customer(id),
	scooter_id int references scooter(id)
);

insert into ride values
	(1, 
	 '11.90, 57.70', '2023-03-05 12:01', 
	 '11.91, 57.72', '2023-03-05 12:08',
	 19,
	 '2023-03-05 12:10',
	 5,
	 1,
	 1
	);
	
-- Get data

select * from card;
select * from customer;
select * from customer_level;
select * from model;
select * from problem;
select * from ride;
select * from scooter;
select * from scooter_problem;
	
	