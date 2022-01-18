use dml;

--STORED PROCEDURE EXAMPLES

-- Create a Procedure with table variables
CREATE PROCEDURE spAddTwoNumbers(@no1 INT, @no2 INT)
AS
BEGIN
SET NOCOUNT ON; 
  DECLARE @Result INT
  SET @Result = @no1 + @no2
  PRINT 'RESULT IS: '+ CAST(@Result AS VARCHAR)
END
GO
-- Calling the procedure:
EXECUTE spAddTwoNumbers 10, 20
-- OR 
EXECUTE spAddTwoNumbers @no1=10, @no2=20
--OR
EXEC spAddTwoNumbers @no1=10, @no2=20
--OR
spAddTwoNumbers @no1=10, @no2=20
-- OR calling the procedure by declaring two variables as shown below
DECLARE @no1 INT, @no2 INt
SET @no1 = 10
SET @no2 = 20
EXECUTE spAddTwoNumbers @no1, @no2

-- Create a Procedure for Update
alter PROCEDURE spUpdateTrainees28byID
(
  @ID INT, 
  @Name VARCHAR(50), 
  @Dept VARCHAR(50), 
  @Score INT
)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE Trainees28 SET 
      Empname = @Name, 
      Designation = @Dept, 
      Score = @Score
  WHERE empid=@ID;
  select * from Trainees28;
END
GO
-- Executing the Procedure
-- If you are not specifying the Parameter Names then the order is important
EXECUTE spUpdateTrainees28byID 16, 'Rocky R ','HR',97;

select * from Trainees28;

--Procedure with input and output parameters
CREATE PROCEDURE spGetResult
  @No1 INT,
  @No2 INT,
  @Result INT OUTPUT
AS
BEGIN
  SET @Result = @No1 + @No2
END

-- To Execute Procedure
DECLARE @Result INT
EXECUTE spGetResult 10, 20, @Result OUT
PRINT @Result

--CREATE PROCEDURE FOR INSERT
alter PROCEDURE InsertStoredProcedure
	@name VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO Toppers(empid,empname,score)
	                   SELECT empid,empname,score
			   FROM Trainees28
			   WHERE empname=@name;
			   --select * from Toppers;
			   --ALTER PROCEDURE AND TRY WITH DELETE
END
GO

exec InsertStoredProcedure 'Dora'

--PROCEDURE WITH IF THEN
ALTER PROCEDURE proc_ifthen
AS
BEGIN
    DECLARE @x INT = 10, @y INT = 20;

    IF (@x > 0)
    BEGIN
        IF (@x > @y)
            PRINT 'IF PART';
        ELSE
            PRINT 'ELSE PART';
    END			
END

exec proc_ifthen

----PROCEDURE WITH IF THEN on table Trainees28
Create PROCEDURE Name_Finder
( @name varchar(50) )
AS
BEGIN
  IF((SELECT empname FROM Trainees28 
  WHERE empname = @name) = @name)
    BEGIN
	Print 'The Trainee is: '+@name 
    END
   ELSE
    BEGIN
	Print 'The Trainee '+@name+' is not present'
    END
END

exec Name_Finder 'Nevetha';

--Procedure using case statement
CREATE PROCEDURE proc_case
AS
BEGIN
SELECT empid,empname,score,
CASE score
  WHEN '98' THEN 'Excellent'
  WHEN '97' THEN 'Good'
  WHEN '96' THEN 'Average'
END AS Remarks
FROM trainees28;
END;

exec proc_case;






