/* 
	Main Objective: SQL subqueries, joins (CROSS, INNER, LEFT, SELF) and unions (UNION)
	Author: Pablo Javier Vidal
	Database: Chinook database
*/

------------------------------------------------------------------------------------
-- PART 3: Examples more complicated for data analysis
------------------------------------------------------------------------------------



-- We need a table of Album titles and unit prices for a specific artist
-- Artist --- Album --- Track
SELECT Album.Title, Track.UnitPrice
FROM Album
INNER JOIN Track ON Album.AlbumId = Track.AlbumId -- join Album and Track based on album id
INNER JOIN Artist ON Artist.ArtistID = Album.ArtistID -- join Artist and Album based on artist id
WHERE Artist.Name = 'Audioslave'; -- find artist id for that name

-- Find the first and last name of any customer who does not have an invoice
SELECT n.FirstName, n.LastName, i.Invoiceid
FROM customer n 
	LEFT JOIN invoice i ON n.Customerid = i.Customerid
WHERE InvoiceId IS NULL;




-- Find the total price for each album.
SELECT t.Title, SUM(p.UnitPrice)
FROM Album t
	INNER JOIN Track p ON t.Albumid = p.Albumid
WHERE t.Title = 'Big Ones'
GROUP BY t.Title;

-- Find many records are created when you apply a Cartesian join to the invoice and invoice items table
-- SELECT a.invoiceId D
-- FROM Invoice a CROSS JOIN invoice_items b;

-- Using a subquery, find the names of all the Track for the album "Californication"
SELECT Track.Name FROM Track where Track.AlbumId =
(SELECT AlbumId FROM Album WHERE Album.Title = 'Californication');

--Find the total number of Invoice for each customer along with the customer's full name, city and email.
-- Invoice and Customer: customerid in common
-- we want to find the Customer who have Invoice = inner join
SELECT FirstName, LastName, City, Email, COUNT(I.CustomerId) AS Nbr_Invoice
FROM Customer C 
INNER JOIN Invoice I
ON C.CustomerId = I.CustomerId
GROUP BY C.CustomerId;

--Retrieve the track name, album, artistID, and trackID for all the Album.
SELECT A.Title, T.Name, A.AlbumId, A.ArtistId, T.TrackId
FROM Album A
INNER JOIN Track T
ON T.AlbumId = A.AlbumId;

--Retrieve a list with the managers last name, and the last name of the Employee who report to him or her.
SELECT M.LastName AS 'Manager', E.LastName AS 'Employee'
FROM Employee E 
INNER JOIN Employee M 
ON E.ReportsTo = M.EmployeeID;

--Find the name and ID of the Artist who do not have Album.
SELECT Name AS 'Artist',
       Artist.ArtistId,
       Album.Title AS Album
FROM Artist
LEFT JOIN Album
ON Artist.ArtistId = Album.ArtistId
WHERE Album IS NULL;

--Using a UNION to create a list of all the employee's and customer's first names 
-- and last names ordered by the last name in descending order.
SELECT FirstName, LastName
FROM Employee
UNION
SELECT FirstName, LastName
FROM Customer
ORDER BY LastName DESC;

--See if there are any Customer who have a different city listed in their billing city versus their customer city.
SELECT C.FirstName, C.LastName, C.City AS CustomerCity, I.BillingCity
FROM Customer C
INNER JOIN Invoice I
ON C.CustomerId = I.CustomerId
WHERE CustomerCity <> BillingCity;



-- 6. Provide a query that shows the Invoice associated with each sales agent. The resultant table should include the Sales Agent's full name.
SELECT
  i.InvoiceId,
  (e.FirstName || " " || e.LastName) as Name
FROM Invoice i
  LEFT JOIN Customer c ON c.CustomerId = i.CustomerId
  LEFT JOIN Employee e ON c.SupportRepId = e.EmployeeId;

-- 7. Provide a query that shows the Invoice associated with each sales agent. The resultant table should include the Sales Agent's full name.
SELECT (Employee.FirstName || " " || Employee.lastName) as SalesAgentName, Invoice.InvoiceId as AssociatedInvoice
FROM Invoice
JOIN Customer ON Invoice.CustomerId = Customer.CustomerId
JOIN Employee ON Employee.EmployeeId = Customer.SupportRepId;



-- Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all Invoice and Customer.
SELECT (Customer.FirstName || " " || Customer.LastName) AS CustomerName, Customer.Country,
Invoice.Total AS InvoiceTotal, (Employee.FirstName || " " || Employee.LastName) AS SalesAgent
FROM Customer
JOIN Invoice ON Invoice.CustomerId = Customer.CustomerId
JOIN Employee ON Employee.EmployeeId = Customer.SupportRepId;

