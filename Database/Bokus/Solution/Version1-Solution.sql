-- Create database

create table author(
	id serial primary key,
	name varchar(50)
);

create table publisher(
	id serial primary key,
	name varchar(50),
	street varchar(50),
	zip_code varchar(50)
);

create table book(
	id serial primary key,
	isbn varchar(50),
	title varchar(50),
	published timestamp,
	nr_of_pages int,
	weight int,
	main_author_id int references author(id),
	publisher_id int references publisher(id)
);

create table customer(
	id serial primary key,
	loginname varchar(50),
	password varchar(50)
);

create table review(
	book_id int references book(id),
	customer_id int references customer(id),
	created timestamp,
	content varchar(9000)
);

-- Insert content

insert into author(id, name) 
values(1, 'Paul Auster');

insert into publisher(id, name, street, zip_code) 
values(1, 'Norstedt', 'Gatan 123', '443 22');

-- View data from tables

select * from author;
select * from publisher;


