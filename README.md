
# Analysis with SQL

## General description

This repository contains examples of SQL commands for work different concepts about data analysis and explore diverse kind of queries. 

## Database schema

![chinook database schema](chinook.jpg)

## Directory structure 

- Directory *chinook* has all the files related with the database. 
  - A SQL schema for load and create the chinook database structure into SQLIte
  - The database used ready for load into SQLite

- Directory *queries* has all the queries tested in the chinook database. 
  -  *SQL_1_basics.sql*: File contains basic queries about FROM, SELECT.
  -  *SQL_2_operations.sql*: File contains quieries about logic operators and filtering clauses.  
  - *SQL_3_string_date.sql*: Queries are about date type or strings.
  - *SQL_4_A_subqueries.sql*:  Queries oriented to work with subqueries in the body of the SELECT.
  - *SQL_4_B_joins*: Queries that test different kind of joins (LEFT, RIGHT, etc.).
  - *SQL_4_C_advanced*: Queries more complex to integrate different concepts about SQL commands.

</br>

Here is the schema of the database used for all the queries.




- Directory dh has an implementation of datawarehouse only for study purposes.



1. SQL Cleaning
2. Basic SQL queries
3. Joins
4. Advanced joins

Also the directory has two files: northwind


Steps to upload the database:


1. Open Terminal.
2. Enter PostgreSQL console - `psql` 
3. Create a new database - `CREATE DATABASE parch_and_posey;`
4. Restore into the database - `pg_restore -d parch_and_posey /path/to/parch_and_posey_db`
