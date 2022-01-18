use dml;

--The CAST() function converts a value (of any type) into a specified datatype.
SELECT CAST(25.65 AS int);

SELECT CAST(25.65 AS varchar);

SELECT CAST('2017-08-25' AS datetime);


--The CONVERT() function converts a value (of any type) into a specified datatype
SELECT CONVERT(int, 25.65);

SELECT CONVERT(varchar, 25.65);

SELECT CONVERT(datetime, '2017-08-25');

SELECT CONVERT(varchar, '2017-08-25');

--The COALESCE() function returns the first non-null value in a list.
SELECT COALESCE(NULL, NULL, NULL, 'Hello', NULL, 'Trainees');
SELECT COALESCE(NULL, 1, 2, 'Welcome');

--The CURRENT_USER function returns the name of the current user in the SQL Server database.
SELECT CURRENT_USER;

--The IIF() function returns a value if a condition is TRUE, or another value if a condition is FALSE.
SELECT IIF(500<1000, 'YES', 'NO');
SELECT IIF(500>1000, 5, 10);

SELECT empid,empname,score, IIF(score>97, 'Excellent', 'Good') as Remarks
FROM Trainees28;

use dml;





