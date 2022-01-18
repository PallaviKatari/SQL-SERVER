use dml;

/*Temporary tables are tables that exist temporarily on the SQL Server.
SQL Server provided two ways to create temporary tables via SELECT INTO and CREATE TABLE statements.

Create temporary tables using SELECT INTO statement*/

SELECT
   empid,empname,score
INTO #Score98 --- local temporary table
FROM
    Trainees28
WHERE
    score=98;

--Create temporary tables using CREATE TABLE statement

CREATE TABLE #Score97 (
    empid int primary key,
	empname varchar(25),
	score int
	);

	INSERT INTO #Score97
	select empid,empname,score from trainees28 where score=97;

	select * from #score97;

--However, if you open another connection and try the query above query, you will get the an error.
--This is because the temporary tables are only accessible within the session that created them.

/*Global temporary tables
Sometimes, you may want to create a temporary table that is accessible across connections. 
In this case, you can use global temporary tables.*/

use dml;
SELECT
   empid,empname,score
INTO ##Score96 --- global temporary table
FROM
    Trainees28
WHERE
    score=96;

/*Dropping temporary tables
Automatic removal
SQL Server drops a temporary table automatically when you close the connection that created it.

SQL Server drops a global temporary table once the connection that created it closed and the queries against this table from other connections completes.

Manual Deletion
From the connection in which the temporary table created, you can manually remove the temporary table by using the DROP TABLE statement.*/

DROP TABLE ##Score96;


