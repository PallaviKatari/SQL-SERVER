--create database
create database one;

--drop database
drop database one;

--Rename database
alter database Batch28 Modify Name=Trainees28;

--use the current database
use Trainees28;
--create table
CREATE TABLE Trainees
(
    ID int NOT NULL,
    Name int NOT NULL,
    Designation varchar(255),
    Age int,
    PRIMARY KEY (ID)
);
--select
select * from Trainees;

--primary key CONSTRAINT pk_ID PRIMARY KEY(ID) user defined name we ll see in the upcoming sessions
--insert values into the table
insert into Trainees values(1,'Nevetha','Dev',21);
insert into Trainees values(2,'Nevetha','Test',21);

--to change datatype
ALTER TABLE Trainees 
alter column name varchar(100) not null;

--select
select * from Trainees;

--drop primary key constraint
alter table Trainees drop primary key;

--pre defined primary key name
alter table Trainees drop [PK__Trainees__3214EC274357C6BD];

--primary key on multiple columns we ll see in detail in constraints concept
ALTER TABLE Trainees  
ADD CONSTRAINT pk_ID PRIMARY KEY (ID,Name); 

--insert
insert into Trainees values(3,'Nevetha','Test',21); 

--add colum
ALTER TABLE Trainees
ADD mobile int;

--drop column
ALTER TABLE Trainees
drop column age;

--copy table
SELECT * INTO T28 FROM Trainees;
select * from Trainees;
select * from T28;  

--Truncate table
TRUNCATE TABLE Trainees; 
 
--drop table
drop table T28;

--select
select * from Trainees;
select * from Trainees28; 

--drop table
drop table Trainees28;

--create schema (default schema dbo)
/*
A schema is a collection of database objects including 
tables, views, triggers, stored procedures, indexes, etc.*/

create schema bt28

DROP SCHEMA IF EXISTS bt28;

--create table with schema
CREATE TABLE bt28.T28
(
    ID int NOT NULL,
    Name varchar(10) NOT NULL,
    Designation varchar(255),
    Age int,
    PRIMARY KEY (ID)
);
--drop schema
DROP SCHEMA IF EXISTS bt28;

--drop primary key
alter table bt28.T28 drop [PK__T28__3214EC271F06867E];

--drop schema
DROP SCHEMA IF EXISTS bt28;

--drop table

drop table T28;

drop table bt28.T28;

