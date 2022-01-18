use dml;

select * from Trainees28;

Grant select on Trainees28 to g2;

--Deadlock Example
-- Create table TableA
CREATE TABLE TableA
(
    ID INT,
    Name NVARCHAR(50)
)
Go
-- Insert some test data
INSERT INTO TableA values (101, 'Anurag')
INSERT INTO TableA values (102, 'Mohanty')
INSERT INTO TableA values (103, 'Pranaya')
INSERT INTO TableA values (104, 'Rout')
INSERT INTO TableA values (105, 'Sambit')
Go
-- Create table TableB
CREATE TABLE TableB
(
    ID INT,
    Name NVARCHAR(50)
)
Go
-- Insert some test data
INSERT INTO TableB values (1001, 'Priyanka')
INSERT INTO TableB values (1002, 'Dewagan')
INSERT INTO TableB values (1003, 'Preety')

Grant select,update,delete,alter on TableA to g2;

Grant select,update,delete,alter on TableB to g2;

select * from TableA;
select * from TableB;
--Example 1
-- Transaction 1
BEGIN TRANSACTION
UPDATE TableA SET Name = 'Anurag From Transaction1' WHERE Id = 101
WAITFOR DELAY '00:00:15'
UPDATE TableB SET Name = 'Priyanka From Transaction1' WHERE Id = 1001
COMMIT TRANSACTION

-- Transaction 2
--Execute in g2 user in another sql window
BEGIN TRANSACTION
UPDATE TableB SET Name = 'Priyanka From Transaction2' WHERE Id = 1001
WAITFOR DELAY '00:00:15'
UPDATE TableA SET Name = 'Anurag From Transaction2' WHERE Id = 101
Commit Transaction

Truncate table TableB
Truncate table TableA
INSERT INTO TableA values (101, 'Anurag')
INSERT INTO TableA values (102, 'Mohanty')
INSERT INTO TableA values (103, 'Pranaya')
INSERT INTO TableA values (104, 'Rout')
INSERT INTO TableA values (105, 'Sambit')
INSERT INTO TableB values (1001, 'Priyanka')
INSERT INTO TableB values (1002, 'Dewagan')
INSERT INTO TableB values (1003, 'Preety')

--Example 2 with Priority level
-- Transaction 1
BEGIN TRANSACTION
UPDATE TableA SET Name = 'Anurag From Transaction1' WHERE Id = 101
WAITFOR DELAY '00:00:15'
UPDATE TableB SET Name = 'Priyanka From Transaction1' WHERE Id = 1001
COMMIT TRANSACTION

-- Transaction 2
--Execute in g2 user in another sql window
SET DEADLOCK_PRIORITY HIGH
GO
BEGIN TRANSACTION
UPDATE TableB SET Name = 'Priyanka From Transaction2' WHERE Id = 1001
WAITFOR DELAY '00:00:15'
UPDATE TableA SET Name = 'Anurag From Transaction2' WHERE Id = 101
Commit Transaction

--Enable Trace Flag in SQL Server: 
--To enable the trace flag in SQL Server we need to use the DBCC command. The -1 parameter indicates that the trace flag must be set at the global level. If we omit the -1 parameter then the trace flag will be set only at the session-level. 

--To enable the trace flag
DBCC Traceon(1222, -1) 

--To check the status of the trace flag
DBCC TraceStatus(1222, -1) 

--To disable the trace flag
DBCC Traceoff(1222, -1)

--The information about this deadlock now should have been logged in SQL Server Error Log. To read the error log you need to use the sp_readerrorlog system stored procedure as shown below.
EXECUTE sp_readerrorlog 