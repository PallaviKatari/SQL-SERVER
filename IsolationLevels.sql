use g2;
--The default Transaction Isolation level in SQL Server is Read committed

-- Create Products table
CREATE TABLE Productslock
(
    Id INT PRIMARY KEY,
    Name VARCHAR(100),
    Quantity INT
)
Go
-- Insert test data into Products table
INSERT INTO Productslock values (1001, 'Mobile', 10)
INSERT INTO Productslock values (1002, 'Tablet', 20)
INSERT INTO Productslock values (1003, 'Laptop', 30)

Grant select,insert,update,delete on Productslock to g2;
Revoke select on Productslock to g2;

--1) Dirty Read Concurrency Problem Example in SQL Server: 
--Transaction 1
BEGIN TRANSACTION
  UPDATE Productslock SET Quantity = 50 WHERE Id=1001
  -- Billing the customer
  Waitfor Delay '00:00:5'
  -- Insufficient Funds. Rollback transaction
Rollback TRANSACTION
  
 SELECT * FROM Productslock WHERE Id=1001

--Transaction 2 in another sql user instance
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED --READ COMMITTED TO AVOID DIRTY READ ORSELECT * FROM Productslock (NOLOCK) WHERE Id=1001
SELECT * FROM Productslock WHERE Id=1001

--First, run transaction 1 and then immediately run the Transaction2 and you will see that the Transaction returns the Quantity as 5. 
--Then Transaction 1 is rollback and it will update the quantity to its previous state i.e. 10. 
--But Transaction 2 working with the value 5 which does not exist in the database anymore and this is nothing but dirty data.

--2) Lost Update Concurrency Problem in SQL Server 

-- Transaction 1
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
GO
BEGIN TRANSACTION
  DECLARE @QunatityAvailable int
  SELECT @QunatityAvailable = Quantity FROM Productslock WHERE Id=1001
  -- Transaction takes 10 seconds
  WAITFOR DELAY '00:00:5'
  SET @QunatityAvailable = @QunatityAvailable + 1
  UPDATE Productslock SET Quantity = @QunatityAvailable  WHERE Id=1001
  Print @QunatityAvailable
COMMIT TRANSACTION

-- Transaction 2 another user instance
BEGIN TRANSACTION
  DECLARE @QunatityAvailable int
  SELECT @QunatityAvailable = Quantity FROM Productslock WHERE Id=1001
  SET @QunatityAvailable = @QunatityAvailable - 2
  UPDATE Productslock SET Quantity = @QunatityAvailable WHERE Id=1001
  Print @QunatityAvailable
COMMIT TRANSACTION

--How to Overcome the Lost Update Concurrency Problem?
--SET TRANSACTION ISOLATION LEVEL REPEATABLE READ in both the transactions

--Now run Transaction1 first and then run the second transaction and you will see that Transaction 1 was completed successfully while Transaction 2 competed with the error.
-- The transaction was deadlocked on lock resources with another process and has been chosen as the deadlock victim. Rerun the transaction. 

--Once you rerun Transaction 2, the Quantity will be updated correctly as expected in the database table. 

--3) Non-Repeatable Read Concurrency Problem

-- Transaction 1
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION
SELECT Quantity FROM Productslock WHERE Id = 1001
-- Do Some work
WAITFOR DELAY '00:00:5'
SELECT Quantity FROM Productslock WHERE Id = 1001
COMMIT TRANSACTION

-- Transaction 2 in another user instance
SET TRANSACTION ISOLATION LEVEL READ COMMITTED --SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
UPDATE Productslock SET Quantity = 5 WHERE Id = 1001

--Notice that when Transaction 1 is completed, it gets a different value for reading 1 and reading 2, resulting in a non-repeatable read concurrency problem. 
--In order to solve the Non-Repeatable Read Problem in SQL Server, we need to use either Repeatable Read Transaction Isolation Level or any other higher isolation level such as Snapshot or Serializable. 

--4) Phantom Read Concurrency Problem in SQL Server: 

-- Create Employee table
CREATE TABLE Employeeslock
(
    Id INT PRIMARY KEY,
    Name VARCHAR(100),
    Gender VARCHAR(10)
)
Go
-- Insert some dummy data
INSERT INTO  Employeeslock VALUES(1001,'Anurag', 'Male')
INSERT INTO  Employeeslock VALUES(1002,'Priyanka', 'Female')
INSERT INTO  Employeeslock VALUES(1003,'Pranaya', 'Male')
INSERT INTO  Employeeslock VALUES(1004,'Hina', 'Female')

Grant select,insert,update,delete on Employeeslock to g2;

-- Transaction 1
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
--SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRANSACTION
SELECT * FROM Employeeslock where Gender = 'Male'
-- Do Some work
WAITFOR DELAY '00:00:5'
SELECT * FROM Employeeslock where Gender = 'Male'
-- Do Some work
WAITFOR DELAY '00:00:5'
SELECT * FROM Employeeslock where Gender = 'Male'
COMMIT TRANSACTION

-- Transaction 2 in another user instance
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION
INSERT into Employeeslock VALUES(1005, 'Sambit', 'Male')
COMMIT TRANSACTION

/* From the first instance execute the Transaction 1 code and from the second instance execute the Transaction 2 code. 
Notice that when Transaction 1 is completed, it gets a different number of rows for reading 1 and reading 2, resulting in a phantom read problem. 
The Read Committed, Read Uncommitted, and Repeatable Read Transaction Isolation Level causes Phantom Read Concurrency Problem in SQL Server. 
In the above Transactions, we used REPEATABLE READ Transaction Isolation Level, even you can also use Read Committed and Read Uncommitted Transaction Isolation Levels.*/

/*to fix the Phantom Read Concurrency Problem let set the transaction isolation level of Transaction 1 to serializable.
 The Serializable Transaction Isolation Level places a range lock on the rows returns by the transaction based on the condition.
 In our example, it will place a lock where Gender is Male, which prevents any other transaction from inserting new rows within that Gender. 
 This solves the phantom read problem in SQL Server. */

 