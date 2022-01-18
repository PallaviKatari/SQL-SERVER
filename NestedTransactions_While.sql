use dml;

--SQL While Loop
--Example 1
-- SQL While Loop Example
--Declaring Number and Total Variables
DECLARE @Number INT = 1 ;
DECLARE @Total INT = 0 ;

WHILE @Number < =   10
BEGIN
   SET @Total = @Total + @Number;
   SET @Number = @Number + 1 ;
END
PRINT @Total;--Total = 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 + 10 = 55

--Example 2
-- Infinite SQL While Loop Example
--Declaring Number and Total Variables
DECLARE @Number INT = 1 ;

WHILE @Number < =   10
BEGIN
   PRINT @Number;
   --SET @Number = @Number + 1 ;
END

--Example 3
--Nested SQL While Loop Example

DECLARE @Val1 INT,
	@Val2 INT
SET @Val1 = 1

WHILE @Val1 <= 2
	BEGIN
		SET @Val2 = 1
		WHILE @Val2 <= 10
			BEGIN
				PRINT CONVERT(VARCHAR, @Val1) + ' * ' + CONVERT(VARCHAR, @Val2) + 
					' = ' + CONVERT(VARCHAR, @Val1 * @Val2)
				SET @Val2 = @Val2 + 1
			END
		SET @Val1 = @Val1 + 1
	END

--Example 4
--SQL BREAK Statement
DECLARE @Val INT
SET @Val = 10

WHILE @Val > 0
	BEGIN
		IF (@Val = 5)
			BREAK
		PRINT 'CG VAK ' + CONVERT(VARCHAR, @Val)
		SET @Val= @Val - 1
	END
PRINT 'This statement is Coming from Outside the While Loop'
GO

--Example 5
-- SQL CONTINUE Statement Example
DECLARE @Val INT
SET @Val = 1

WHILE @Val <= 10
	BEGIN
		IF (@Val = 3 OR @Val = 7)
		BEGIN
			PRINT 'Skipped By Continue Statement = ' + CONVERT(VARCHAR, @Val)
			SET @Val= @Val + 1
			CONTINUE
		END
		PRINT 'CG VAK = ' + CONVERT(VARCHAR, @Val)
		SET @Val= @Val + 1
	END
PRINT 'This statement is Coming from Outside the While Loop'
GO

--Example 6
--SQL GOTO Statement
DECLARE @TotalMaarks INT
SET @TotalMaarks = 0

IF @TotalMaarks >= 50
	GOTO Pass
IF @TotalMaarks < 50
	GOTO Fail

Pass:
	PRINT ' Congratulations '
	PRINT ' You pass the Examination '
	--RETURN

Fail:
	PRINT ' You Failed! '
	PRINT ' Better Luck Next Time '
	--RETURN
GO

--Example 7
--SQL Server Nested Transactions Example
USE master
GO
select * from demo
BEGIN TRANSACTION TRAN1

	INSERT INTO demo values(4,'Thara',22,'IT');--outer transaction

	BEGIN TRANSACTION 
		INSERT INTO demo values(5,'Parvathi',21,'IT');--inner transaction

	ROLLBACK TRANSACTION 

COMMIT TRANSACTION TRAN1
--As you can see, it is throwing an error message for the Last COMMIT TRANSACTION TRAN1 statement. 
--Because ROLLBACK will rollback all the statements.
select * from demo;

--Example 8
--SQL Server Nested Transactions Example

SELECT 'Before Staring any Transaction', @@TRANCOUNT 

BEGIN TRANSACTION 
	
	SELECT 'After Staring First Transaction', @@TRANCOUNT 

	BEGIN TRANSACTION TRAN2 
		SELECT 'After Staring Second Transaction', @@TRANCOUNT 
	COMMIT TRANSACTION TRAN2

	SELECT 'After Commiting the Second Transaction', @@TRANCOUNT 

ROLLBACK TRANSACTION 

SELECT 'After the First Transaction is Rollbacked', @@TRANCOUNT

--Example 9
BEGIN TRANSACTION 

	INSERT INTO demo values(5,'Sithara',22,'IT');--outer transaction

	BEGIN TRANSACTION 
		INSERT INTO demo values(4,'Sithara',22,'IT');--inner transaction

	COMMIT TRANSACTION 

--COMMIT TRANSACTION
ROLLBACK TRANSACTION --It will rollback everything inside the first transaction and second transaction.

select * from demo;

--Example 10
--SQL Server Nested Transactions Example

SELECT 'Before Staring any Transaction', @@TRANCOUNT 

BEGIN TRANSACTION TRAN1
 
 SELECT 'After Staring First Transaction', @@TRANCOUNT 

 SAVE TRAN TRAN2  
 SELECT 'Within the Save Transaction', @@TRANCOUNT 
 ROLLBACK TRAN TRAN2

 SELECT 'After Rollback th Save Transaction', @@TRANCOUNT 

COMMIT TRANSACTION TRAN1

SELECT 'After the First Transaction is Commited', @@TRANCOUNT 

--Example 11
BEGIN TRANSACTION TRAN1

	INSERT INTO demo values(4,'Parvathi',22,'IT');--outer transaction

	--SAVE TRANSACTION TRAN2
		INSERT INTO demo values(5,'Sithara',22,'IT');--inner transaction

	ROLLBACK TRANSACTION TRAN2

COMMIT TRANSACTION TRAN2

select * from demo;

