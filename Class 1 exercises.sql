-- SELECT *
-- FROM album
-- LIMIT 15;

-- EXERCISE #1
-- What are the genres in the database? 
-- SELECT *
-- FROM genre;

-- What are the customer names that are from California? 
-- SELECT lastname, firstname
-- FROM customer
-- Where state = 'CA'
-- LIMIT 10000;



-- EXERCISE #2
-- How many tracks are longer than 10 minutes?
-- SELECT COUNT(*)
-- FROM track
-- WHERE milliseconds > 600000;

-- How many invoices were there between January 1, 2010 and February 1, 2010?
-- SELECT COUNT(*)
-- FROM invoice
-- WHERE invoicedate BETWEEN '2010-01-01 00:00:00' AND '2010-02-01 00:00:00';

-- How many tracks have a NULL composer?
-- SELECT COUNT(*)
-- FROM track
-- WHERE Composer IS NULL;

-- How many distinct album titles are there?
-- SELECT COUNT(DISTINCT title)
-- FROM album;

-- How many distinct album IDs are there?
-- SELECT COUNT(DISTINCT albumid)
-- FROM album;

-- SELECT COUNT(albumid)
-- FROM album;



-- EXERCISE #3
-- What are the 5 longest tracks?
-- SELECT name, milliseconds/1000./60. 
-- FROM track
-- ORDER BY milliseconds DESC
-- LIMIT 10;

-- R.E.M. has collaborated with a couple artists, 
-- can you find which artists they’ve collaborated with? 
-- SELECT *
-- FROM artist
-- WHERE name LIKE '%R.E.M%'

-- How many love songs are there? 
-- SELECT count(*)
-- FROM track
-- WHERE name LIKE 'love%' OR name LIKE '% love%' 
-- 	OR name LIKE '%loving%';



-- EXERCISE #4
-- How many tracks are rock or alternative?
-- SELECT COUNT(*)
-- FROM track 
-- JOIN genre 
-- ON track.genreid = genre.genreid
-- WHERE genre.name LIKE '%rock%' OR genre.name LIKE '%alternative%';

-- What are the 5 longest songs?
-- SELECT track.name, track.milliseconds/1000./60., mediatype.name
-- FROM track 
-- JOIN mediatype
-- ON track.mediatypeid = mediatype.mediatypeid
-- WHERE mediatype.name LIKE '%audio%'
-- ORDER BY milliseconds DESC
-- LIMIT 10;

-- How many tracks are performed by R.E.M.?
-- SELECT COUNT(*)
-- FROM track 
-- JOIN album
-- ON track.albumid = album.albumid
-- JOIN artist
-- ON album.artistid = artist.artistid
-- WHERE artist.name LIKE '%R.E.M%';

-- What is the most popular artist in CA?
-- SELECT artist.name, COUNT(*)
-- FROM invoice 
-- JOIN invoiceline
-- ON invoice.invoiceid = invoiceline.invoiceid
-- JOIN track
-- ON invoiceline.trackid = track.trackid
-- JOIN album
-- ON track.albumid = album.albumid
-- JOIN artist
-- ON album.artistid = artist.artistid
-- WHERE billingstate LIKE 'CA'
-- GROUP BY artist.name
-- ORDER BY COUNT(*) DESC
-- LIMIT 10;



-- EXERCISE #5
-- What was the sales total for January 2010
-- SELECT SUM(total)
-- FROM invoice
-- WHERE invoicedate >= '2010-01-01 00:00:00' AND invoicedate < '2010-02-01 00:00:00';

-- What is the average length of a song by R.E.M.?
-- SELECT AVG(milliseconds/1000./60.) as minutes
-- FROM track as t
-- JOIN album as a
-- 	ON t.albumid = a.albumid
-- JOIN artist as art
-- 	ON a.artistid = art.artistid
-- WHERE art.name LIKE '%R.E.M%';


-- EXERCISE #6
-- Which Artists have the most Tracks?
-- SElECT art.name, COUNT(*)
-- FROM artist as art
-- JOIN album as alb
-- 	ON art.artistid = alb.artistid
-- JOIN track as t
-- 	ON t.albumid = alb.albumid
-- GROUP BY art.name
-- ORDER BY COUNT(*) DESC
-- LIMIT 10;

--2. Which Albums have the longest playing time?
-- SELECT a.title, SUM(milliseconds)/1000.0/60.0 as minutes
-- FROM album as a
-- JOIN track as t
-- 	ON t.albumid = a.albumid
-- GROUP BY a.title
-- ORDER BY minutes DESC
-- LIMIT 10;

-- Bonus: How does the answer for #2 change if you limited the results to music?
-- SELECT mediatype.name
-- FROM mediatype;
-- SELECT a.title, SUM(milliseconds)/1000.0/60.0 as minutes
-- FROM album as a
-- JOIN track as t
-- 	ON t.albumid = a.albumid
-- JOIN mediatype as m
-- 	ON m.mediatypeid = t.mediatypeid
-- WHERE m.name LIKE '%audio%'
-- GROUP BY a.title
-- ORDER BY minutes DESC
-- LIMIT 10;


-- What is the list of average song name listing in descending order?
-- SELECT art.name, AVG(milliseconds/1000./60.) as minutes
-- FROM track as t
-- JOIN album as a
-- 	ON t.albumid = a.albumid
-- JOIN artist as art
-- 	ON a.artistid = art.artistid
-- GROUP BY art.name
-- ORDER BY minutes DESC;

-- What is the average price of a track
-- SELECT AVG(unitprice) as dollars
-- FROM track t;

-- What's the name of the oldest employee
-- SELECT firstname, lastname, birthdate
-- FROM employee
-- ORDER BY birthdate
-- LIMIT 5;

-- How many hours of content are in the iTunes library?
-- SELECT SUM(milliseconds)/1000.0/60.0/60.0 
-- FROM track;

-- How many customers use a yahoo email address
-- SELECT COUNT(*)
-- FROM customer
-- WHERE email LIKE '%@yahoo%';

-- How many different countries have been invoiced?
-- SELECT COUNT(DISTINCT billingcountry)
-- FROM invoice;

-- How many customers don't have a State in their customer profiles?
-- SELECT COUNT(*)
-- FROM customer
-- WHERE state IS NULL

-- Which Genre name has the fewest tracks?
-- SELECT g.name, COUNT(t.name) as count
-- FROM track as t
-- JOIN genre as g
--  ON t.genreid = g.genreid
-- GROUP BY g.name
-- ORDER BY count;

-- What is the most number of tracks on an album? 
-- SELECT a.title, COUNT(t.name) as count
-- FROM track as t
-- JOIN album as a
-- 	ON t.albumid = a.albumid
-- GROUP BY a.title
-- ORDER BY count DESC
-- LIMIT 20;

-- What is the name of the longest R&B/Soul track?
-- SELECT genre.name
-- FROM genre;

-- SELECT t.name, t.milliseconds/1000.0/60.0 as minutes
-- FROM track as t
-- JOIN genre as g
-- 	ON t.genreid = g.genreid
-- WHERE g.name = 'R&B/Soul'
-- ORDER BY minutes DESC
-- LIMIT 10;

-- What are the names of the music videos???
-- SELECT mediatype.name
-- FROM mediatype
-- LIMIT 30;


