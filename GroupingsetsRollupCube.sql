use dml;

/*GROUPING SET is an extension of the GROUP BY clause. 
The GROUP BY statement is GROUPING SET is an extension of the GROUP BY clause. 
The GROUP BY statement is used to summarize the data in conjunction with aggregate functions such as SUM, AVG, COUNT, etc. 
It groups the result set based on the single or multiple columns. 
The GROUPING SET was first introduced with the SQL Server 2008 version.*/

select * from trainees28 where designation='tester';
SELECT designation, SUM(score) AS TotalScore   
FROM Trainees28   
GROUP BY GROUPING SETS  
(  
(designation,score) 
)   
ORDER BY designation,score;  

--FETCH
--The following statement sorts the employees by score, 
--skips the first five employees with the highest score,
--and fetches the next five ones.

select empid,empname,score from  deptdev ORDER BY score desc;
SELECT 
    empid,empname,score
FROM
    deptdev
ORDER BY score desc
OFFSET 0 ROWS
FETCH NEXT 3 ROWS ONLY;

--ANY ALL
SELECT 
    EMPID,EMPNAME,SCORE
FROM
    TRAINEES28
WHERE
    SCORE > any (SELECT 
            avg(SCORE)
        FROM
            TRAINEES28
        GROUP BY DESIGNATION)
ORDER BY EMPID,EMPNAME,SCORE DESC; 

SELECT 
     EMPID,EMPNAME,SCORE,designation
FROM
     TRAINEES28
WHERE
    SCORE >= ANY (SELECT 
            SCORE
        FROM
             TRAINEES28
        WHERE
           DESIGNATION = 'HR')
ORDER BY SCORE;

SELECT 
     EMPID,EMPNAME,SCORE
FROM
     TRAINEES28
WHERE
    SCORE >= ALL (SELECT 
            SCORE
        FROM
             TRAINEES28
        WHERE
           DESIGNATION = 'HR')
ORDER BY SCORE;

--ROLLUP
/*The ROLLUP is an extension of the GROUP BY clause. 
The ROLLUP option allows you to include extra rows that represent the subtotals, 
which are commonly referred to as super-aggregate rows, along with the grand total row. 
By using the ROLLUP option, you can use a single query to generate multiple grouping sets.*/

SELECT 
    DESIGNATION, SUM(SCORE)
FROM
    TRAINEES28
GROUP BY DESIGNATION;

SELECT 
    DESIGNATION, SUM(SCORE)
FROM
    TRAINEES28
GROUP BY ROLLUP (DESIGNATION);

--To make the output more readable, you can use the COALESCE() function to substitute the NULL value by the All warehouses as follows:
SELECT 
	COALESCE(DESIGNATION, 'All designations Total') AS Designation, 
    SUM(SCORE) as TotalScore
FROM
    TRAINEES28
GROUP BY ROLLUP (DESIGNATION);

select * from deptdev;
SELECT
   DESIGNATION,PRJCODE,
   SUM(SCORE) AS TOTALSCORE
FROM
   DEPTDEV
GROUP BY
   rollup(DESIGNATION,PRJCODE) 
ORDER BY
   DESIGNATION,PRJCODE; 

SELECT
   DESIGNATION,
   SUM(SCORE) AS TOTALSCORE
FROM
   DEPTDEV
GROUP BY
   rollup(DESIGNATION) 
ORDER BY
   DESIGNATION; 

--CUBE
--CUBE is an extension of the GROUP BY clause. CUBE allows you to generate subtotals
--the CUBE extension will generate subtotals for all combinations of grouping columns specified in the GROUP BY clause.
SELECT
   COALESCE(DESIGNATION, 'All designations Total') AS Designation,
   SUM(SCORE) AS TOTALSCORE
FROM
   TRAINEES28
GROUP BY
   CUBE(DESIGNATION) 
ORDER BY
   DESIGNATION desc;
 
 SELECT 
	COALESCE(DESIGNATION, 'All designations Total') AS Designation, 
    SUM(SCORE) as TotalScore
FROM
    TRAINEES28
GROUP BY ROLLUP (DESIGNATION); 

SELECT
   DESIGNATION,PRJCODE,
   SUM(SCORE) AS TOTALSCORE
FROM
   DEPTDEV
GROUP BY
   CUBE(DESIGNATION,PRJCODE) 
ORDER BY
   DESIGNATION,PRJCODE;

SELECT
   DESIGNATION,PRJCODE,
   SUM(SCORE) AS TOTALSCORE
FROM
   DEPTDEV
GROUP BY
   rollup(DESIGNATION,PRJCODE) 
ORDER BY
   DESIGNATION,PRJCODE; 
   
  