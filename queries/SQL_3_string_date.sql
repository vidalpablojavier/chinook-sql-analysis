

/* 
	Maing Objective: Subject: Strings operations (concatenation, TRIM, SUBSTR, UPPER, LOWER, UCASE, ...), 
                              date/time functions (DATE, TIME, DATETIME, STRFTIME, ...) and CASE
	Author: Pablo Javier Vidal
	Database: Chinook database
	
*/



-- 1. Provide a query showing Customer (just their full names, customer ID and country) who are not in the US.
select firstname || ' ' || lastname, country -- || is like CONCAT in MySQL
from customer
where not country = 'CANADA';

-- Combining 2 string columns together and putting everything upper case
SELECT CustomerId, FirstName, LastName, Address, City, Country, UPPER(City || ' - ' || Country) AS 'CityCountry'
FROM Customer;

-- Extracting substrings, concatenating them together and putting everything lower case
SELECT EmployeeId, FirstName, LastName, LOWER(SUBSTR(FirstName,2,5) || SUBSTR(LastName,2,4)) AS 'NewId'
FROM Employee;

-- Compute the number of years from hire date to the today date
SELECT FirstName, LastName, HireDate, 
(STRFTIME('%Y', 'now') - STRFTIME('%Y', HireDate)) - (STRFTIME('%m-%d', 'now') < STRFTIME('%m-%d', HireDate)) AS 'YearsWorked'
FROM Employee
WHERE YearsWorked >= 15
ORDER BY LastName ASC;

-- Count the number of days since a datetime variable and today'
SELECT 	FirstName, LastName, (ROUND(JULIANDAY('now') - JULIANDAY(HireDate))) AS 'nbr_days_since_hiring'
FROM Employee;

--Select all the invoice data from 2010
SELECT BillingCity,InvoiceDate FROM Invoice
WHERE InvoiceDate BETWEEN '2010-01-01' AND '2010-12-31';


-- Create individual variables to extract the year, month and day
SELECT 	FirstName, LastName, STRFTIME('%Y',HireDate) AS Year, STRFTIME('%m',HireDate) AS Month, STRFTIME('%d',HireDate) AS 'Day'
FROM Employee;

-- Using CASE statements to create new categories
SELECT FirstName, LastName, City,
CASE
WHEN City =='Oslo' THEN 'From Oslo'
WHEN City <> 'Oslo' THEN 'OTHER THAN OSLO'
END AS CityCategory
FROM Customer;



