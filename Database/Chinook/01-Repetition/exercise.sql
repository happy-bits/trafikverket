-- Chinook 01 - Repetition

-- 1) List all media types in order:

/*
    AAC audio file
    MPEG audio file
    Protected AAC audio file
    Protected MPEG-4 video file
    Purchased AAC audio file
*/

-- 2) List all Genres with a higher Id than 20 - in reverse order:

/*
genreid	name
======= ====
25	    Opera
21	    Drama
22	    Comedy
24	    Classical
23	    Alternative
*/

-- 3) List all artists starting with "Academy" (Name)

-- 4) List all albums where the first letter of the title is a vowel
--    Hint: the basic solution contains a lot of ILIKE
--    Advanced solution: use "regular expressions" https://hevodata.com/learn/postgresql-regex/ 

-- 5) List the names of tracks composed by REM that are longer than 4 minutes

-- 6) List the tracks with id's 10-20 and 50-60

-- 7) List track with names that start with the word "You". But not: Your, You're, You've.

-- 8) List the id, and name for all customers and sort the list so the longest *lastname* shows first. 
--    The result should be something LIKE this:

/*
customerid	firstname	    lastname
48	        Johannes	    Van der Berg
5	        František	    Wichterlová
26	        Richard	        Cunningham
*/

-- 9)  List the full names of customers that have FirstName and LastName that starts with the same letter 
/*
fullname
----------------
Helena Holý
Joakim Johansson
*/