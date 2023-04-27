
╭────────────╮
│  Exercise  │
╰────────────╯
/*
Create a table "order_codes" with two columns:

- code_a (integer)
- code_b (integer)

Add one million row. Let each cell have a random value between 1 to a million

Use the "bench" function described here:
https://www.tangramvision.com/blog/how-to-benchmark-postgresql-queries-well

...to measure the median value to execute these queries:

select * from order_codes order by code_a limit 100
select * from order_codes order by code_b limit 100

Add an index for column "code_a" and measure again to see if you get improvements.

Hint: to calulate a random number use "random()"
Hint: to take to integer part of a number use "floor()"

*/
