
/* 
	Main Objective: SQL subqueries, joins (CROSS, INNER, LEFT, SELF) and unions (UNION)
	Author: Pablo Javier Vidal
	Database: Chinook database
	
*/
------------------------------------------------------------------------------------
-- PART 2: JOINS (CROSS, INNER, LEFT, SELF) - * - * - * - 
------------------------------------------------------------------------------------



-- Example of cross join: important to specify table in SELECT if same column in both tables
SELECT album.AlbumId, trackid
FROM album
CROSS JOIN track;

-- Inner join: join Track and Album based on the album id
SELECT trackid, name, title
FROM track
INNER JOIN album ON album.albumid = track.albumid;

-- Same example: you can see that it matches the albumid column of Track with the albumid column of Album
SELECT trackid, name, track.albumid AS album_id_Track, album.albumid AS 'album_id_Album', title
FROM track
INNER JOIN album ON album.albumid = track.albumid;

-- Another inner join example
SELECT Title, Name
FROM album
INNER JOIN artist ON artist.ArtistId = album.ArtistId;

-- Same example but now using aliases to simplify (l for Album and r for Artist)
SELECT l.Title, r.Name
FROM album l
INNER JOIN artist r ON r.ArtistId = l.ArtistId;

-- Same example: no need to specify table if both columns have the same name
SELECT Title, Name
FROM album
INNER JOIN artist USING (ArtistId);

-- inner join with 3 tables: Track, Album and Artist
-- Link between Album table and Artist table is ArtistId
-- Link between Track table and Album table is AlbumId
SELECT trackid, track.name AS track, album.title AS album, artist.name AS artist
FROM track
INNER JOIN album ON album.albumid = track.albumid
INNER JOIN artist ON artist.artistid = album.artistid;

-- Same example, filtering results by adding a where clause at the end
SELECT trackid, track.name AS Track, album.title AS Album, artist.name AS Artist
FROM track
INNER JOIN album ON album.albumid = track.albumid
INNER JOIN artist ON artist.artistid = album.artistid
WHERE artist.artistid = 10;

-- Left join: all rows in table Artist are included in the result set whether there are matching rows in table Album or not
SELECT Name, Title
FROM artist
LEFT JOIN album ON artist.ArtistId = album.ArtistId
ORDER BY Name;

-- Left join and adding a WHERE clause
SELECT Name, Title
FROM artist
LEFT JOIN album ON artist.ArtistId = album.ArtistId
WHERE Title IS NULL   
ORDER BY Name;

-- Cross join example
SELECT album.AlbumId
FROM album
CROSS JOIN track;

-- Union to combine results between queries
-- The JOIN clause combines columns from multiple related tables, 
-- while UNION combines rows from multiple similar tables.
SELECT FirstName, LastName, 'Employee' AS Type
FROM employee
UNION
SELECT FirstName, LastName, 'Customer'
FROM customer;

-- Same as last example, order by added at the end
SELECT FirstName, LastName, 'Employee' AS Type
FROM employee
UNION
SELECT FirstName, LastName, 'Customer'
FROM customer
ORDER BY FirstName, LastName;