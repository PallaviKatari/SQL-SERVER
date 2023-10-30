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

--Pagination using while loop
DECLARE @PageNumber AS INT
            DECLARE @RowsOfPage AS INT
        DECLARE @MaxTablePage  AS FLOAT 
        SET @PageNumber=1
        SET @RowsOfPage=4
        SELECT @MaxTablePage = COUNT(*) FROM batch35
        SET @MaxTablePage = CEILING(@MaxTablePage/@RowsOfPage)
        WHILE @MaxTablePage >= @PageNumber
        BEGIN
         SELECT * FROM batch35
        ORDER BY empname 
        OFFSET (@PageNumber-1)*@RowsOfPage ROWS
        FETCH NEXT @RowsOfPage ROWS ONLY
        SET @PageNumber = @PageNumber + 1
        END

--Pagination using SP
CREATE PROCEDURE usp_paging1
@Start     INT=0, 
@PageLimit INT=10
AS
BEGIN
SELECT * FROM dbo.batch35
ORDER  BY empname
OFFSET @Start ROW
FETCH NEXT @PageLimit ROWS ONLY
END
select * from batch35
execute usp_paging 2,3

--Work out
--https://www.sqlservertutorial.net/sql-server-basics/sql-server-computed-columns/
--https://www.sqlservertutorial.net/sql-server-basics/sql-server-cross-join/
--https://www.sqlservertutorial.net/sql-server-basics/sql-server-self-join/
