╭────────────╮
│  Exercise  │
╰────────────╯
/*
Create these two tables
*/

create table people1 (
    id int generated by default as identity,
    name varchar(20) not null,    
    primary key(id)
);

create table people2 (
    id int generated by default as identity,
    name varchar(10) not null,    
    primary key(id)
);

/*

Create a stored procedure "multi_people_insert" which takes one parameter, a name.

It should insert the name to both tables. In a transaction.

*/

-- This
call multi_people_insert('Kalle');
-- ...should insert Kalle into both tables

-- This
call multi_people_insert('Xxxxxxxxxxxxxxx'); -- 15 charactar long
-- ...shouldn't do anything since the "people2" don't accept so long names

/*
Finally remove the stored procedure and the tables
*/

-- Solution

create or replace procedure multi_people_insert(
	name_to_insert varchar
)
language plpgsql    
as $$
begin

	insert into people1(name) values(name_to_insert);
	insert into people2(name) values(name_to_insert);
  commit;

end;$$

select * from people1;
select * from people2;

drop procedure multi_people_insert;

drop table people1;
drop table people2;


╭────────────╮
│  Exercise  │
╰────────────╯
/*
Create this table
*/

CREATE TABLE payment_sudden_change_of_price (
   id INT GENERATED ALWAYS AS IDENTITY,
   payment_id INT NOT NULL REFERENCES payment(payment_id),
   from_amount numeric NOT NULL,
   to_amount numeric NOT NULL,
   changed_on TIMESTAMP(6) NOT NULL
);

/*
Create a function "log_sudden_amount_change". It should insert a line in payment_sudden_change_of_price 
if "amount" is changed by more than 5 (up or down)

Create a trigger "log_sudden_amound_change"

Hint: you can use "ABS" to check the difference between two numbers
*/


-- since the following statement changes the amount more than 5, a line in "payment_sudden_change_of_price" should be added
update payment set amount = 100 where payment_id=17503;

select * from payment_sudden_change_of_price;

-- no rows should be added in "payment_sudden_change_of_price" after these statements
update payment set amount = 101 where payment_id=17503;
update payment set amount = 99 where payment_id=17503;

-- one row should be added in "payment_sudden_change_of_price" here
update payment set amount = 120 where payment_id=17503

-- one row should be added in "payment_sudden_change_of_price" here
update payment set amount = 100 where payment_id=17503;

-- Solution

--drop function log_sudden_amount_change

CREATE OR REPLACE FUNCTION log_sudden_amount_change()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
BEGIN

	IF ABS(NEW.amount - OLD.amount) > 5 THEN
		 INSERT INTO payment_sudden_change_of_price(
			 payment_id,
			 from_amount,
			 to_amount,
			 changed_on
		 )
		 VALUES(
			 OLD.payment_id,
			 OLD.amount,
			 NEW.amount,
			 now()
		 );
	END IF;

	RETURN NEW;
END;
$$

--drop trigger sudden_amount_change on payment;

CREATE TRIGGER sudden_amount_change
  BEFORE UPDATE
  ON payment
  FOR EACH ROW
  EXECUTE PROCEDURE log_sudden_amount_change();
