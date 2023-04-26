/*
Chinook 02

Joining two tables
*/

-- 1) List all artist together with album titles. Sort by artist name

SELECT artist.name artistname, album.title albumtitle 
FROM artist LEFT JOIN album
ON album.artistid = artist.artistid
ORDER BY artistname

-- Alternative with "USING"
SELECT artist.name artistname, album.title albumtitle 
FROM artist LEFT JOIN album
USING(artistid)
ORDER BY artistname

-- 2) List the first names of all customers and their support representatives.

SELECT customer.firstname customer_firstname, employee.firstname employee_firstname
FROM customer 
JOIN employee ON supportrepid = employeeid

-- 3) List the names of all tracks that starts with the word "I" and their genre-names. 
--    Sort the result by the name of the track.

SELECT track.name, genre.name FROM track 
JOIN genre ON track.genreid = genre.genreid
WHERE track.name LIKE 'I %'
ORDER BY track.name

-- Alternative: If we want to include **I'm**, **I've** etc:

SELECT track.name, genre.name FROM track 
JOIN genre ON track.genreid = genre.genreid
WHERE track.name LIKE 'I %' OR  track.name LIKE 'I''%'
ORDER BY track.name


-- 4) List the tracks for all playlist
--    Columns to show: playlist id, name of the track
--    Order by playlist id and then name of track
--    Hint: you need to JOIN three tables, like this:
--    SELECT ... FROM table1 JOIN table 2 ON ... JOIN table3 ON ...

/*

Expected result:

18	Now's The Time
17	2 Minutes To Midnight
17	Ace Of Spades
17	Balls to the Wall
17	Crazy Train
17	Creeping Death
17	Enter Sandman
...

*/


SELECT playlist.playlistid, track.name
FROM track JOIN playlisttrack ON track.trackid = playlisttrack.trackid
JOIN playlist ON playlisttrack.playlistid = playlist.playlistid
ORDER BY playlist.playlistid desc, track.name
