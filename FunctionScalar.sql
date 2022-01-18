/*What is a function in SQL Server?
A function in SQL Server is a subprogram that is used to perform an action such as complex calculation and returns the result of the action as a value. 
There are two types of functions in SQL Server, such as

System Defined Function
User-Defined Function*/

/*Types of User-Defined Function:
In SQL Server, we can create three types of User-Defined Functions, such as

Scalar Valued Functions
Inline Table-Valued Functions
Multi-Statement Table-Valued Functions*/

-- 1) Scalar Valued Functions
/*The user-defined function which returns only a single value 
(scalar value) is known as the Scalar Valued Function. 
Scalar Value Functions in SQL Server may or may not have parameters 
that are optional but always return a single (scalar) value which is mandatory. 
The returned value which is return by the SQL Server Scalar Function can be 
of any data type, except text, ntext, image, cursor, and timestamp. */

use dml;
--Example
CREATE FUNCTION SVF1(@X INT)
RETURNS INT
AS
BEGIN
  RETURN @X * @X *@X
END

--call the function
SELECT dbo.SVF1(3)

--DATE DIFFERENCE
alter FUNCTION CalculateAge
(
  @DOB DATE
)
RETURNS INT
AS
BEGIN
  DECLARE @AGE INT
  SET @AGE = DATEDIFF(YEAR, @DOB, GETDATE())
  RETURN @AGE
END

SELECT dbo.CalculateAge ('01/07/2018')AS AGE

--Scalar Valued Function in Select Clause
select * from Employee;
SELECT ID, Name, DOB, dbo.CalculateAge(DOB) AS Age 
FROM Employee;

--SQL Server Scalar Valued Function in Where Clause
SELECT ID, Name, DOB, dbo.calculateAge(DOB) AS Age 
FROM Employee
WHERE dbo.calculateAge(DOB) > 30

--Table Creation
create table mcninvoices  
(  
    invoiceid int not null identity primary key,  
    vendorid int not null,  
    invoiceno varchar(15),  
    invoicetotal money,  
    paymenttotal money,  
    creadittotal money  
)  ;
insert into mcninvoices values (20,'e001',100,100,0.00) ; 
insert into mcninvoices values (21,'e002',200,200,0.00);  
insert into mcninvoices values (22,'e003',500,0.00,100) ; 
insert into mcninvoices values (23,'e004',1000,100,100) ; 
insert into mcninvoices values (24,'e005',1200,200,500) ; 
insert into mcninvoices values (20,'e007',150,100,0.00) ; 
insert into mcninvoices values (21,'e008',800,200,0.00) ; 
insert into mcninvoices values (22,'e009',900,0.00,100) ; 
insert into mcninvoices values (23,'e010',6000,100,100) ; 
insert into mcninvoices values (24,'e011',8200,200,500);
  
create table mcnvendors  
(  
    vendorid int,  
    vendorname varchar(15),  
    vendorcity varchar(15),  
    vendorstate varchar(15)  
) ;

insert into mcnvendors values (20,'vipendra','noida','up')  ;
insert into mcnvendors values (21,'deepak','lucknow','up') ; 
insert into mcnvendors values (22,'rahul','kanpur','up')  ;
insert into mcnvendors values (23,'malay','delhi','delhi') ; 
insert into mcnvendors values (24,'mayank','noida','up') ; 

select * from mcninvoices;
select * from mcnvendors;

--Scalar valued function for dbo.mcninvoices  table
CREATE FUNCTION fnbal_invoice()  
RETURNS MONEY  
BEGIN  
RETURN(SELECT SUM(invoicetotal-paymenttotal-creadittotal)  
        FROM dbo.mcninvoices  
        WHERE invoicetotal-paymenttotal-creadittotal > 0 )  
END

Print 'Balance amount is '+ 'Rs '+ convert(varchar,dbo.fnbal_invoice())
--SUM(invoicetotal-paymenttotal-creadittotal) = 19050-1200-1400 = 16450

alter FUNCTION fun_totalscore()    
RETURNS int  
BEGIN  
RETURN(SELECT avg(score)  
        FROM Trainees28 
       )  
END

print 'Average score is '+ convert(varchar,dbo.fun_totalscore() )

--Scalar valued function for dbo.mcnvendors  table
CREATE FUNCTION fnven_info  
(@vendorid int )  
RETURNS varchar(15)  
BEGIN  
    RETURN (SELECT vendorname FROM dbo.mcnvendors  
        WHERE vendorid=@vendorid)  
END

CREATE FUNCTION fn_custid() 
RETURNS int
BEGIN  
    RETURN (SELECT customerid FROM onlinecustomers  
        WHERE customercity='new york')  
END

select * from dbo.mcnvendors where vendorname=dbo.fnven_info(20);

select * from orders where customerid=dbo.fn_custid();

select * from onlinecustomers;
select * from orders;
select * from sales;