-- SELECT COUNT(Invoice.InvoiceId) AS InvoiceCount, SUM(Invoice.Total) as TotalSales, strftime('%Y', Invoice.InvoiceDate) AS InvoiceYear
-- FROM Invoice
-- WHERE strftime('%Y', Invoice.InvoiceDate) = "2009" OR strftime('%Y', Invoice.InvoiceDate) = "2011"
-- GROUP BY InvoiceYear

-- How many Invoice were there in 2009 and 2011? What are the respective total sales for each of those years?

SELECT COUNT(Invoice.InvoiceId) AS InvoiceCount, SUM(Invoice.Total) as TotalSales, strftime('%Y', Invoice.InvoiceDate) AS InvoiceYear
FROM Invoice
WHERE strftime('%Y', Invoice.InvoiceDate) = "2009" OR strftime('%Y', Invoice.InvoiceDate) = "2011"
GROUP BY InvoiceYear;


-- query that shows which sales agent made the most in sales in 2009.

SELECT e.EmployeeId, e.FirstName|| ' '|| e.LastName as Full_Name,sum (i.total) AS Total_per_Agent
FROM Customer as c, Invoice as i, Employee as e
WHERE c.CustomerId=i.CustomerId
AND c.SupportRepId=e.EmployeeId
AND i.invoiceDate BETWEEN "2009-01-01" AND "2009-12-31"
GROUP BY c.SupportRepId 
ORDER BY Total_per_Agent DESC limit 1;



-- 7. Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all Invoice and Customer.
SELECT
  (c.FirstName || " " || c.LastName) as CustomerName,
  (e.FirstName || " " || e.LastName) as SalesAgentName,
  i.Total,
  i.BillingCountry
FROM Invoice i
  LEFT JOIN Customer c ON c.CustomerId = i.CustomerId
  LEFT JOIN Employee e ON c.SupportRepId = e.EmployeeId;

-- 8. How many Invoice were there in 2009 and 2011? What are the respective total sales for each of those years?
SELECT
  (SELECT
    COUNT(*)
  FROM Invoice i
  WHERE SUBSTR(i.InvoiceDate,0,5) = "2009") AS Invoice09,
  (SELECT
    COUNT(*)
    FROM Invoice i
    WHERE SUBSTR(i.InvoiceDate,0,5) = "2011") AS Invoice11;

-- 9. Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.
SELECT
  COUNT(*)
FROM InvoiceLine il WHERE il.InvoiceId = 37;

-- 10. Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice.
SELECT
  InvoiceId,
  COUNT(*)
FROM InvoiceLine il
GROUP BY InvoiceId;

-- 11. Provide a query that includes the track name with each invoice line item.
SELECT
  t.Name,
  il.*
FROM InvoiceLine il
LEFT JOIN Track t ON t.TrackId = il.TrackId;

-- 12. Provide a query that includes the purchased track name AND artist name with each invoice line item.
SELECT
  t.Name as Song,
  ar.Name AS Artist,
  il.* FROM InvoiceLine il
LEFT JOIN Track t ON t.TrackId = il.TrackId
LEFT JOIN Album al ON al.AlbumId = t.AlbumId
LEFT JOIN Artist ar ON ar.ArtistId = al.ArtistId;

-- 13. Provide a query that shows the # of Invoice per country.
SELECT
  Invoice.BillingCountry,
  COUNT(*)
FROM Invoice
GROUP BY BillingCountry;

-- 14. Provide a query that shows the total number of Track in each playlist. The Playlist name should be included on the resultant table.
SELECT
  p.Name,
  COUNT(*)
FROM Playlist p
LEFT JOIN PlaylistTrack pt ON pt.PlaylistId = p.PlaylistId
GROUP BY pt.PlaylistId;

-- 15. Provide a query that shows all the Track, but displays no IDs. The resultant table should include the Album name, Media type and Genre.
SELECT
  t.Name AS Song,
  a.Title as Album,
  mt.Name AS MediaType,
  g.Name AS Genre
FROM Track t
LEFT JOIN MediaType mt on mt.MediaTypeId = t.MediaTypeId
LEFT JOIN Album a ON a.AlbumId = t.AlbumId
LEFT JOIN Genre g ON g.GenreId = t.GenreId;

-- 16. Provide a query that shows all Invoice but includes the # of invoice line items.
SELECT
  i.*,
  COUNT(*) as LineCount
FROM Invoice i
LEFT JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY i.InvoiceId;


-- 17. Provide a query that shows total sales made by each sales agent.
SELECT
  e.FirstName || " " || e.lastName as Name,
  COUNT(*) AS Sales
