use Trainees28;

--Primary key constraint
CREATE TABLE Trainees
(
    ID int NOT NULL,
    Name varchar(25) NOT NULL,
    Designation varchar(255),
    Age int,
    constraint pkid  PRIMARY KEY (ID)
);

--drop primary key constraint
alter table Trainees drop pkid;

--primary key on multiple columns we ll see in detail in constraints concept
--composite key
ALTER TABLE Trainees  
ADD CONSTRAINT pk_idname PRIMARY KEY (ID,Name); 

--composite primary key checks only the combination
insert into Trainees values(1,'Nevetha J','Test',21); 
insert into Trainees values(3,'Nevetha J','Test',21);
insert into Trainees values(2,'Nevetha J','Test',21);

select * from Trainees; 

--Foreign key constraint
--dept table with primary key
CREATE TABLE Dept 
( 
    Dno   INT PRIMARY KEY, 
    Dname VARCHAR(30), 
    Dloc  CHAR(40) 
) 
GO
INSERT Dept VALUES (10, '.NET', 'HYD') 
INSERT Dept VALUES (20, 'JAVA', 'PUNE') 
INSERT Dept VALUES (30, 'PHP', 'DELHI') 
Go
Select * from Dept
Go
--Employee table with foreign key referencing dept table(dno)
CREATE TABLE Employee 
( 
    Eid    INT PRIMARY KEY, 
    Ename  VARCHAR(30), 
    Salary MONEY, 
    Dno    INT FOREIGN KEY REFERENCES Dept(Dno) 
) ;
INSERT into Employee VALUES (101,'AA', 25000, 10) -- Allowed
INSERT into Employee VALUES (104,'BB', 32000, 30) -- Allowed
INSERT into Employee VALUES (103,'CC', 52000, 40) -- Not Allowed

Select * from Dept;
select * from Employee;
/*COLUMN LEVEL CONSTRAINT
CREATE TABLE Employee 
( 
    Empid  INT, 
    Ename  VARCHAR(40), 
    Job    VARCHAR(30), 
    Salary MONEY, 
    Deptno INT CONSTRAINT deptn0_fk REFERENCES Dept(Dno)
)
TABLE LEVEL CONSTRAINT
CREATE TABLE Employee 
( 
    Empid  INT, 
    Ename  VARCHAR(40), 
    Job    VARCHAR(30), 
    Salary MONEY, 
    Deptno INT CONSTRAINT deptn0_fk REFERENCES Dept(Dno)
)*/

--Primary Key and Foreign key relationship between Multiple Tables in SQL Server

--CUSTOMER TABLE
CREATE TABLE Customer 
( 
    Cid    INT PRIMARY KEY, 
    Cname  VARCHAR(40), 
    Cmobno CHAR(10) 
);
INSERT INTO Customer VALUES (1, 'AA', '9853977973') ;
INSERT INTO Customer VALUES (2, 'BB', '8895558077') ;
INSERT INTO Customer VALUES (3, 'CC', '7021801173') ;
SELECT * FROM Customer;

--PRODUCTS TABLE
CREATE TABLE Products 
( 
    Pcode INT PRIMARY KEY, 
    Pname VARCHAR(20), 
    Price MONEY 
) ;
INSERT INTO Products VALUES (10,'C',500) ;
INSERT INTO Products VALUES (20,'C++',1000) ;
INSERT INTO Products VALUES (30,'.NET',3500) ;
INSERT INTO Products VALUES (40,'SQL',1800) ;

SELECT * FROM Customer;
SELECT * FROM Products;

--ORDERS TABLE
CREATE TABLE Orders 
( 
    Odid     INT PRIMARY KEY, 
    Ordate   DATE, 
    Quantity INT, 
    Cid      INT FOREIGN KEY REFERENCES Customer(Cid), 
    Pcode    INT FOREIGN KEY REFERENCES Products(Pcode) 
) ;
INSERT INTO Orders VALUES (101,'2017/12/20',9,1,10) ;
INSERT INTO Orders VALUES (102,'2017/12/20',10,2,10) ;
INSERT INTO Orders VALUES (103,'2017/12/21',6,3,20) ;
INSERT INTO Orders VALUES (104,'2017/12/22',11,1,40) ;
INSERT INTO Orders VALUES (105,'2017/12/23',8,1,30) ;
INSERT INTO Orders VALUES (106,'2017/12/23',8,10,30) ;--not allowed
SELECT * FROM Orders;
SELECT * FROM Customer;
SELECT * FROM Products;

--Cascading Referential Integrity Constraints in SQL Server
--on delete and on update 
--on delete/update no action is default
create table Themes
(
	ThemeID int primary key,
	ThemeName varchar(100)
);

create table Users
(
	UserID int primary key,
	UserName varchar(100),
	ThemeID int constraint ThemeID_FK references Themes(ThemeID) 
);

drop table users;
drop table themes;

insert into Themes (ThemeID, ThemeName) values (1,'Default');
insert into Themes (ThemeID, ThemeName) values (2,'Winter');

insert into Users(UserID, UserName, ThemeID) values (1,'JSmith',2);
insert into Users(UserID, UserName, ThemeID) values (2,'Ted',1);
insert into Users(UserID, UserName, ThemeID) values (3,'Mary',2);
insert into Users(UserID, UserName, ThemeID) values (4,'John',1);
insert into Users(UserID, UserName, ThemeID) values (5,'James',3);--not allowed

select * from Themes;
select * from Users;

delete from Themes where ThemeID=2;
update Themes set ThemeID=100 where ThemeID=1;
--On Delete Cascade
-- remove the existing constraint:
alter table users drop constraint ThemeID_FK;

-- re-create it:
alter table users add constraint ThemeID_FK 
    foreign key (ThemeID) references Themes(ThemeID)on update cascade;

go

delete from Themes where ThemeID =2;

select * from Users;

--On Delete Set Null
-- remove the existing constraint:
alter table users drop constraint ThemeID_FK;

-- This time, create it with on delete set null:
alter table users add constraint ThemeID_FK 
    foreign key (ThemeID) references Themes(ThemeID) on delete set null;

-- Add our data back in
insert into Themes (ThemeID, ThemeName) values (2,'Winter');
insert into Users(UserID, UserName, ThemeID) values (1,'JSmith',2);
insert into Users(UserID, UserName, ThemeID) values (3,'Mary',2);

-- And now delete ThemeID 2 again:
delete from Themes where ThemeID =2;

-- Let's see what we've got:
select * from Themes;
select * from Users;

--On Delete Set Default

drop table Users
drop table Themes
go

create table Users
(
	UserID int primary key,
	UserName varchar(100),
	ThemeID int default 1 constraint ThemeID_FK 
	    references Themes(ThemeID) on delete set default
)
go

-- Add ThemeID 2 back in:
insert into Themes (ThemeID, ThemeName) values (2,'Winter');

-- Re-create our users again:
insert into Users(UserID, UserName, ThemeID) values (4,'JSmith',2);
insert into Users(UserID, UserName, ThemeID) values (5,'Ted',1);
insert into Users(UserID, UserName, ThemeID) values (6,'ARod',2);

-- Now, delete ThemeID 2:
delete from Themes where ThemeID = 2;

-- And let's see what we've got:
select * from Users;
select * from themes;