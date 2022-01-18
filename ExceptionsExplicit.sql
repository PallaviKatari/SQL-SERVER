use dml;
--How to Raise Errors Explicitly in SQL Server?

--Example: Raise Error using RAISERROR statement in SQL Server.

ALTER PROCEDURE spDivideBy1(@No1 INT, @No2 INT)
AS
BEGIN
  DECLARE @Result INT
  SET @Result = 0
  BEGIN TRY
    IF @No2 = 1
    RAISERROR ('DIVISOR CANNOT BE ONE', 16, 1) -- ERROR NUMBER IS 50000 BY DEFAULT
    SET @Result = @No1 / @No2
    PRINT 'THE RESULT IS: '+CAST(@Result AS VARCHAR)
  END TRY
  BEGIN CATCH
    PRINT ERROR_NUMBER()
    PRINT ERROR_MESSAGE()
    PRINT ERROR_SEVERITY()
    PRINT ERROR_STATE()
  END CATCH
END

 EXEC spDivideBy1 10, 0 
 EXEC spDivideBy1 10, 1
 EXEC spDivideBy1 10, 10

 --Example: Raise Error using throw statement in SQL Server.

ALTER PROCEDURE spDivideBy2(@No1 INT, @No2 INT)
AS
BEGIN
  DECLARE @Result INT
  SET @Result = 0
  BEGIN TRY
    IF @No2 = 1
    THROW 50001,'DIVISOR CANNOT BE ONE', 1
    SET @Result = @No1 / @No2
    PRINT 'THE RESULT IS: '+CAST(@Result AS VARCHAR)
  END TRY
  BEGIN CATCH
    PRINT ERROR_NUMBER()
    PRINT ERROR_MESSAGE()
    PRINT ERROR_SEVERITY()
    PRINT ERROR_STATE()
  END CATCH
END

EXEC spDivideBy2 10, 1
EXEC spDivideBy2 10, 0
/*
What is the difference between the RAISERROR function and the throw statement in SQL Server?

If we use any of the two statements in a program for raising a custom error without try and catch blocks, 
the RAISERROR statement after raising the error will still continue the execution of the program 
whereas the throw statement will terminate the program abnormally on that line. 
But if they are used under try block both will behave in the same way that it will jump directly 
to catch block from where the error got raised.

The RAISERROR statement will give an option of specifying the ERROR SEVERITY Level of the error message 
whereas we don’t have this option in the case of the throw statement where all error messages will have a default  ERROR SEVERITY level as 16.

In the case of RAISERROR, there is a chance of recording the error message into the server log file by using 
the with log option whereas we cannot do this in case of a throw statement. 

In the case of throw, we need to specify both the errorid and error message to raise the error 
whereas in the case of RAISERROR we can specify either id or message. 
If the id is not specified default error id is 50000 but 
if we want to specify only the error id first we need to add the error message 
in the sysmessage table by specifying a unique id to the table.*/

/*
OPTIONS WITH RAISERROR STATEMENT:
With Log: By using this option in the RAISERROR statement we can record the error message in the SQL Server log file 
so that if the errors are fatal database administrator can take care of fixing those errors. 
If the severity of the error is greater than 20 specifying the With Log option is mandatory. 
To test this ALTER the procedure spDivideBy1 by changing the raiserror statement as following

RAISERROR (‘DIVISOR CANNOT BE ONE’, 16, 1) WITH LOG*/

CREATE PROCEDURE spDivideByONE(@No1 INT, @No2 INT)
AS
BEGIN
  DECLARE @Result INT
  SET @Result = 0
  BEGIN TRY
    IF @No2 = 1
    RAISERROR ('DIVISOR CANNOT BE ONE', 16, 1) WITH LOG
    SET @Result = @No1 / @No2
    PRINT 'THE RESULT IS: '+CAST(@Result AS VARCHAR)
  END TRY
  BEGIN CATCH
    PRINT ERROR_NUMBER()
    PRINT ERROR_MESSAGE()
    PRINT ERROR_SEVERITY()
    PRINT ERROR_STATE()
  END CATCH
END

--CHECK IN MANAGEMENT-SQL SERVER LOGS

--Using substitutional parameters in the error message of RAISERROR:

