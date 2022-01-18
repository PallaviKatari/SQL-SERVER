use dml;
/*Multi-Statement Table-Valued Function in SQL Server

The Multi-Statement Table Valued Function in SQL Server is the same as the Inline Table-Valued Function means it is also going to returns a table as an output but with the following differences.

The Multi-Statement Table-Valued Function body can contain more than one statement. In Inline Table-Valued Function, it contains only a single Select statement prepared by the return statement.
In Multi-Statement Table-Valued Function, the structure of the table returned from the function is defined by us. But, in Inline Table-Valued Function, the structure of the table is defined by 
the Select statement that is going to return from the function body.*/

--Let’s write both Inline and Multi-Statement Table-Valued functions in SQL Server that return the following output.

--Using Inline Table-Valued function
CREATE FUNCTION ILTVF_GetEmployees()
RETURNS TABLE
AS
RETURN (SELECT ID, Name, Cast(DOB AS Date) AS DOB
        FROM Employee1)

--Calling the Inline Table-Valued Function: 
SELECT * FROM ILTVF_GetEmployees()

-- Multi-statement Table Valued function:
alter FUNCTION MSTVF_GetEmployees()
RETURNS @Table Table (Empid int, Empname nvarchar(20), DOB Date)
AS
BEGIN
  INSERT INTO @Table
    SELECT ID, Name, Cast(DOB AS Date)
    FROM Employee where name like 'D%';
  Return
End

SELECT * FROM MSTVF_GetEmployees()

/*
What are the differences between Inline and Multi-Statement Table-Valued Functions in SQL Server?
In an Inline Table-Valued Function, the returns clause cannot define the structure of the table that the function is going to return whereas in the Multi-Statement Table-Valued Function the returns clause defines the structure of the table that the function is going to return.

The Inline Table-Valued Function cannot have BEGIN and END blocks whereas the Multi-Statement Table-Valued Function has the Begin and End blocks.

It is possible to update the underlying database table using the inline table-valued function but it is not possible to update the underlying database table using the multi-statement table-valued function.

Inline Table-Valued functions are better for performance than the Multi-Statement Table-Valued function. So, if the given task can be achieved using an Inline Table-Valued Function, then it is always preferred to use Inline Table-valued Function over the Multi-Statement Table-Valued function.

Reason For Better Performance: Internally SQL Server treats an Inline Table-Valued function much like a view and treats a Multi-Statement Table-Valued function as a stored procedure.*/

--Update underlying database table using the inline table-valued function in SQL Server

SELECT * FROM dbo.ILTVF_GetEmployees()

--For the above function, Employee is the underlying database table.

UPDATE ILTVF_GetEmployees() SET Name='Nevetha' WHERE ID= 2

/*
What is the Difference Between Functions and Procedures in SQL Server?
A function must return a value, it is mandatory whereas a procedure returning a value is optional.
The procedure can have parameters of both input and output whereas a function can have only input parameters.
In a procedure, we can perform Select. Update, Insert and Delete operations whereas function can only be used to perform select operations. It cannot be used to perform Insert, Update, and Delete operations that can change the state of the database.
A procedure provides the options to perform Transaction Management, Error Handling, etc whereas these operations are not possible in a function.
We call a procedure using EXECUTE/ EXEC command whereas a function is called by using SELECT command only.
From a procedure, we can call another procedure or a function whereas from a function we can call another function but not a procedure.
User-Defined Functions can be used in the SQL statements anywhere in the WHERE/HAVING/SELECT section where as Stored procedures cannot be.*/