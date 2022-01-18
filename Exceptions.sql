--Why do we need Exception Handling in SQL Server?
use dml;

ALTER PROCEDURE spDivideTwoNumber(
@Number1 INT, 
@Number2 INT
)
AS
BEGIN
    DECLARE @Result INT
    SET @Result = 0
    SET @Result = @Number1 / @Number2
    PRINT 'RESULT IS :'+CAST(@Result AS VARCHAR)
END

EXEC spDivideTwoNumber 100, 5

EXEC spDivideTwoNumber 100, 0

--Exception Handling Using RAISERROR System Function in SQL Server:

ALTER PROCEDURE spDivideTwoNumber
@Number1 INT, 
@Number2 INT
AS
BEGIN
    DECLARE @Result INT
    SET @Result = 0
    IF(@Number2 = 0)
    BEGIN
         RAISERROR('Second Number Cannot be zero', 16, 7) --(MSG,SEVERITY,STATE)
    END
    ELSE
    BEGIN
        SET @Result = @Number1 / @Number2
        PRINT 'RESULT IS : '+ CAST(@Result AS VARCHAR)
    END
END

EXEC spDivideTwoNumber 100, 0

/*What is RaiseError System Function in SQL Server?
The RaiseError System defined Function in SQL Server takes 3 parameters as shown below. 
RAISERROR(‘Error Message’, ErrorSeverity, ErrorState)

Error Message: The custom error message that you want to display whenever the exception is raised.
Error Severity: When we are returning any custom errors in SQL Server, we need to set the ErrorSeverity level as 16, which indicates this is a general error and this error can be corrected by the user. In our example, the error can be corrected by the user by giving a nonzero value for the second parameter.
Error State: The ErrorState is also an integer value between 1 and 255. The RAISERROR() function can only generate custom errors if you set the Error State value between 1 to 127.*/


--@@Error System Function in SQL Server:
--The @@Error system function returns a NON-ZERO value if there is an error, otherwise, ZERO indicates that the previous SQL statement was executed without any error. 

ALTER PROCEDURE spDivideTwoNumber
@Number1 INT, 
@Number2 INT
AS
BEGIN
  DECLARE @Result INT
  SET @Result = 0
  IF(@Number2 = 0)
  BEGIN
    RAISERROR('Second Number Cannot be zero',16,1)
  END
  ELSE
  BEGIN
    SET @Result = @Number1 / @Number2
  END
  IF(@@ERROR <> 0)
  BEGIN
    PRINT 'Error Occurred'
  END
  ELSE
  BEGIN
    PRINT 'RESULT IS :'+CAST(@Result AS VARCHAR)
  END
END

EXEC spDivideTwoNumber 100, 0

--Example with insert
select * from T28;
INSERT INTO T28 values(301,'abc','HR',98)
IF(@@ERROR <> 0)
     PRINT 'Error Occurred'
ELSE
     PRINT 'No Errors'

--OR

DECLARE @Error INT
INSERT INTO T28 values(301,'abc','HR',98)
Set @Error = @@ERROR
SELECT * FROM T28
IF(@Error <> 0)
     PRINT 'Error Occurred'
ELSE
     PRINT 'No Errors'

--Predefined Error Terms in SQL Server:
/*Whenever an error occurs under a program like dividing a number by zero, 
violation of primary key, 
violation of Check constraint, etc. 
the system displays an error message telling us the problem encountered in the code.
Every error that occurs in the program is associated with four attributes.

Error Number
Error Message
Severity Level
Error State
Example:
Message 8134 (Error Number), Level 16(SEVERITY Level), State 1 (state), Divide by Zero error encountered (Error Message)*/

/*
Error Number: The Error number is a unique identifier given for each and every error that occurs in SQL Server. This value will be below 50,000 for predefined errors and must be above or equals to 50,000 for errors defined by the user. 
While raising custom errors, if we don’t specify the error number, then by default it will set the Error Number as 50000.

Error Message: It is a piece of brief information describing the error that occurred which should be maxing from 2047 characters.

Severity Level: This tells about the importance of the error which can be ranging between 0 to 24. In which

0 to 9: are not serves which can be considered as information or status messages.
11 to 16:  Indicates these errors can be created by the user.
17 to 19: Indicates these are software errors that cannot be corrected by the user must be reported to the system administrator.
20 to 24: Indicates fatal errors and if these errors occur they can damage the system or database. So here the connection immediately terminates with the database.
State: It is an arbitrary value that is not that important can be ranging between 0 to 127. We use this whenever the same error has to occur in multiple places.

Note: We can find the information of all predefined errors under the table “Sys.Messages”*/

SELECT * FROM SYS.messages ORDER BY MESSAGE_ID;
