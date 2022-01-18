use dml;

--virtual table
--Types of Views
--In SQL Server we have two types of views.

--1)System Defined Views
/*System-defined Views are predefined Views that already exist in the Master database of SQL Server. 
These are also used as template Views for all newly created databases. 
These system Views will be automatically attached to any user-defined database.*/

--Information Schema View
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME='Trainees28';

--Catalog View
select * from sys.tables ;

--Dynamic Management View
/*These Views give the administrator information of the database about the current state of the SQL Server machine. 
These values help the administrator to analyze problems and tune the server for optimal performance. 
These are of two types:*/

/*Server-scoped Dynamic Management View
These are stored only in the Master database.

Database-scoped Dynamic Management View
These are stored in each database.*/

 --To see all SQL Server connections
SELECT connection_id,session_id,client_net_address,auth_scheme
FROM sys.dm_exec_connections ;

--2)User Defined Views
--These types of view are defined by users. We have two types of user-defined views.

--Simple View
--When we create a view on a single table, it is called a simple view.

-- Create view on single table Trainees28
create VIEW Trainees28Toppers
AS
Select *
From trainees28 where score>97;

select * from Trainees28Toppers;

--In the simple view we can insert, update, delete data. 
--We can only insert data in a simple view if we have a primary key and all not null fields in the view.

insert into Trainees28Toppers values(17,'Lucky','HR',98);

update Trainees28Toppers set designation='Tester' where empid=17;

delete from Trainees28Toppers where empid=17;

--Complex View
--When we create a view on more than one table, it is called a complex view.

create view onlineshoppingview
as
SELECT OC.CUSTOMERID,customerName, customercity, customermail, salestotal,o.orderid
FROM onlinecustomers AS oc
   INNER JOIN
   orders AS o
   ON oc.customerid = o.customerid
   INNER JOIN
   sales AS s
   ON o.orderId = s.orderId;

select * from onlineshoppingview;

--We can only update data in a complex view. We can't insert data in a complex view.

update onlineshoppingview set salestotal=salestotal-50;