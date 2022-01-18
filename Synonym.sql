

/*What is a synonym in SQL Server

In SQL Server, a synonym is an alias or alternative name for a database object such as a table, view, stored procedure, user-defined function, and sequence.
 
A synonym provides you with many benefits if you use it properly.*/

--1) Creating a synonym within the same database example

use BikeStores;
select * from sales.orders;
select * from orders;
CREATE SYNONYM orders FOR sales.orders;

--Removing a synonym
DROP SYNONYM IF EXISTS orders;

--2)B) Creating a synonym for a table in another database

CREATE DATABASE test;
GO

USE test;
GO

CREATE SCHEMA purchasing;
GO

CREATE TABLE purchasing.suppliers
(
    supplier_id   INT
    PRIMARY KEY IDENTITY, 
    supplier_name NVARCHAR(100) NOT NULL
);

CREATE SYNONYM suppliers 
FOR test.purchasing.suppliers;

SELECT * FROM suppliers;

--Listing all synonyms of a database

--A) Listing synonyms using Transact-SQL command

SELECT 
    name, 
    base_object_name, 
    type
FROM 
    sys.synonyms
ORDER BY 
    name;

--B) Listing synonyms using SQL Server Management Studio

--When to use synonyms
--You will find some situations which you can effectively use synonyms.

--1) Simplify object names
--2) Enable seamless object name changes

/*Benefits of synonyms
Synonym provides the following benefit if you use them properly:

Provide a layer of abstraction over the base objects.
Shorten the lengthy name e.g., a very_long_database_name.with_schema.and_object_name with a simplified alias.
Allow backward compatibility for the existing applications when you rename database objects such as tables, views, stored procedures, user-defined functions, and sequences.*/
