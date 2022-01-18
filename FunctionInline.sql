--Inline Table-Valued functions

/*What are Inline Table-Valued functions in SQL Server?

In the case of an Inline Table-Valued Function, 
the body of the function will have only a Single Select Statement 
prepared with the “RETURN” statement. 
And here, we need to specify the Return Type as TABLE by using 
the RETURNS TABLE statement. */

/*We specify TABLE as the Return Type instead of any scalar data type.
The function body is not closed between BEGIN and END blocks. 
This is because the function is going to return a single select statement.
The structure of the Table that is going to be returned is determined by the select statement used in the function.
*/

-- Create Student Table
CREATE TABLE Student
(
  ID INT PRIMARY KEY,
  Name VARCHAR(50),
  Gender VARCHAR(50),
  DOB DATETIME,
  Branch VARCHAR(50)
)
-- Populate the Student Table with test data
INSERT INTO Student VALUES(1, 'Rocky', 'Male','1996-02-29 10:53:27.060', 'CSE')
INSERT INTO Student VALUES(2, 'Daisy', 'Female','1995-05-25 10:53:27.060', 'CSE')
INSERT INTO Student VALUES(3, 'Lucky', 'Male','1995-04-19 10:53:27.060', 'ETC')
INSERT INTO Student VALUES(4, 'Dora', 'Female','1996-03-17 10:53:27.060', 'ETC')
INSERT INTO Student VALUES(5, 'Jancy', 'Female','1997-01-15 10:53:27.060', 'CSE')

select * from Student;
--Create a function that accepts student id as input and returns that student details from the table.
CREATE FUNCTION FN_GetStudentDetailsByID
(
  @ID INT
)
RETURNS TABLE
AS
RETURN (SELECT * FROM Student WHERE ID = @ID)

SELECT * FROM FN_GetStudentDetailsByID(2)

--Create a function to accept branch name as input and returns the list of students who belongs to that branch.

CREATE FUNCTION FN_GetStudentDetailsByBranch
(
  @Branch VARCHAR(50)
)
RETURNS TABLE
AS
RETURN (SELECT * FROM Student WHERE Branch = @Branch)

SELECT * FROM FN_GetStudentDetailsByBranch('CSE')

--Create a function that returns student Name, DOB, and Branch by GENDER.

CREATE FUNCTION FN_GetStudentDetailsByGender
(
  @Gender VARCHAR(50)
)
RETURNS TABLE
AS
RETURN (SELECT Name, DOB, Branch FROM Student WHERE Gender = @Gender)

SELECT * FROM FN_GetStudentDetailsByGender('Female')

/*The Inline Table-Valued function in SQL Server can be used to 
achieve the functionalities of parameterized views, 
and the table returned by the inline table-valued function in SQL 
Server can also be used in joins with other tables.*/

--Inline Table-Valued Function with JOINs in SQL Server

-- Create Department Table
CREATE TABLE Department
(
  ID INT PRIMARY KEY,
  DepartmentName VARCHAR(50)
)
GO
-- Populate the Department Table with test data
INSERT INTO Department VALUES(1, 'IT')
INSERT INTO Department VALUES(2, 'HR')
INSERT INTO Department VALUES(3, 'Sales')
GO
-- Create Employee Table
CREATE TABLE Employee1
(
  ID INT PRIMARY KEY,
  Name VARCHAR(50),
  Gender VARCHAR(50),
  DOB DATETIME,
  DeptID INT FOREIGN KEY REFERENCES Department(ID) 
)
GO
-- Populate the Employee Table with test data
INSERT INTO Employee1 VALUES(1, 'Vishal', 'Male','1996-02-29 10:53:27.060', 1)
INSERT INTO Employee1 VALUES(2, 'Nevetha', 'Female','1995-05-25 10:53:27.060', 2)
INSERT INTO Employee1 VALUES(3, 'Riju', 'Male','1995-04-19 10:53:27.060', 2)
INSERT INTO Employee1 VALUES(4, 'Lalith', 'Male','1996-03-17 10:53:27.060', 3)
INSERT INTO Employee1 VALUES(5, 'Naveen', 'Male','1997-01-15 10:53:27.060', 1)
INSERT INTO Employee1 VALUES(6, 'Aakash', 'Male','1995-07-12 10:53:27.060', 2)
INSERT INTO Employee1 VALUES(5, 'Aakass Elango', 'Male','1996-01-15 10:53:27.060', 1)
GO

--Let’s first create an Inline Table-Valued Function that returns the Employees by Gender from the Employees table.

CREATE FUNCTION FN_GetEmployeessByGender
(
  @Gender VARCHAR(50)
)
RETURNS TABLE
AS
RETURN (SELECT ID, Name, Gender, DOB, DeptID FROM Employee1 WHERE Gender = @Gender)

--Now, let’s join the Employees returned by the inline table-valued function with the Departments table as shown below

SELECT Name, Gender, DOB, DepartmentName 
FROM FN_GetEmployeessByGender('Male') Emp
JOIN Department Dept on Dept.ID = Emp.DeptID

SELECT ID, Name, Gender, DOB, DeptID FROM Employee1 WHERE Gender ='Male';
select * from Department;
--Example: Table-valued Function Returning data From two Tables using Join in SQL Server

CREATE FUNCTION FN_EmployeessByGender
(
  @Gender VARCHAR(50)
)
RETURNS TABLE
AS
RETURN (
       SELECT Emp.ID, Name, Gender, DOB, DepartmentName 
    FROM Employee1 Emp
    JOIN Department Dept on Emp.DeptId = Dept.Id
    WHERE Gender = @Gender)

SELECT * FROM dbo.FN_EmployeessByGender('Male');
select * from Employee1;
select * from Department;