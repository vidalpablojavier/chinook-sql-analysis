/* 
	Main objective: Practicing SQL basics (SELECT, FROM, WHERE):
	Author: Pablo Javier Vidal
	Database: Chinook database
*/


-- Select a column from a table
SELECT Name
FROM MediaType;

-- Select all columns from a TABLE
SELECT *
FROM Artist;


-- Select some columns from a table
SELECT FirstName, LastName, Company
FROM Customer;

-- Select a column from a TABLE renaming table and field.
SELECT A.Name AS 'Old Name'
FROM Artist AS A;