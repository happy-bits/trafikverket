╭────────────╮
│  Exercise  │
╰────────────╯
/*
Write a query to list all indexes in "address"
*/
-- Solution

SELECT
    indexname,
    indexdef
FROM
    pg_indexes
WHERE
    tablename = 'address';	

╭────────────╮
│  Exercise  │
╰────────────╯
/*
List all addresses in California

Verify that the query plan uses Seq Scan (slow)

"Seq Scan on address  (cost=0.00..15.54 rows=9 width=77)"
"  Filter: ((district)::text = 'California'::text)"
*/
-- Solution

explain select * from address where district='California'
╭────────────╮
│  Exercise  │
╰────────────╯
/*
Add a suitable index

Verify that the query plan now uses Index Scan (faster)

"Bitmap Heap Scan on address  (cost=4.34..12.87 rows=9 width=77)"
"  Recheck Cond: ((district)::text = 'California'::text)"
"  ->  Bitmap Index Scan on idx_address_district  (cost=0.00..4.34 rows=9 width=0)"
"        Index Cond: ((district)::text = 'California'::text)"
*/
-- Solution
create index idx_address_district on address(district)

explain select * from address where district='California'

╭────────────╮
│  Exercise  │
╰────────────╯
/*
Add two columns in address: lat and long

They should be numeric with precision 8 and scale 6
*/

-- Solution

alter table address add lat numeric(8, 6);
alter table address add long numeric(8, 6);

╭────────────╮
│  Exercise  │
╰────────────╯
/*
Lat and long should combined be unique. Add a suitable index.

Verify by updating lat and long for id 1,2,3 to the following values:

1	"47 MySakila Drive"		57.700000	11.970000
2	"28 MySQL Boulevard"	57.700000	11.980000
3	"23 Workhaven Lane"	 	57.800000	11.980000

*/

-- Solution

create unique index idx_address_lat_long on address(lat, long);

update address set lat = 57.7, long=11.97 where address_id=1; 
update address set lat = 57.7, long=11.97 where address_id=2; --> fail
update address set lat = 57.7, long=11.98 where address_id=2;
update address set lat = 57.7, long=11.98 where address_id=3; --> fail
update address set lat = 57.8, long=11.98 where address_id=3; 

select address_id, address, lat, long from address order by address_id limit 3
