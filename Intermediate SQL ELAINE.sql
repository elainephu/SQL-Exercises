
-- Practice Queries
SELECT *
FROM album
LIMIT 100;

SELECT *
FROM track
Limit 100;

-- Review Exercise
-- How many days of content are there in the library? 
SELECT SUM(milliseconds)/1000./60./60./24. AS days
FROM track;

-- What are the longest songs (excludingvideo)? 
SELECT *
FROM track t
JOIN mediatype m ON t.mediatypeid = m.mediatypeid
WHERE m.name ILIKE '%audio%'
ORDER BY milliseconds DESC
LIMIT 10;

-- What is the average length of a song grouped by genre (convert time to minutes)?
SELECT g.name, AVG(milliseconds)/1000./60. as minutes
FROM track t
JOIN mediatype m ON t.mediatypeid = m.mediatypeid
JOIN genre g ON t.genreid = g.genreid
WHERE m.name ILIKE '%audio%'
GROUP BY g.name
ORDER BY minutes DESC
LIMIT 10000;

-- Exercise #1
-- Which customers have spent more than $40
-- (Use Group By and Having for the customer and invoice tables)?
SELECT c.firstname, 
       c.lastname, 
       SUM(i.total) as t
FROM customer c
  JOIN invoice i ON c.customerid = i.customerid
GROUP BY c.customerid
  HAVING SUM(i.total) > 40
ORDER BY t DESC
LIMIT 10000;

-- What are the total sales by month
--(Use Extract and Group By for the invoice table)?
SELECT SUM(i.total), 
       EXTRACT(year from i.invoicedate)||'-'||
       EXTRACT(month from i.invoicedate) AS year_month
FROM invoice i
GROUP BY year_month
ORDER by year_month
LIMIT 10000;

-- Create a roster of employees with their bosses
-- (Join the employees table to itself by using table aliases)?
SELECT e1.firstname||' '||e1.lastname AS "Boss", 
       e2.firstname||' '||e2.lastname AS "Employee Name"
FROM employee e1
RIGHT JOIN employee e2 ON e1.employeeid = e2.reportsto
LIMIT 10000;


-- Exercise #2
-- Using the iowa liquor products table, create an alcohol type label 
-- for whisky, vodka, tequila, rum, brandy, schnapps and any other liquor types
-- (hint: use CASE STATEMENT and LIKE)?
SELECT DISTINCT category_name,
  CASE
  WHEN category_name ILIKE '%whiskies%' OR category_name 
                     ILIKE '%bourbon%' OR category_name 
                     ILIKE '%scotch%' THEN 'whisky'
  WHEN category_name ILIKE '%vodka%' THEN 'vodka'
  WHEN category_name ILIKE '%tequila%' THEN 'tequila'
  WHEN category_name ILIKE '%rum%' THEN 'rum'
  WHEN category_name ILIKE '%brandies%' THEN 'brandy'
  WHEN category_name ILIKE '%schnapps%' THEN 'schnapps'
  ELSE 'other'
END as "Alcohol Type"
FROM iowa_products;

SELECT DISTINCT category_name
FROM iowa_products;

-- Using the catalog and online tables, create a customer list that combines 
-- the names from the catalog and online tables using UNION without creating 
-- duplicates.
SELECT customerid, firstname AS "First Name", lastname as "Last Name"
FROM catalog
UNION
SELECT customerid, firstname, lastname
FROM online
ORDER BY "Last Name", "First Name";

-- FULL JOIN the catalog and online tables and inspect the results.
-- Try adding the catalog sales and online sales totals together. 
-- Why do you get errors?
SELECT coalesce(c.firstname, o.firstname) as firstname, 
       coalesce(c.lastname, o.lastname) as lastname,       
       c.catalogpurchases, o.onlinepurchases,      
       coalesce(c.catalogpurchases, 0) + coalesce(o.onlinepurchases, 0) as total
FROM catalog c
FULL JOIN online o ON c.customerid = o.customerid;

SELECT firstname, lastname
FROM online
ORDER BY lastname;

-- Exercise #3
-- How many iowa liquor vendors have more than $1 million in 2014 sales 
-- (hint: use subquery to group sales by vendor)?

WITH select_vendors AS (  
  SELECT EXTRACT(year from date) AS year, vendor_no, SUM(total) as total
  FROM iowa_sales
  WHERE EXTRACT(year from date) = 2014
  GROUP BY vendor_no, year)
 SELECT COUNT(vendor_no)
  FROM select_vendors
  WHERE total > 1000000;
  
-- Group sales by month with a subquery and then calculate cumulative sales 
-- by month for 2014 (using iowa sales table)
-- WITH select_vendors AS (  
WITH select_vendors AS (  
  SELECT EXTRACT(month from date) AS month, 
         EXTRACT(year from date) AS year, 
         SUM(total) as total
  FROM iowa_sales
  WHERE EXTRACT(year from date) = 2014
  GROUP BY month, year)
 SELECT month, SUM(total)
 OVER (ORDER BY month)
 FROM select_vendors;


-- Create a View that adds liquor type to the iowa product data. 
-- Don't forget to commit your changes.

CREATE VIEW liquor_type AS
SELECT *,
  CASE
  WHEN category_name ILIKE '%whiskies%' OR category_name 
                     ILIKE '%bourbon%' OR category_name 
                     ILIKE '%scotch%' THEN 'whisky'
  WHEN category_name ILIKE '%vodka%' THEN 'vodka'
  WHEN category_name ILIKE '%tequila%' THEN 'tequila'
  WHEN category_name ILIKE '%rum%' THEN 'rum'
  WHEN category_name ILIKE '%brandies%' THEN 'brandy'
  WHEN category_name ILIKE '%schnapps%' THEN 'schnapps'
  ELSE 'other'
END as "Alcohol Type"
FROM iowa_products;

COMMITT;

SElECT *
FROM liquor_type;


