/*In 1970's the product called 'SEQUEL', structured English query language, developed by IBM and later SEQUEL was renamed to 'SQL' which stands for Structured Query Language.

In 1986, SQL was approved by ANSI (American national Standards Institute) and in 1987, it was approved by ISO (International Standards Organization).

SQL is a structure query language which is a common database language for all RDBMS products. Different RDBMS product vendors have developed their own database language by extending SQL for their own RDBMS products.

T-SQL stands for Transact Structure Query Language which is a Microsoft product and is an extension of SQL Language.

Example
MS SQL Server - SQL\T-SQL

ORACLE - SQL\PL-SQL*/

--STORED PROCEDURES

--The MS SQL Server Stored procedure is used to save time to write code again and again 
--by storing the same in database and also get the required output by passing parameters.

/*A stored procedure is a group of one or more pre-compiled SQL statements into a logical unit.
 It is stored as an object inside the database server. 
 It is a subroutine or a subprogram in the common computing language that has been created and stored in the database. 
 Each procedure in SQL Server always contains a name, parameter lists, and Transact-SQL statements. 
 The SQL Database Server stores the stored procedures as named objects. 

SYNTAX:
CREATE PROCEDURE [schema_name].procedure_name  
                @parameter_name data_type,   
                ....   
                parameter_name data_type  
AS  
   BEGIN  
      -- SQL statements  
      -- SELECT, INSERT, UPDATE, or DELETE statement  
   END  */

--SQL Server builds an execution plan when the stored procedure is called the first time and stores them in the cache memory. 
--The plan is reused by SQL Server in subsequent executions of the stored procedure, allowing it to run quickly and efficiently.

/*Features of Stored Procedures in SQL Server
The following are the features of stored procedure in SQL Server:

Reduced Traffic: A stored procedure reduces network traffic between the application and the database server, resulting in increased performance. It is because instead of sending several SQL statements, the application only needs to send the name of the stored procedure and its parameters.

Stronger Security: The procedure is always secure because it manages which processes and activities we can perform. It removes the need for permissions to be granted at the database object level and simplifies the security layers.

Reusable: Stored procedures are reusable. It reduces code inconsistency, prevents unnecessary rewrites of the same code, and makes the code transparent to all applications or users.

Easy Maintenance: The procedures are easier to maintain without restarting or deploying the application.

Improved Performance: Stored Procedure increases the application performance. Once we create the stored procedures and compile them the first time, it creates an execution plan reused for subsequent executions. The procedure is usually processed quicker because the query processor does not have to create a new plan.

Types of Stored Procedures
SQL Server categorizes the stored procedures mainly in two types:
User-defined Stored Procedures
System Stored Procedures*/

--Example:
use dml;

CREATE PROCEDURE proc_t28 
AS  
BEGIN  
    SELECT empid,empname,score  
	FROM Trainees28  
    ORDER BY score desc;  
END;   

exec proc_t28;

/*SET NOCOUNT ON in Stored Procedure
In some cases, we use the SET NOCOUNT ON statement in the stored procedure. 
This statement prevents the message that displays the number of rows affected by SQL queries from being shown. 
NOCOUNT denotes that the count is turned off. 
It means that if SET NOCOUNT ON is set, no message would appear indicating the number of rows affected.*/

alter PROCEDURE dbo.proc_t28 
AS  
BEGIN  
    SELECT empid,empname,score  
    FROM Trainees28  
    ORDER BY score;  
END;   

exec proc_t28;

SELECT * FROM sys.procedures;  

DROP PROCEDURE proc_t28; 

--Input Parameters in Stored Procedure

CREATE PROCEDURE proc_traineedetails (@designation VARCHAR(50))  
AS  
BEGIN  
  --SET NOCOUNT ON;  
  SELECT empid,empname,designation 
  FROM trainees28  
  WHERE designation = @designation 
END 

exec proc_traineedetails @designation='hr';
--or
exec proc_traineedetails 'Tester';

--Output Parameters in Stored Procedure
CREATE PROCEDURE proc_avgscore (@avgscore INT OUTPUT)  
AS  
BEGIN  
    SELECT @avgscore = avg(score) FROM trainees28;  
END;  

-- Declare an Int Variable that corresponds to the Output parameter in SP  
DECLARE @Averagescore INT   
  
-- Don't forget to use the keyword OUTPUT  
EXEC  proc_avgscore @Averagescore OUTPUT  
  
-- Print the result  
PRINT @Averagescore  

CREATE PROCEDURE proc_des_score @designation nvarchar(30), @score int
AS
SELECT * FROM trainees28 WHERE designation = @designation AND score = @score
GO

EXEC proc_des_score 'developer', 98
--or
EXEC proc_des_score @designation='designer',@score= 97

--Temporary Stored Procedure
--We can create temporary procedures in the same way as we can create temporary tables.
-- The tempdb database is used to create these procedures. 
--We can divide the temporary procedures into two types:

--Local Temporary Stored Procedures
--Global Temporary Procedures.

CREATE PROCEDURE #Temp  
AS  
BEGIN  
PRINT 'Local temp procedure'  
END  

exec #Temp 

CREATE PROCEDURE ##TEMP  
AS  
BEGIN  
PRINT 'Global temp procedure'  
END  

exec ##Temp 

/*Disadvantages of Stored Procedures
The following are the limitations of stored procedures in SQL Server:

Debugging: Since debugging stored procedures is never simple, it is not advised to write and execute complex business logic using them. As a result, if we will not handle it properly, it can result in a failure.

Dependency: As we know, professional DBAs and database developers handle vast data sets in large organizations. And the application developers must depend on them because any minor changes must be referred to a DBA, who can fix bugs in existing procedures or build new ones.

Expensive: Stored procedures are costly to manage in terms of DBAs because organizations would have to pay extra costs for specialist DBAs. A DBA is much more qualified to handle complex database procedures.

Specific to a Vendor: Stored procedures written in one platform cannot run on another. Since procedures written in Oracle are more complicated, we will need to rewrite the entire procedure for SQL Server.
*/