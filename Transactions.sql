/*A transaction in SQL Server is a sequential group of statements or queries to perform single or multiple tasks in a database. 
Each transaction may have single read, write, update, or delete operations or a combination of all these operations. 
Each transaction must happen two things in SQL Server:

Either all modification is successful when the transaction is committed.
Or, all modifications are undone when the transaction is rollback.
A transaction cannot be successful until all of the operations in the set are completed. It means that if any argument fails, the transaction operation will fail.
Each transaction begins with the first executable SQL statement and ends when it finds a commit or rollback, either explicitly or implicitly. 
It uses the COMMIT or ROLLBACK statements explicitly, as well as implicitly when a DDL statement is used.*/

--Transaction Properties-ACID Properties
/*Atomicity: This property ensures that all statements or operations included in the transaction must be performed successfully. 
Otherwise, the whole transaction will be aborted, and all operations are rolled back into their previous state when any operation is failed.

Consistency: This property ensures that the database changes state only when a transaction will be committed successfully. 
It is also responsible for protecting data from crashes.

Isolation: This property guarantees that all transactions are isolated from other transactions, meaning each operation in the transaction is operated independently. 
It also ensures that statements are transparent to each other.

Durability: This property guarantees that the result of committed transactions persists in the database permanently even if the system crashes or failed.*/

/*Transaction Modes in SQL Server
There are three different transaction modes that SQL Server can use:
Auto-commit Transaction Mode: It is the SQL Server's default transaction mode. 
It will evaluate each SQL statement as a transaction, and the results are committed or rolled back accordingly. 
Thus the successful statements are immediately committed, while the failed statements are immediately rolled back.

Implicit Transaction Mode. This mode allows SQL Server to begin the implicit transaction for each DML statement, 
but it explicitly requires the use of commit or rollback commands at the end of the statements.

Explicit Transaction Mode: This mode is defined by the user that allows us to identify a transaction's beginning and ending points exactly. 
It will automatically abort in case of a fatal error.

Transaction Control
The following are the commands used to control transactions:

BEGIN TRANSACTION: It is a command that indicates the beginning of each transaction.
COMMIT: It is a command used to save the changes permanently in the database.
ROLLBACK: It is a command used to cancel all modifications and goes into their previous state.
SAVEPOINT: This command creates points within groups of transactions that allow us to roll back only a portion of a transaction rather than the entire transaction.
RELEASE SAVEPOINT: It is used to remove an already existing SAVEPOINT.
SET TRANSACTION: This command gives a transaction a name, which can be used to make it read-only or read/write or assign it to a specific rollback segment.*/

--Example of COMMIT Transaction

use dml;
select * from Trainees28;
-- Start a new transaction    
BEGIN TRANSACTION  
-- SQL Statements  
 INSERT INTO Trainees28 VALUES(20, 'Rena', 'HR', 98)  ;
 UPDATE Trainees28 SET score = 100 WHERE empid=17; 
 -- Commit changes   
COMMIT TRANSACTION  --The INSERT and UPDATE statements cannot be rolled back after the transaction has been committed.

--Example of ROLLBACK Transaction

select * from Trainees28;
-- Start a new transaction    
BEGIN TRANSACTION  
-- SQL Statements  
 INSERT INTO Trainees28 VALUES(21, 'Parvathi', 'Tester', 98)  ;
 UPDATE Trainees28 SET score = 99 WHERE empid=18; 
--Undo Changes    
ROLLBACK TRANSACTION  

--Use of @@Error Global variable in transactions:
--This variable is used to check whether there is an error or not. 

BEGIN TRANSACTION  
INSERT INTO Trainees28 VALUES(21, 'Lucky B', 'HR', 98)  ;
-- Check for error  
IF(@@ERROR > 0)  
BEGIN  
    ROLLBACK TRANSACTION  
END  
ELSE  
BEGIN  
   COMMIT TRANSACTION  
END 

--Auto Rollback Transaction

BEGIN TRANSACTION 
  set nocount on; 
  INSERT INTO Trainees28 VALUES(18, 'Paru', 'Tester', 98)  ;  
  SELECT * FROM Trainees28
COMMIT TRANSACTION   

--Savepoint in Transactions
BEGIN TRANSACTION   
-- SQL Statements  
 INSERT INTO Trainees28 VALUES(22, 'Sithara', 'HR', 99)  ;
SAVE TRANSACTION InsertStatement  --savepoint is only applied to insert statement

UPDATE Trainees28 SET score = 100 WHERE empid=19;  --in the second output, the updation operation is rolled back because of the savepoint.
SELECT * FROM Trainees28 
 
ROLLBACK TRANSACTION InsertStatement  
COMMIT  
SELECT * FROM Trainees28  

--delete from trainees28 where empid=19

--Implicit Transaction in SQL Server
SET IMPLICIT_TRANSACTIONS ON   
UPDATE Trainees28 SET score = 100 WHERE empid=19;   
SELECT   
    IIF(@@OPTIONS & 2 = 2,   
    'Implicit Transaction Mode ON',   
    'Implicit Transaction Mode OFF'  
    ) AS 'Transaction Mode'   
