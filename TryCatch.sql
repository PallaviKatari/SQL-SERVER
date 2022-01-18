--Exception Handling Using Try Catch in SQL Server
USE DML;
alter PROCEDURE spDivideTwoNumbers
@Number1 INT, 
@Number2 INT
AS
BEGIN
  DECLARE @Result INT
  SET @Result = 0
  BEGIN TRY
    SET @Result = @Number1 / @Number2
    PRINT 'RESULT IS : '+CAST(@Result AS VARCHAR)
  END TRY
  BEGIN CATCH
    PRINT 'SECOND NUMBER SHOULD NOT BE ZERO'
  END CATCH
END

EXEC spDivideTwoNumbers 10, 10

--Example: try-catch with system defined error statements in SQL Server:

ALTER PROCEDURE spDivideTwoNumbers
@Number1 INT, 
@Number2 INT
AS
BEGIN
  DECLARE @Result INT
  SET @Result = 0
  BEGIN TRY
    SET @Result = @Number1 / @Number2
    PRINT 'RESULT IS : '+CAST(@Result AS VARCHAR)
  END TRY
  BEGIN CATCH
    PRINT ERROR_MESSAGE()
  END CATCH
END

EXEC spDivideTwoNumbers 10, 0

--Note: We cannot use the TRY/CATCH implementation within a user-defined function. 