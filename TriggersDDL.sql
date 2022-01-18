use sqltriggers

/*What are DDL TRIGGERS in SQL Server?
The DDL triggers in SQL Server are fired in response to a variety of data definition language (DDL) 
events such as Create, Alter, Drop, Grant, Deny, and Revoke (Table, Function, Index, Stored Procedure, etc…).
 That means DDL triggers in SQL Server are working on a database.

DDL triggers are introduced from SQL Server 2005 version which will be used to restrict 
the DDL operations such as CREATE, ALTER and DROP commands.*/

/*Types of DDL triggers in SQL Server?
There are two types of DDLs triggers available in SQL Server. They are as follows:

Database Scoped DDL Trigger
Server Scoped DDL Trigger*/

--1) Database Scoped DDL Triggers in SQL Server

/*Expand the Programmability folder. 
Then Expand the Database Triggers folder for a Database Scoped DDL Triggers*/

use sqltriggers

--Example 1
CREATE  TRIGGER  trRestrictCreateTable 
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
  PRINT 'YOU CANNOT CREATE A TABLE IN THIS DATABASE'
  ROLLBACK TRANSACTION
END

create table sample1(id int);
select * from sample;
drop table sample

--Example 2
--Create a trigger that will restrict ALTER operations on a specific database table.

CREATE TRIGGER  trRestrictAlterTable  
ON DATABASE
FOR  ALTER_TABLE
AS
BEGIN
  PRINT 'YOU CANNOT ALTER TABLES'
  ROLLBACK TRANSACTION
END

select * from sample
alter table sample add score int
alter table sample drop column age

--Example 3
--Create a trigger that will restrict dropping the tables from a specific database.
CREATE TRIGGER  trRestrictDropTable
ON DATABASE
FOR DROP_TABLE
AS
BEGIN
  PRINT 'YOU CANNOT DROP TABLES'
  ROLLBACK TRANSACTION
END

drop table sample1

--Example 4
--Prevent users from creating, altering, or dropping tables from a specific database using a single trigger.
DROP TRIGGER trRestrictCreateTable ON DATABASE
DROP TRIGGER trRestrictAlterTable ON DATABASE
DROP TRIGGER trRestrictDropTable ON DATABASE

CREATE TRIGGER trRestrictDDLEventsdml
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN 
   PRINT 'You cannot create, alter or drop a table'
   ROLLBACK TRANSACTION
END

--Example 5
--Disable/Enable a Database Scoped DDL trigger in SQL Server

DISABLE TRIGGER trRestrictDDLEvents ON DATABASE

ENABLE TRIGGER trRestrictDDLEvents ON DATABASE

--Example 6
CREATE TRIGGER trRenameTable
ON DATABASE
FOR RENAME
AS
BEGIN
    PRINT 'You just renamed something'
END

sp_rename 'Employee', 'Emp'

select * from Emp

--2) Server-scoped DDL Triggers in SQL Server
use dml;
use sqltriggers;
use Trainees28;
use BikeStores;
create table sample3(id int)
drop table sample2

CREATE TRIGGER trServerScopedDDLTrigger
ON ALL SERVER
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN 
   PRINT 'You cannot create, alter or drop a table in any database of this server'
   ROLLBACK TRANSACTION
END

/*
Where can I find the Server-scoped DDL triggers?
To find the Server-Scoped DDL Triggers in SQL Server Follow the below steps

In the Object Explorer window, expand the “Server Objects” folder
Then Expand the Triggers folder*/

--Disable/Enable Server-Scoped DDL trigger in SQL Server

 ENABLE TRIGGER trServerScopedDDLTrigger ON ALL SERVER 

 DISABLE TRIGGER trServerScopedDDLTrigger ON ALL SERVER

 DROP TRIGGER trServerScopedDDLTrigger ON ALL SERVER

 --Triggers Execution Order in SQL Server 

--1. Server-Scoped DDL trigger
--2. Database Scoped DDL trigger

--We can use the sp_settriggerorder system stored procedure to set 
--the execution order of Server-Scoped or Database-Scoped DDL triggers in SQL Server. 

sp_settriggerorder

--To understand the execution order, Let's create 2 database scoped DDL Trigger 

--Example
--DDl1
--DDl2
--ServerDDl1
--Specifying the order

EXEC sp_settriggerorder
  @triggername = 'DDl2',
  @order = 'FIRST',
  @stmttype = 'CREATE_TABLE',
  @namespace = 'DATABASE'
GO
EXEC sp_settriggerorder
  @triggername = 'DDl2',
  @order = 'LAST',
  @stmttype = 'ALTER_TABLE',
  @namespace = 'DATABASE'
GO


--OUTPUT
--ServerDDL1
--DDL2
--DDL1

/*
If we have both a database-scoped and a server-scoped DDL trigger handling the same event and if we have to set the execution order at both levels. Here is the execution order of the triggers.



The server-scope trigger set as First
Then other server-scope triggers
Next, the server-scope trigger set as Last
The database-scope trigger set as First
Then other database-scope triggers
The database-scope trigger set as Last */