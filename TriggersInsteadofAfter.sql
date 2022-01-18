use sqltriggers

/*
INSTEAD OF Trigger:

INSTEAD OF trigger causes the INSERT, UPDATE, or, DELETE operation to be cancelled.
Due to this the SQL command submitted to SQL Server is discarded by the INSTEAD OF trigger.
In-fact the code within the INSTEAD OF trigger is executed instead of the submitted SQL command.
The INSTEAD OF trigger might be programmed to repeat the requested operation so that it looks like it could do something else altogether.
When INSTEAD OF triggers fire, SQL Server hasn’t yet made any changes and, consequently, hasn’t logged any changes.
INSTEAD OF trigger also don’t report any error warning because it works although the operation doesn’t go through.
This will be more clearer to you, if you this example:*/

ALTER TRIGGER InsteadOfStud
ON Emp
INSTEAD OF INSERT
AS
SELECT * FROM Emp where gender='female'

INSERT INTO Emp VALUES (8, 'Saroj', 7600, 'Male', 1)

DROP TRIGGER InsteadOfStud

/*
AFTER Trigger:

AFTER triggers are often used for complex data validation.
These triggers can rollback, or undo, the insert, update, or delete if the code inside the trigger doesn’t like the operation.
The code can also do something else or even fail the transaction.
But if the trigger doesn’t explicitly ROLLBACK the transaction, the data modification operation will go as it was originally intended.
AFTER triggers report an error code if an operation is rolled back.
AFTER trigger takes place after the modification but before the implicit commit, so the transaction is still open when the AFTER trigger is fired, that is what the main advantage of using AFTER trigger.
So if we want to redo all the transactions then we can use the ROLLBACK keyword for all the pending transactions.*/

CREATE TRIGGER AfterStud
ON Emp
AFTER INSERT
AS
PRINT 'After Trigger'
RAISERROR('Error',16,1);
ROLLBACK TRAN;

INSERT INTO Emp VALUES (9, 'Saroj', 7600, 'Male', 1)
SELECT count(*) FROM Emp
SELECT GetDate()

DROP TRIGGER AfterStud