use dml;
--https://www.sqlservertutorial.net/sql-server-system-functions/
--https://www.sqlservertutorial.net/sql-server-window-functions/

--The FIRST_VALUE() function is a window function that returns the first value in an ordered partition of a result set.

SELECT 
    empid,empname,designation,score,
    FIRST_VALUE(designation) OVER(ORDER BY score) firstvalue
FROM 
    Trainees28;

SELECT 
    empid,empname,designation,score,
    FIRST_VALUE(empname) OVER(partition by designation ORDER BY score) firstvalue
FROM 
    Trainees28;


--The LAST_VALUE() function is a window function that returns the last value in an ordered partition of a result set.

SELECT 
    empid,empname,designation,score,
    LAST_VALUE(designation) OVER(ORDER BY score) lastvalue
FROM 
    Trainees28;

SELECT 
    empid,empname,designation,score,
    LAST_VALUE(empname) OVER(partition by designation ORDER BY score) lastvalue
FROM 
    Trainees28;

--SQL Server LEAD() is a window function that provides access to a row at a specified physical offset which follows the current row.

SELECT 
    empid,empname,designation,score,
    LEAD(score,1) OVER(ORDER BY score) Lead
FROM 
    Trainees28;

--SQL Server LAG() is a window function that provides access to a row at a specified physical offset which comes before the current row.

SELECT 
    empid,empname,designation,score,
    LAG(score,1) OVER(ORDER BY score) Lag
FROM 
    Trainees28;


--The CUME_DIST() function calculates the cumulative distribution of a value within a group of values. 
--Simply put, it calculates the relative position of a value in a group of values.

SELECT 
    empid,empname,designation,score,
    CUME_DIST() OVER(ORDER BY score) cumulative
FROM 
    Trainees28;--The result of CUME_DIST() is greater than 0 and less than or equal to 1.

--The PERCENT_RANK() function is similar to the CUME_DIST() function. 
--The PERCENT_RANK() function evaluates the relative standing of a value within a partition of a result set.

SELECT 
    empid,empname,designation,score,
    PERCENT_RANK() OVER(ORDER BY score) percent_rank
FROM 
    Trainees28;--The result of PERCENT_RANK() is greater than 0 and less than or equal to 1.

SELECT 
    empid,empname,designation,score,
    format(PERCENT_RANK() OVER(ORDER BY score),'p') percentage
FROM 
    Trainees28;

SELECT 
    empid,empname,designation,score,
    format(PERCENT_RANK() OVER(partition by designation ORDER BY score),'p') percentage
FROM 
    Trainees28;

use [BikeStores];
--Try out
