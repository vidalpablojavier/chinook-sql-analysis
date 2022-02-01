/* 
	Main Objective: SQL subqueries, joins (CROSS, INNER, LEFT, SELF) and unions (UNION)
	Author: Pablo Javier Vidal
	Database: Chinook database
*/
------------------------------------------------------------------------------------
-- PART 1: SUBQUERIES 
------------------------------------------------------------------------------------

-- Example of standard subquery
-- The link between the 2 tables is albumid
-- Nested query: return albumid for specific title
-- Outer query: return Track that have that albumid
SELECT trackid, name, albumid
FROM track
WHERE albumid = (
	SELECT albumid 
	FROM album
	WHERE title = 'Let There Be Rock'
	);

-- Example of subquery using IN
-- Link between Customer and Employee table: SupportRepId
-- Nested query: find SupportRepId of Employee that are in Canada
-- Outer query: find Customer that were managed by those SupportRepId
SELECT CustomerId, FirstName, LastName
FROM Customer
WHERE SupportRepId IN (
	SELECT EmployeeId 
	FROM Employee
	WHERE Country = 'Canada'
	);

-- Previous example without using subqueries
-- First query: find all SupportRepId in Canada
-- Second query: use these SupportRepId to create new quary to extract Customer

SELECT EmployeeId 
FROM Employee
WHERE Country = 'Canada';

SELECT CustomerId, FirstName, LastName
FROM Customer
WHERE SupportRepId IN (1,2,3,4,5);


-- Same example with subqueries, adding order by
SELECT CustomerId, FirstName, LastName, SupportRepId
FROM Customer
WHERE SupportRepId IN (
	SELECT EmployeeId 
	FROM Employee 
	WHERE Country = 'CANADA'
	)
ORDER BY SupportRepId ASC;

-- Using subqueries to Combine aggregate functions
-- First step: Compute the SUM() of each album time based on Track it has and group by AlbumId
-- Second step: Get the AVG() of the album times
SELECT AVG(album_time)
FROM (
	SELECT SUM(Track.Milliseconds) AS album_time 
	FROM Track
	GROUP BY AlbumId
	) 
AS album_average_size;