SELECT @@TRANCOUNT AS OpenTrans   
COMMIT TRANSACTION  
SELECT @@TRANCOUNT AS OpenTrans  

--In this transaction, we have used two options @@OPTION and @@TRANCOUNT. 
--The @@OPTOPN provides the information regarding current SET options,
--and @@TRANCOUNT provides the BEGIN TRANSACTION statement in the current session.
SET IMPLICIT_TRANSACTIONS ON
UPDATE Trainees28 SET score = 100 WHERE empid=19; 
select * from Trainees28;
COMMIT TRAN
SET IMPLICIT_TRANSACTIONS OFF
--SELECT @@OPTIONS
DECLARE @options INT SELECT @options = @@OPTIONS 
PRINT @options
IF ( (1 & @options) = 1 ) PRINT 'DISABLE_DEF_CNST_CHK' 
IF ( (2 & @options) = 2 ) PRINT 'IMPLICIT_TRANSACTIONS' 
IF ( (4 & @options) = 4 ) PRINT 'CURSOR_CLOSE_ON_COMMIT' 
IF ( (8 & @options) = 8 ) PRINT 'ANSI_WARNINGS' 
IF ( (16 & @options) = 16 ) PRINT 'ANSI_PADDING' 
IF ( (32 & @options) = 32 ) PRINT 'ANSI_NULLS' 
IF ( (64 & @options) = 64 ) PRINT 'ARITHABORT' 
IF ( (128 & @options) = 128 ) PRINT 'ARITHIGNORE'
IF ( (256 & @options) = 256 ) PRINT 'QUOTED_IDENTIFIER' 
IF ( (512 & @options) = 512 ) PRINT 'NOCOUNT' 
IF ( (1024 & @options) = 1024 ) PRINT 'ANSI_NULL_DFLT_ON' 
IF ( (2048 & @options) = 2048 ) PRINT 'ANSI_NULL_DFLT_OFF' 
IF ( (4096 & @options) = 4096 ) PRINT 'CONCAT_NULL_YIELDS_NULL' 
IF ( (8192 & @options) = 8192 ) PRINT 'NUMERIC_ROUNDABORT' 
IF ( (16384 & @options) = 16384 ) PRINT 'XACT_ABORT' 

--Explicit Transaction in SQL Server
BEGIN TRANSACTION  
UPDATE Trainees28 SET score = 100 WHERE empid=19; 
SELECT @@TRANCOUNT AS OpenTrans   
COMMIT TRANSACTION  
SELECT @@TRANCOUNT AS OpenTrans 
--The explicit transaction through the BEGIN TRANSACTION command acquired a 
--lock depending on the isolation level of the transaction-related resources. 
--It helps to reduce lock issues. 

--Marked Transaction in SQL Server

BEGIN TRANSACTION updatetrainee WITH MARK 'score updation'  --mark is the transaction description 
    UPDATE Trainees28 SET score = 98 WHERE empid=19;
	SELECT @@TRANCOUNT AS OpenTrans 
COMMIT TRANSACTION updatetrans 
SELECT @@TRANCOUNT AS OpenTrans 
select * from Trainees28;

/*The marked transaction is used to add a description to a specific transaction in the log files. 
We can use it as a recovery point in place of a date and time when restoring a database to a previous state.
We must know that the mark is added in the log files only when the marked transaction modifies the database. 
We can understand its concept using the following example.
Suppose we have modified the database accidently, and we don't know the exact moment of the data alteration; 
in that case, data recovery can take a long time. However, if we use the marked transactions, 
it can be a useful tool for determining the exact timing of data alterations.*/

/*The logmarkhistory table is included in the msdb database and 
stores information regarding each marked transaction that has been committed.*/

SELECT * FROM msdb.dbo.logmarkhistory;  
SELECT * FROM fn_dblog(NULL,NULL)

--Named Transaction in SQL Server
BEGIN TRANSACTION updatescore  
UPDATE Trainees28 SET score = 98 WHERE empid=19; 
COMMIT TRANSACTION updatescore  

--Active transactions
SELECT * FROM sys.sysprocesses WHERE open_tran = 1
DBCC OPENTRAN --only shows open transactions for specific database for which it is executed.
DBCC INPUTBUFFER(54) --use DBCC INPUTBUFFER(SPID) to get the query information

/*
Steps to Use Log File Viewer in SQL Server Management Studio

Download and Open the SQL Server Management Studio on your PC.
Now the Connect to Server Windows will appear in front of you.
Enter the Name of the Server and the type of authentication and then click on connect.
Now, the Object Explorer opens. Click on the Management.
Then go to the SQL Server Logs option.
Make a Right-Click on SQL Server Logs and point the cursor on View and then on SQL Server Log.
Now you can see all the contents of the SQL Log File in front of you.*/