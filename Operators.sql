use dml;

--create table Trainees28
create table Trainees28
(
empid int not null,
empname varchar(50) not null,
designation varchar(50) not null,
score int not null,
constraint pk_empid2 primary key(empid)
);

--insert command in Trainees28
insert into Trainees28 values(1,'Nevetha','Developer',98);
insert into Trainees28 values(2,'Naveen','Developer',97);
insert into Trainees28 values(3,'Riju','Designer',97);
insert into Trainees28 values(4,'Aakass Elango','Designer',97);
insert into Trainees28 values(5,'Aakash','Developer',98);
insert into Trainees28 values(6,'Lalith','Designer',98);
insert into Trainees28 values(7,'Vishal','Designer',97);
insert into Trainees28 values(8,'JOHN','HR',98);
insert into Trainees28 values(9,'JAMES','Tester',98);
insert into Trainees28 values(10,'DEAN','HR',97);
insert into Trainees28 values(11,'SAM','HR',96);
insert into Trainees28 values(12,'JANCY','Tester',98);
insert into Trainees28 values(13,'NANCY','Developer',97);
insert into Trainees28 values(14,'DORA','Designer',96);
insert into Trainees28 values(15,'DAISY','Tester',97);
insert into Trainees28 values(16,'ROCKY','HR',97);	

--SELECT Trainees28
select * from Trainees28;

--create table DeptDev
create table DeptDev
(
empid int not null CONSTRAINT depdev_fk1 REFERENCES Trainees28(empid),
empname varchar(50) not null,
designation varchar(50) not null,
score int not null,
constraint pk_empid3 primary key(empid)
);

--insert command in DeptDev
insert into DeptDev values(1,'Nevetha','Developer',98);
insert into DeptDev values(2,'Naveen','Developer',97);
insert into DeptDev values(5,'Aakash','Developer',98);
insert into DeptDev values(13,'NANCY','Developer',97);

--alter and update
alter table DeptDev add Deptcode int;
update DeptDev set Deptcode=001;
alter table DeptDev add Prjcode int;
update DeptDev set Prjcode=100 where score=98;
update DeptDev set Prjcode=101 where score=97;

--select DeptDev
select * from DeptDev;

--create table DeptDes
create table DeptDes
(
empid int not null CONSTRAINT depdes_fk1 REFERENCES Trainees28(empid),
empname varchar(50) not null,
designation varchar(50) not null,
score int not null,
constraint pk_empid4 primary key(empid)
);

--insert command in DeptDes
insert into DeptDes values(3,'Riju','Designer',97);
insert into DeptDes values(4,'Aakass Elango','Designer',97);
insert into DeptDes values(6,'Lalith','Designer',98);
insert into DeptDes values(7,'Vishal','Designer',97);
insert into DeptDes values(14,'DORA','Designer',96);

--alter and update
alter table DeptDes add Deptcode int;
update DeptDes set Deptcode=002;
alter table DeptDes add Prjcode int;
update DeptDes set Prjcode=100 where score=98;
update DeptDes set Prjcode=101 where score=97;
update DeptDes set Prjcode=102 where score=96;

--select DeptDes
select * from DeptDes;

--create table DeptTes
create table DeptTes
(
empid int not null CONSTRAINT deptes_fk1 REFERENCES Trainees28(empid),
empname varchar(50) not null,
designation varchar(50) not null,
score int not null,
constraint pk_empid5 primary key(empid)
);

--insert command in DeptTes
insert into DeptTes values(9,'JAMES','Tester',98);
insert into DeptTes values(12,'JANCY','Tester',98);
insert into DeptTes values(15,'DAISY','Tester',97);

--alter and update
alter table DeptTes add Deptcode int;
update DeptTes set Deptcode=003;
alter table DeptTes add Prjcode int;
update DeptTes set Prjcode=100 where score=98;
update DeptTes set Prjcode=101 where score=97;


--select DeptTes
select * from DeptTes;

--create table Depthr
create table Depthr
(
empid int not null CONSTRAINT dephr_fk1 REFERENCES Trainees28(empid),
empname varchar(50) not null,
designation varchar(50) not null,
score int not null,
constraint pk_empid6 primary key(empid)
);

--insert command in Depthr
insert into Depthr values(8,'JOHN','HR',98);
insert into Depthr values(10,'DEAN','HR',97);
insert into Depthr values(11,'SAM','HR',96);
insert into Depthr values(16,'ROCKY','HR',97);	

--select Depthr
select * from Depthr;

/*The SQL UNION UNION ALL INTERSECT OPERATORS
The UNION operator is used to combine the result-set of two or more SELECT statements.

Every SELECT statement within UNION must have the same number of columns
The columns must also have similar data types
The columns in every SELECT statement must also be in the same order*/

SELECT EMPID,EMPNAME,PRJCODE FROM DEPTDEV
UNION
SELECT EMPID,EMPNAME,PRJCODE FROM DEPTDES

SELECT EMPID,EMPNAME,PRJCODE FROM DEPTDEV
UNION ALL
SELECT EMPID,EMPNAME,PRJCODE FROM DEPTDES

SELECT EMPID,EMPNAME,PRJCODE FROM DEPTDEV WHERE PRJCODE=100
UNION 
SELECT EMPID,EMPNAME,PRJCODE FROM DEPTDES WHERE PRJCODE=100

SELECT PRJCODE FROM DEPTDEV
INTERSECT
SELECT PRJCODE FROM DEPTDES --COMMON PROJECTS

--ORDER BY with SET OPERATORS
SELECT EMPID,EMPNAME,PRJCODE FROM DEPTDEV
UNION
SELECT EMPID,EMPNAME,PRJCODE FROM DEPTDES
ORDER BY PRJCODE

SELECT EMPID,EMPNAME,PRJCODE FROM DEPTDEV WHERE PRJCODE>100
UNION 
SELECT EMPID,EMPNAME,PRJCODE FROM DEPTDES WHERE PRJCODE>100
ORDER BY PRJCODE

--EXCEPT OPERATOR
SELECT empid,empname,score
	FROM Trainees28
	WHERE designation='Developer'
EXCEPT
SELECT empid,empname,score
	FROM deptdev
	WHERE score<=97;

--EXISTS
/*The EXISTS operator is used to test for the existence of any record in a subquery.
The EXISTS operator returns TRUE if the subquery returns one or more records.*/

SELECT EMPID,EMPNAME,DESIGNATION,SCORE
FROM DEPTDEV
WHERE EXISTS (SELECT EMPNAME FROM TRAINEES28
WHERE DEPTDEV.EMPID=TRAINEES28.EMPID AND SCORE>97);

--ANY ALL
SELECT empid,Empname,Designation
FROM Trainees28
WHERE empid = ANY (SELECT empid FROM Deptdev);

SELECT empid,Empname,Designation
FROM Trainees28
WHERE designation = All (SELECT designation FROM Deptdev );

--The SQL SELECT INTO Statement
--The SELECT INTO statement copies data from one table into a new table.
--You can perform any query and perform a backup
SELECT * INTO Trainees28Backup
FROM Trainees28;

/*The SQL INSERT INTO SELECT Statement
The INSERT INTO SELECT statement copies data from one table and inserts it into another table.
The INSERT INTO SELECT statement requires that the data types in source and target tables matches.*/

create table Toppers
(
empid int,
empname varchar(25),
score int
);

INSERT INTO Toppers(empid,empname,score)
SELECT empid,empname,score FROM Trainees28
WHERE score>97;

select * from Trainees28;
select * from Toppers;