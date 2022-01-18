--SQL Server OFFSET FETCH

--The OFFSET and FETCH clauses are the options of the ORDER BY clause. They allow you to limit the number of rows to be returned by a query.

--The following illustrates the syntax of the OFFSET and FETCH clauses:

/*
ORDER BY column_list [ASC |DESC]
OFFSET offset_row_count {ROW | ROWS}
FETCH {FIRST | NEXT} fetch_row_count {ROW | ROWS} ONLY
*/

use dml;

select * from Trainees28 order by empid;

--To skip the first 5 empid and return the rest, you use the OFFSET clause

select * from Trainees28 order by empid offset 5 rows;

--To skip the first 5 empid and select the next 10 empid, you use both OFFSET and FETCH clauses

select * from Trainees28 order by empid offset 5 rows FETCH NEXT 10 ROWS ONLY; 

--To get the top 10 scores you use both OFFSET and FETCH clauses

select * from Trainees28 order by score desc offset 0 rows FETCH NEXT 10 ROWS ONLY; 


--Work out
--https://www.sqlservertutorial.net/sql-server-basics/sql-server-computed-columns/
--https://www.sqlservertutorial.net/sql-server-basics/sql-server-cross-join/
--https://www.sqlservertutorial.net/sql-server-basics/sql-server-self-join/