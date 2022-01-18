/*The Common Table Expressions (CTE) were introduced into standard SQL in order to simplify various classes of SQL Queries for which a derived table was just unsuitable. 
CTE was introduced in SQL Server 2005, the common table expression (CTE) is a temporary named result set that you can reference within a SELECT, INSERT, UPDATE, or DELETE statement. 
You can also use a CTE in a CREATE a view, as part of the view’s SELECT query. In addition, as of SQL Server 2008, you can add a CTE to the new MERGE statement.

Using the CTE –
We can define CTEs by adding a WITH clause directly before SELECT, INSERT, UPDATE, DELETE, or MERGE statement. 
The WITH clause can include one or more CTEs seperated by commas. */

/*SYNTAX
[WITH  [, ...]]  
 
::=
cte_name [(column_name [, ...])]
AS (cte_query) 

SYNTAX

WITH cte_name (column_names)   
AS (query)     
SELECT * FROM cte_name;   
*/

use dml;

WITH customers_in_NewYork --cte result set  
AS (SELECT * FROM onlinecustomers WHERE customercity = 'New York')  
SELECT customerid,customername,customercity FROM customers_in_NewYork;  

--Multiple CTE
WITH customers_in_NewYork  --first cte
AS (SELECT * FROM onlinecustomers WHERE customercity = 'New York') , 

customers_in_Chicago --second
AS (SELECT * FROM onlinecustomers WHERE customercity = 'Chicago')  

SELECT * FROM customers_in_NewYork
UNION ALL  
SELECT * FROM customers_in_Chicago; 

--Example
CREATE TABLE CTEtable
(
  EmployeeID int NOT NULL PRIMARY KEY,
  FirstName varchar(50) NOT NULL,
  LastName varchar(50) NOT NULL,
  ManagerID int NULL
)

INSERT INTO CTEtable VALUES (1, 'Ken', 'Thompson', NULL)
INSERT INTO CTEtable VALUES (2, 'Terri', 'Ryan', 1)
INSERT INTO CTEtable VALUES (3, 'Robert', 'Durello', 1)
INSERT INTO CTEtable VALUES (4, 'Rob', 'Bailey', 2)
INSERT INTO CTEtable VALUES (5, 'Kent', 'Erickson', 2)
INSERT INTO CTEtable VALUES (6, 'Bill', 'Goldberg', 3)
INSERT INTO CTEtable VALUES (7, 'Ryan', 'Miller', 3)
INSERT INTO CTEtable VALUES (8, 'Dane', 'Mark', 5)
INSERT INTO CTEtable VALUES (9, 'Charles', 'Matthew', 6)
INSERT INTO CTEtable VALUES (10, 'Michael', 'Jhonson', 6) 

select * from CTEtable;

WITH
  cteReports (EmpID, FirstName, LastName, MgrID, EmpLevel)
  AS
  (
    SELECT EmployeeID, FirstName, LastName, ManagerID, 1
    FROM CTEtable
    WHERE ManagerID IS NULL
    UNION ALL
    SELECT e.EmployeeID, e.FirstName, e.LastName, e.ManagerID, 
      r.EmpLevel + 1
    FROM CTEtable e
      INNER JOIN cteReports r
        ON e.ManagerID = r.EmpID
  )
SELECT
  FirstName + ' ' + LastName AS FullName, 
  EmpLevel,
  (SELECT FirstName + ' ' + LastName FROM CTEtable 
    WHERE EmployeeID = cteReports.MgrID) AS Manager
FROM cteReports 
ORDER BY EmpLevel, MgrID 

/*Why do we need CTE?
Like database views and derived tables, CTEs can make it easier to write and manage complex queries by making them more readable and simple. 
We can accomplish this characteristic by breaking down the complex queries into simple blocks that can reuse in rewriting the query.

Some of its use cases are given below:

It is useful when we need to define a derived table multiple times within a single query.
It is useful when we need to create an alternative to a view in the database.
It is useful when we need to perform the same calculation multiple times on multiple query components simultaneously.
It is useful when we need to use ranking functions like ROW_NUMBER(), RANK(), and NTILE().
Some of its advantages are given below:

CTE facilitates code maintenance easier.
CTE increases the readability of the code.
It increases the performance of the query.
CTE makes it possible to implement recursive queries easily.

Types of CTE in SQL Server
SQL Server divides the CTE (Common Table Expressions) into two broad categories:

Recursive CTE- query that calls itself
Non-Recursive CTE-doesn't reference itself*/

/*The following are the limitations of using CTE in SQL Server:

CTE members are unable to use the keyword clauses like Distinct, Group By, Having, Top, Joins, etc.
The CTE can only be referenced once by the Recursive member.
We cannot use the table variables and CTEs as parameters in stored procedures.
We already know that the CTE could be used in place of a view, but a CTE cannot be nested, while Views can.
Since it's just a shortcut for a query or subquery, it can't be reused in another query.
The number of columns in the CTE arguments and the number of columns in the query must be the same.*/

