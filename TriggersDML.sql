create database sqltriggers

use sqltriggers
/*There are two types of triggers. They are as follows:

Instead of Triggers: The Instead Of triggers are going to be executed instead of the corresponding DML operations. 
That means instead of the DML operations such as Insert, Update, and Delete, the Instead Of triggers are going to be executed.

After Triggers: The After Triggers fires in SQL Server execute after the triggering action. 
That means once the DML statement (such as Insert, Update, and Delete) completes its execution, this trigger is going to be fired.

Types of Triggers in SQL Server:
There are four types of triggers available in SQL Server. They are as follows:

DML Triggers – Data Manipulation Language Triggers.
DDL Triggers – Data Definition Language Triggers
CLR triggers – Common Language Runtime Triggers (USING FRONT END PROGRAMMING LANGUAGE LIKE C#)
Logon triggers

What are DML Triggers in SQL Server?

As we know DML Stands for Data Manipulation Language and it provides Insert, Update and Delete statements to 
perform the respective operation on the database tables or view which will modify the data. 
The triggers which are executed automatically in response to DML events 
(such as Insert, Update, and Delete statements) are called DML Triggers.*/

-- Create Employee table
CREATE TABLE Employee
(
  Id int Primary Key,
  Name nvarchar(30),
  Salary int,
  Gender nvarchar(10),
  DepartmentId int
)
GO
-- Insert data into Employee table
INSERT INTO Employee VALUES (1,'Pranaya', 5000, 'Male', 3)
INSERT INTO Employee VALUES (2,'Priyanka', 5400, 'Female', 2)
INSERT INTO Employee VALUES (3,'Anurag', 6500, 'male', 1)
INSERT INTO Employee VALUES (4,'sambit', 4700, 'Male', 2)
INSERT INTO Employee VALUES (5,'Hina', 6600, 'Female', 3)

select * from Employee
--1)For/After Insert DML Trigger in SQL Server

CREATE TRIGGER trInsertEmployee 
ON Employee
FOR INSERT
AS
BEGIN
  PRINT 'YOU CANNOT PERFORM INSERT OPERATION'
  ROLLBACK TRANSACTION
END

--Let’s try to insert the following record into the employee table.
INSERT INTO Employee VALUES (6, 'Saroj', 7600, 'Male', 1)

--When you try to execute the above Insert statement it gives you the below error. First, the INSERT statement is executed, 
--and then immediately this trigger fired and roll back the INSERT operation as well as print the message.

--2)For/After Update DML Trigger in SQL Server

CREATE TRIGGER trUpdateEmployee 
ON Employee
FOR UPDATE
AS
BEGIn
  PRINT 'YOU CANNOT PERFORM UPDATE OPERATION'
  ROLLBACK TRANSACTION
END

--Let’s try to update one record in the Employee table
UPDATE Employee SET Salary = 9000 WHERE Id = 1
select * from Employee
--When you try to execute the above Update statement it will give you the following error. First, the UPDATE statement is executed, 
--and then immediately this trigger fired and roll back the UPDATE operation as well as print the message.

--3)For/After Delete DML Triggers in SQL Server

CREATE TRIGGER trDeleteEmployee 
ON Employee
FOR DELETE
AS
BEGIN
  PRINT 'YOU CANNOT PERFORM DELETE OPERATION'
  ROLLBACK TRANSACTION
END

--Let’s try to delete one record from the Employee table
DELETE FROM Employee WHERE Id = 5
--When we try to execute the above Delete statement, it gives us the below error. First, the DELETE statement is executed, 
--and then immediately this trigger fired and roll back the DELETE operation as well as print the message.

--4)For Insert/Update/Delete DML Trigger in SQL Server

DROP TRIGGER trDeleteEmployee
DROP TRIGGER trInsertEmployee
DROP TRIGGER trUpdateEmployee

CREATE TRIGGER trAllDMLOperationsOnEmployee 
ON Employee
FOR INSERT, UPDATE, DELETE
AS
BEGIN
  PRINT 'YOU CANNOT PERFORM DML OPERATION'
  ROLLBACK TRANSACTION
END

--5) Create a Trigger that will restrict all the DML operations on the Employee table on MONDAY only.

ALTER TRIGGER trAllDMLOperationsOnEmployee 
ON Employee
FOR INSERT, UPDATE, DELETE
AS
BEGIN
  IF DATEPART(DW,GETDATE())= 2
  BEGIN
    PRINT 'DML OPERATIONS ARE RESTRICTED ON MONDAY'
    ROLLBACK TRANSACTION
  END
END

--6) Create a Trigger that will restrict all the DML operations on the Employee table before 1 pm.

ALTER TRIGGER trAllDMLOperationsOnEmployee 
ON Employee
FOR INSERT, UPDATE, DELETE
AS
BEGIN
  IF DATEPART(HH,GETDATE()) > 13
  BEGIN
    PRINT 'INVALID TIME'
    ROLLBACK TRANSACTION
  END 
END

/*
Why do we need DML Triggers in SQL Server?
DML Triggers are used to enforce business rules and data integrity. These triggers are very much similar to constraints in the way they enforce integrity. 
So, with the help of DML Triggers, we can enforce data integrity which cannot be done with the help of constraints that is comparing values with values of another table, etc.*/

--7) Understanding the INSERTED Table in SQL Server:

CREATE TRIGGER trInsertEmployee 
ON Employee
FOR INSERT
AS
BEGIN
  SELECT * FROM INSERTED
END

--Let’s Insert one record into the Employee table
select * from Employee;
INSERT INTO Employee VALUES (8, 'Nancy', 7700, 'Female', 2);

/*So when we execute the above insert statement, the data is inserted as expected in the Employee table 
along with a copy of the inserted new data also available in the Inserted table. So, we get the following output. 
Please note, the structure of the Inserted table is exactly the same as the structure of the Employee table.*/

/*When we add a new row into the Employee table a copy of the row will also be made into the INSERTED table which only a trigger can access.
 We cannot access this table outside the context of the trigger. */

 --8) Deleted Table in SQL Server

 CREATE TRIGGER trDeleteEmployee 
ON Employee
FOR DELETE
AS
BEGIN
  SELECT * FROM DELETED
END

--Let’s Delete one record from the Employee table

DELETE FROM Employee WHERE Id = 8;
select * from Employee;

--When we execute the above Delete statement, the data gets deleted from the Employee
--table whose Id is 6 along with it also displays the following deleted data as part of the deleted table.

--9) How to view the updating data in a table?

-- Create Update Trigger
CREATE TRIGGER trUpdateEmployee 
ON Employee
FOR UPDATE
AS
BEGIN
  SELECT * FROM DELETED
  SELECT * FROM INSERTED
END

--Let’s Update one record in the Employee table by executing the following update statement.
UPDATE Employee SET Name = 'Rocky', Salary = 9000 WHERE Id = 5

--Updating multiple records
UPDATE Employee SET Salary = 20000 WHERE Gender = 'male'