FROM Employee e
JOIN Customer c ON c.SupportRepId = e.EmployeeId
JOIN Invoice i ON i.CustomerId = c.CustomerId
GROUP BY EmployeeId;

-- 18. Which sales agent made the most in sales in 2009?
  -- Margaret Park
SELECT
  e.FirstName || " " || e.lastName as Name,
  COUNT(*) AS Sales
FROM Employee e
JOIN Customer c ON c.SupportRepId = e.EmployeeId
JOIN Invoice i ON i.CustomerId = c.CustomerId
WHERE SUBSTR(i.InvoiceDate,0,5) = "2009"
GROUP BY EmployeeId
ORDER BY Sales DESC;

-- 19. Which sales agent made the most in sales in 2010?
  -- Jane Peacock
SELECT
  e.FirstName || " " || e.lastName as Name,
  COUNT(*) AS Sales
FROM Employee e
JOIN Customer c ON c.SupportRepId = e.EmployeeId
JOIN Invoice i ON i.CustomerId = c.CustomerId
WHERE SUBSTR(i.InvoiceDate,0,5) = "2010"
GROUP BY EmployeeId
ORDER BY Sales DESC;

-- 20. Which sales agent made the most in sales over all?
  -- Jane Peacock
SELECT
  e.FirstName || " " || e.lastName as Name,
  COUNT(*) AS Sales
FROM Employee e
JOIN Customer c ON c.SupportRepId = e.EmployeeId
JOIN Invoice i ON i.CustomerId = c.CustomerId
GROUP BY EmployeeId
ORDER BY Sales DESC;

-- 21. Provide a query that shows the # of Customer assigned to each sales agent.
SELECT
  e.EmployeeId,
  e.FirstName || " " || e.LastName as Employee,
  COUNT(*)
FROM Customer c
JOIN Employee e ON e.EmployeeId = c.SupportRepId
GROUP BY e.EmployeeId;

-- 22. Provide a query that shows the total sales per country. Which country's Customer spent the most?
  -- USA
SELECT
  BillingCountry,
  SUM(Total)
FROM Invoice
GROUP BY BillingCountry
ORDER BY SUM(Total) DESC;

-- 23. Provide a query that shows the most purchased track of 2013.
  -- All track were purchased no more than once.
SELECT
  t.TrackId,
  COUNT(*)
FROM InvoiceLine il
JOIN Track t ON t.TrackId = il.TrackId
JOIN Invoice i ON i.InvoiceId = il.InvoiceId
WHERE SUBSTR(i.InvoiceDate,0,5) = "2013"
GROUP BY il.TrackId
ORDER BY COUNT(*) DESC;

-- 24. Provide a query that shows the top 5 most purchased Track over all.
  -- There are at least 50 tied for first place.
SELECT
  t.TrackId,
  COUNT(*)
FROM InvoiceLine il
JOIN Track t ON t.TrackId = il.TrackId
GROUP BY il.TrackId
ORDER BY COUNT(*) DESC;

-- 25. Provide a query that shows the top 3 best selling Artist.
SELECT
  ar.Name,
  COUNT(*)
FROM InvoiceLine il
LEFT JOIN Track t ON t.TrackId = il.TrackId 
LEFT JOIN Album al ON al.AlbumId = t.AlbumId
LEFT JOIN Artist ar ON ar.ArtistId = al.ArtistId
GROUP BY ar.ArtistId
ORDER BY COUNT(*) DESC
LIMIT 3;

-- 26. Provide a query that shows the most purchased Media Type.
  -- MPEG
SELECT
  mt.Name,
  COUNT(*)
FROM InvoiceLine il
LEFT JOIN Track t ON t.TrackId = il.TrackId
LEFT JOIN MediaType mt ON mt.MediaTypeId = t.MediaTypeId
GROUP BY t.MediaTypeId
ORDER BY COUNT(*) DESC;




-- Provide a query that includes the track name with each invoice line item.
SELECT InvoiceLine.*, Track.Name AS TrackName
FROM InvoiceLine
JOIN Track ON InvoiceLine.TrackId = Track.TrackId;

--  Provide a query that includes the purchased track name AND artist name with each invoice line item.
SELECT Track.Name AS TrackName, Artist.Name AS ArtistName, InvoiceLine.InvoiceLineId AS AssociatedInvoiceLine
FROM Track
JOIN Album ON Album.AlbumId = Track.AlbumId
JOIN Artist ON Album.ArtistId = Artist.ArtistId
JOIN InvoiceLine ON InvoiceLine.TrackId = Track.TrackId;

