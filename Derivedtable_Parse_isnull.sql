use dml;
/*The SQL PARSE function is a SQL Conversions Function used to convert the String data to the requested data type and returns the result as an expression. 
It is recommended to use this SQL PARSE function to convert the string data to either Date time, or Number type.*/

-- SQL PARSE FUNCTION Example 

DECLARE @str AS VARCHAR(50)
SET @str = '11122'

SELECT PARSE(@str AS INT) AS Result; 

-- Direct Inputs
SELECT PARSE('1234' AS DECIMAL(10, 2)) AS Result; 
 
SELECT PARSE('06/03/2017' AS DATETIME) AS Result;  

SELECT PARSE('06/03/2017' AS DATETIME2) AS Result;

/*The TRY_PARSE() function is used to translate the result of an expression to the requested data type. 
It returns NULL if the cast fails.*/

SELECT 
    TRY_PARSE('14 April 2019' AS date) result;

SELECT 
    TRY_PARSE('-1250' AS INT) result;

SELECT 
    TRY_PARSE('ABC' AS DEC) result;

SELECT 
    CASE
        WHEN TRY_PARSE('Last year' AS DATE) IS NULL
        THEN 'Cast failed'
        ELSE 'Cast succeeded'
    END AS result;

SELECT 
    CASE
        WHEN TRY_PARSE('7 January 2018' AS DATE) IS NULL
        THEN 'Cast failed'
        ELSE 'Cast succeeded'
    END AS result;

	--https://database.guide/parse-vs-cast-vs-convert-in-sql-server-whats-the-difference/


--The ISNULL() function returns a specified value if the expression is NULL.

SELECT ISNULL(NULL, 'Hello'); --null so returns the second value

SELECT ISNULL(NULL, 500);

SELECT ISNULL('Hello', 'Trainees'); --not null so first expression

SELECT ISNULL(score,98) from Trainees28 where empid=7;

--A derived table is a table expression that appears in the FROM clause of a query. 
--You can apply derived tables when the use of column aliases is not possible because another clause is 
--processed by the SQL translator before the alias name is known.

--SQL Server Derived Table Example

--First SELECT * statement is deriving columns from the inner select statement or subquery.
SELECT * FROM
(
	SELECT empid,empname,score
	FROM Trainees28
) AS DerivedTrainees28
WHERE score > 97;

select * from
(
SELECT OC.CUSTOMERID,customerName, customercity, customermail, salestotal,o.orderid
FROM onlinecustomers AS oc
   INNER JOIN
   orders AS o
   ON oc.customerid = o.customerid
   INNER JOIN
   sales AS s
   ON o.orderId = s.orderId 
) as Derivedcustomers --acts as a derived table
where salestotal>500;

select * from 
(
SELECT designation, SUM(score) AS TotalScore   
FROM Trainees28   
GROUP BY designation --having sum(score) >300 
--ORDER BY designation
) as Derivedgroup where Totalscore >300 






