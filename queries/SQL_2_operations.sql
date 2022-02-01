/* 
	Main objective: Creation of SQL queries to try logic operators and filtering clauses (WHERE, BETWEEN, IN, LIKE, ORDER BY, GROUP BY, HAVING)
	Author: Pablo Javier Vidal
	Database: Chinook database
	
*/

-- Filter entries with a simple condition, in this case the time of tracks with more than 900000 seconds.
SELECT Milliseconds
FROM Track
WHERE Milliseconds >= 900000;

-- Provide a query only showing the Customer from Oslo.
SELECT * FROM Invoice
WHERE Invoice.BillingCity = 'Oslo';

-- Filter entries between 2 values (for float numeric)
SELECT Total
FROM Invoice
WHERE Total BETWEEN 0.5 AND 5.5;

-- Filter query using IN
SELECT CustomerId, FirstName, LastName, State, Company
FROM Customer
WHERE State IN ('WA','AB','BC','CA');

-- Filter with combination of IN and AND operator
SELECT CustomerId, InvoiceId, InvoiceDate, Total
FROM Invoice
WHERE CustomerId IN ('4','44') AND Total BETWEEN 0.99 AND 5.00;

-- Filter entries using aliases
SELECT TrackId, Name
FROM Track
WHERE Name LIKE 'It%';


-- Provide a query showing only the Employee who have IT in any part of the title.
SELECT * FROM employee
WHERE employee.title LIKE '%IT%';


-- Filter query for hotmail 
SELECT Email, CustomerId
FROM Customer
WHERE Email LIKE '%hotmail.com';

-- Filter entries and order rows by descending order
SELECT InvoiceId, BillingCity, Total
FROM Invoice
WHERE BillingCity IN ('Helsinki','Lisbon')
ORDER BY InvoiceId DESC;

-- Provide a query showing a unique list of composers from the Track table.
SELECT DISTINCT Track.Composer 
FROM Track;


-- Show all distinct values of a column
SELECT DISTINCT City
FROM customer;

-- Find minimun and maximum value of a column
SELECT MIN(Track.Milliseconds)
FROM Track;

SELECT MAX(Track.Milliseconds)
FROM Track;


-- Find minimun value of a column using a condition
Select MIN(Track.Milliseconds)
FROM Track
WHERE Track.Milliseconds > 10000;

-- Filter column with a condition
SELECT InvoiceId, CustomerId, Total
FROM Invoice
WHERE Total = 0.99;

-- Filter with a condition and order by ascending order based on a specific column
SELECT InvoiceId, CustomerId, Total
FROM Invoice
WHERE Total = 0.99
ORDER BY CustomerId ASC;

-- Create new column for calculations
SELECT (MAX(Track.Milliseconds) - MIN(Track.Milliseconds)) AS 'Maximum Track Range' -- in some cases the new new of the column no need use '', for better understanding of the new column I put ''.
FROM Track;

-- Count all rows of a table
SELECT COUNT(*) AS nbr_Invoice
FROM Invoice;

-- Count all non NULL values for a column
SELECT COUNT(CustomerId) AS nbr_Customer
FROM Invoice;

-- Using the GROUP BY clause to group entries based on a specific metric (one row = one group)
SELECT AlbumId, COUNT(Trackid) AS Nbr_Track
FROM Track
GROUP BY AlbumId;


--  The top city for Invoice dollars was Prague with an amount of 90.24
SELECT BillingCity, SUM(Total) AS Invoice_total
FROM Invoice
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;


-- Use the PlaylistTrack table to determine the playlist that have the most tracks. 
-- Provide a table of PlaylistId ordered by the number of 
-- tracks for each playlist. The playlist with the most tracks should appear first.
SELECT PlaylistTrack.PlaylistId, COUNT(*) AS 'Invoice Number'
FROM PlaylistTrack
GROUP BY 1 --group by column 1
ORDER BY 2 DESC --ordered by column 2


-- Grouping by a metric and filtering the groups
SELECT AlbumId, COUNT(Trackid) AS Nbr_Track
FROM Track
GROUP BY AlbumId
HAVING Nbr_Track >= 12;

-- Grouping by a metric, filtering the groups and ordering the groups
SELECT AlbumId, COUNT(Trackid) AS Nbr_Track
FROM Track
GROUP BY AlbumId
HAVING Nbr_Track >= 19
ORDER BY Nbr_Track ASC;


-- Provide a query that includes the track name with each invoice line item.
SELECT I.*, T.name
FROM InvoiceLine I, Track T
ON I.trackid = T.trackid;

-- 3. Provide a query showing the Invoice of Customer who are from Brazil. The resultant 
-- table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
SELECT c.firstname, c.lastname, i.invoiceid, i.invoicedate, i.billingcountry
FROM Customer c, Invoice i
WHERE c.country = 'USA' AND c.customerid = i.customerid;

-- Provide a query that includes the track name with each invoice line item.
SELECT I.*, T.name
FROM InvoiceLine as I, Track T
ON I.trackid = T.trackid;