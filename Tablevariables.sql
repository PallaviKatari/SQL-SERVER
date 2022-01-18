use dml;

--Table variable is a type of local variable that used to store data temporarily, similar to the temp table in SQL Server. 
--Tempdb database is used to store table variables.

--Table variables are kinds of variables that allow you to hold rows of data, 
--which are similar to temporary tables.

/*The scope of table variables
Similar to local variables, table variables are out of scope at the end of the batch.
If you define a table variable in a stored procedure or user-defined function, 
the table variable will no longer exist after the stored procedure or user-defined function exits.*/

--To declare a table variable, you use the DECLARE statement as follows:
--Note that you need to execute the whole batch or you will get an error:
DECLARE @marklist TABLE (
	empid INT NOT NULL,
    empname VARCHAR(25) NOT NULL,
    score int NOT NULL
);
INSERT INTO @marklist
select empid,empname,score from trainees28;
select * from @marklist;

/*you have to define the structure of the table variable during the declaration. 
Unlike a regular or temporary table, 
you cannot alter the structure of the table variables after they are declared.*/

/*Performance of table variables

Using table variables in a stored procedure results in fewer recompilations than using a temporary table.
In addition, a table variable use fewer resources than a temporary table with less locking and logging overhead.
Similar to the temporary table, the table variables do live in the tempdb database, not in the memory.*/

DECLARE @WeekDays TABLE (Number INT, Day VARCHAR(40), Name VARCHAR(40));
INSERT INTO @WeekDays
VALUES
(1, 'Mon', 'Monday'),
(2, 'Tue', 'Tuesday'),
(3, 'Wed', 'Wednesday'),
(4, 'Thu', 'Thursday'),
(5, 'Fri', 'Friday'),
(6, 'Sat', 'Saturday'),
(7, 'Sun', 'Sunday');
SELECT * FROM @WeekDays;

DELETE @WeekDays WHERE Number=7;

UPDATE @WeekDays SET Name='Saturday is a holiday' WHERE Number=6 ;
SELECT * FROM @WeekDays;
