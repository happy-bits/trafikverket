
create table category(
	id int primary key,
	name varchar(20)
);

create table product(
	id int primary key,
	name varchar(20),
	price numeric(3),
	category_id int references category(id)
);

insert into category values
	(1, 'Bread'),
	(2, 'Fruit'),		
	(3, 'Cheese');	
	
insert into product values
	(100, 'Red apple', 7, 2),
	(101, 'Green apple', 6, 2),
	(102, 'Brie', 25, 3);
	
select * from category;
select * from product;

select product.name, category.name 
from product join category 
on product.category_id = category.id;

/*

The last query will output:

"Red apple"		"Fruit"
"Green apple"	"Fruit"
"Brie"			"Cheese"

*/