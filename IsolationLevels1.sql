use g2
--5) Snapshot Isolation Level in SQL Server:
 --Types of Snapshot Isolation Level in SQL Server:

 --5.1)ALLOW_SNAPSHOT_ISOLATION:

ALTER DATABASE g2
SET ALLOW_SNAPSHOT_ISOLATION ON
-- Set the transaction isolation level to snapshot
SET TRANSACTION ISOLATION LEVEL SNAPSHOT
SELECT * FROM Productslock WHERE Id = 1001

--Difference between Snapshot Isolation and Read Committed Snapshot
--https://dotnettutorials.net/lesson/difference-between-snapshot-isolation-and-read-committed-snapshot/

--Example 1
ALTER DATABASE g2
SET ALLOW_SNAPSHOT_ISOLATION ON
GO
SELECT * FROM Productslock WHERE Id = 1001 
GO
-- Session 1
SET TRANSACTION ISOLATION LEVEL SNAPSHOT
BEGIN TRAN
 UPDATE Productslock SET Quantity = 15 WHERE Id = 1001
GO
-- Session 2
SET TRANSACTION ISOLATION LEVEL SNAPSHOT
BEGIN TRAN
SELECT * FROM Productslock WHERE Id = 1001 
GO
-- Session 1
COMMIT
-- Session 2
SELECT * FROM Productslock WHERE Id = 1001 
GO
-- Session 2
COMMIT
SELECT * FROM Productslock WHERE Id = 1001 
GO

--Example 2
/*
Snapshot isolation is similar to Serializable isolation. 
The difference is Snapshot does not hold lock on table during the 
transaction so table can be modified in other sessions. 
Snapshot isolation maintains versioning in Tempdb for old data in 
case of any data modification occurs in other sessions then existing 
transaction displays the old data from Tempdb.*/

--session 1
  set transaction isolation level snapshot
    begin tran
    select * from Productslock
    waitfor delay '00:00:5'
    select * from Productslock
    rollback

--session 2
	insert into Productslock values( 3,'Desktop',110)
     UPDATE Productslock SET Quantity = 50 WHERE Id = 1001
    select * from Productslock

	--Session 2 queries will be executed in parallel as transaction in session 1 won't lock the table Productslock.

--refer
--https://blog.sqlauthority.com/2010/05/21/sql-server-simple-example-of-snapshot-isolation-reduce%C2%A0the%C2%A0blocking%C2%A0transactions/
--http://www.besttechtools.com/articles/article/sql-server-isolation-levels-by-example

--Difference between Snapshot Isolation and Read Committed Snapshot

--Example 1
ALTER DATABASE g2
SET ALLOW_SNAPSHOT_ISOLATION on
GO

SELECT * FROM Productslock
--Update Conflicts: 
/*
Once you enabled the Snapshot Isolation Level, then Open 2 instances of SQL Server Management Studio. 
From the first instance execute the Transaction 1 code and from the second instance execute the Transaction 2 code and you will notice 
that the Transaction 2 is blocked until the Transaction 1 is completed its execution. 
And when Transaction 1 completes its execution, then the Transaction 2 raises an update conflict which will terminate the transaction and 
rolls back with the following error as shown in the transaction 2. */
--Transaction 1
SET TRANSACTION ISOLATION LEVEL SNAPSHOT
BEGIN TRANSACTION
  UPDATE Productslock SET Quantity = 5 WHERE Id = 1001
  WAITFOR DELAY '00:00:15'
COMMIT TRANSACTION
--Transaction 2
SET TRANSACTION ISOLATION LEVEL SNAPSHOT
BEGIN TRANSACTION
  UPDATE Productslock SET Quantity = 8 WHERE Id = 1001
COMMIT TRANSACTION

--Example 2
-- 5.2)READ_COMMITTED_SNAPSHOT
ALTER DATABASE g2 SET READ_COMMITTED_SNAPSHOT ON
--refer
--https://dotnettutorials.net/lesson/difference-between-snapshot-isolation-and-read-committed-snapshot/

--Example 3
ALTER DATABASE g2
SET ALLOW_SNAPSHOT_ISOLATION off
GO

--Transaction 1
-- Step1 Start
SELECT Quantity FROM Productslock WHERE Id = 1001
-- Result : 10 
-- Step1 End
-- Step3 Start
SET TRANSACTION ISOLATION LEVEL SNAPSHOT
BEGIN TRANSACTION
UPDATE Productslock SET Quantity = 150 WHERE Id = 1001
SELECT Quantity FROM Productslock WHERE Id = 1001
-- Result : 5
-- Step3 End
-- Step 5 Start
 WAITFOR DELAY '00:00:15'
COMMIT TRANSACTION
-- Step 5 End
-- Step7 Start
SELECT Quantity FROM Productslock WHERE Id = 1001 
-- Result : 5
-- Step7 End

--Transaction2
-- Step2 Start
SELECT Quantity FROM Productslock WHERE Id = 1001
-- Result : 10 
-- Step2 End
-- Step4 Start
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION 
SELECT Quantity FROM Productslock WHERE Id = 1001
-- Result : 10
-- Step4 End
-- Step6 Start
SELECT Quantity FROM Productslock WHERE Id = 1001
-- Result : 5
COMMIT TRANSACTION
-- Step6 End
-- Step8 Start
SELECT Quantity FROM Productslock WHERE Id = 1001 
-- Result : 5
-- Step8 End

--Example 4

--Transaction 1
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION
  UPDATE Productslock SET Quantity = 15 WHERE Id = 1001
  WAITFOR DELAY '00:00:15'
COMMIT TRANSACTION
--Transaction 2
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION
  SELECT * FROM Productslock WHERE Id = 1001 
COMMIT TRANSACTION

--Change Transaction 2 to SET TRANSACTION ISOLATION LEVEL SNAPSHOT(the transaction wont be blocked)

