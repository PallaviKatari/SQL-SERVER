Create database dml;

use dml;
--Emp28 table

--DROP COMMAND
drop table Emp28;

--CREATE COMMAND
create table Emp28
(
empid int not null,
empname varchar(50) not null,
designation varchar(50) not null,
mobile bigint not null,
constraint pk_empid primary key(empid)
);

--INSERT COMMAND
insert into Emp28 values(1,'Nevetha','Developer',9825637817);
insert into Emp28 values(2,'Naveen','Developer',9825611817);
insert into Emp28 values(3,'Riju','Designer',9825639917);
insert into Emp28 values(4,'Aakass Elango','Designer',9825237817);
insert into Emp28 values(5,'Aakash','Developer',9826737817);
insert into Emp28 values(6,'Lalith','Designer',9825633417);
insert into Emp28 values(7,'Vishal','Designer',9825787817);
insert into Emp28(empid,empname,designation,mobile) values(8,'Jancy','Developer',9825457817);
insert into Emp28(empid,empname,designation,mobile) values(9,'jancy','Developer',9825457817);

--SELECT COMMAND
	select * from Emp28 where empname='jancy' COLLATE SQL_Latin1_General_CP1_CS_AS;-- retrieve case sensitive record
	select empname,mobile from Emp28;
	select empid as ID,empname as 'EMPLOYEE NAME' from Emp28;
	

--DELETE COMMAND
	delete  Emp28 where empid=7;
	delete from Emp28;
	--delete from Emp28 will delete all the rows

--UPDATE COMMAND
	update Emp28 set empname='Nevetha J' where empname='Nevetha';
	update Emp28 set empname='Riju C' where empid=3;
	update Emp28 set designation='Developer' where empname='Vishal';
	update Emp28 set mobile=9876543210;--update all rows

--update empid of all records

DECLARE @empid INT,@count int,@counter int;
SET @empid = 201;
set @counter=0;
set @count=(select count(empid) from T28);
WHILE @counter <= @count
BEGIN
update t28 set empid=empid+100 where empid=@empid;
SET @empid = @empid + 1;
SET @counter = @counter + 1;
END;
GO

select * from T28;


--SELECT COMMAND WITH WHERE CONDITIONS
--BETWEEN AND
--RELATIONAL AND LOGICAL
	select * from Emp28 where designation='Developer';
	select empid,empname,designation from Emp28 where empid between 3 and 7;
	select * from Emp28 where empid>=5;
	select * from Emp28 where empid>=3 and designation='Developer';
	select * from Emp28 where empid>=3 or designation='Developer';
	select * from Emp28 where not empid<=3;
	select * from Emp28 where NOT empid>=3 or designation='Developer';

--IN AND NOT IN
	select * from Emp28 where empid in (1,3,5,7);
	select * from Emp28 where designation not in ('Developer','Designer');
	select * from T28 where designation not in ('Developer','Designer');

--TOP
	SELECT TOP 3 * FROM Emp28;
	SELECT TOP 50 percent * FROM Emp28;
	SELECT TOP 3 * FROM Emp28 where designation='Designer';

--CREATE TABLE T28
create table T28
(
empid int not null,
empname varchar(50) not null,
designation varchar(50) not null,
score int not null,
constraint pk_empid1 primary key(empid)
);

insert into T28 values(1,'Nevetha','Developer',98);
insert into T28 values(2,'Naveen','Developer',97);
insert into T28 values(3,'Riju','Designer',96);
insert into T28 values(4,'Aakass Elango','Designer',98);
insert into T28 values(5,'Aakash','Developer',97);
insert into T28 values(6,'Lalith','Designer',96);
insert into T28 values(7,'Vishal','Designer',97);
insert into T28 values(8,'No','Designer',97);

select * from T28;

--Aggregate Functions
--MIN() MAX() COUNT() AVG() SUM()
	select * from T28;
	select MIN(score)  MinScore ,max(score) from T28;
	select MAX(score) as MaxScore from T28;
	select AVG(score) as AvgScore from T28;
	select COUNT(score) as CountScore from T28;
	select SUM(score) as SumScore from T28;

--LIKE OPERATOR % and _
	SELECT * FROM T28 WHERE EMPNAME LIKE 'N%';
	SELECT * FROM T28 WHERE EMPNAME LIKE '%H';
	SELECT * FROM T28 WHERE EMPNAME LIKE '%A';
	SELECT * FROM T28 WHERE EMPNAME LIKE '%A%';
	SELECT * FROM T28 WHERE EMPNAME LIKE '_A%';
	SELECT * FROM T28 WHERE EMPNAME LIKE 'N__%'; --atleast 3 characters
	SELECT * FROM T28 WHERE EMPNAME LIKE 'N_%'; --atleast 2 characters
	SELECT * FROM T28 WHERE EMPNAME LIKE '[NLA]%';-- STARTING WITH N OR L OR A
	SELECT * FROM T28 WHERE EMPNAME NOT LIKE '[NLA]%';
	SELECT * FROM T28 WHERE EMPNAME NOT LIKE '[A-R]%';
	SELECT * FROM T28 WHERE EMPNAME LIKE '[A-R]%';--STARTING WITH A TO R

--ORDER BY
		select * from Emp28 ORDER BY empname;
		select * from Emp28 ORDER BY empname desc;
		select * from Emp28 ORDER BY designation,empname;
		select * from Emp28 ORDER BY designation,empname desc;

--GROUP BY
--The GROUP BY statement is often used with aggregate functions
--(COUNT(), MAX(), MIN(), SUM(), AVG()) to group the result-set by one or more columns.
	SELECT * FROM T28;
	SELECT COUNT(EMPNAME) as 'No of Employees', DESIGNATION FROM T28 GROUP BY DESIGNATION;
	SELECT AVG(SCORE) AS AVGSCORE, DESIGNATION FROM T28 GROUP BY DESIGNATION;
	SELECT MAX(SCORE) AS MAXSCORE, DESIGNATION FROM T28 GROUP BY DESIGNATION;
	SELECT MIN(SCORE) AS MINSCORE, DESIGNATION FROM T28 GROUP BY DESIGNATION;
	SELECT SUM(SCORE) AS SUMSCORE, DESIGNATION FROM T28 GROUP BY DESIGNATION;

--INSERT COMMAND
	insert into T28 values(9,'JAMES','Tester',98);
	insert into T28 values(10,'DEAN','HR',97);
	insert into T28 values(11,'SAM','HR',96);
	insert into T28 values(12,'JANCY','Tester',98);
	insert into T28 values(13,'NANCY','Developer',97);
	insert into T28 values(14,'DORA','Designer',96);
	insert into T28 values(15,'DAISY','Tester',97);
	insert into T28 values(16,'ROCKY','HR',97);

	SELECT COUNT(EMPNAME) as COUNT, DESIGNATION FROM T28 GROUP BY DESIGNATION ORDER BY DESIGNATION DESC;
	SELECT SUM(SCORE) AS SUMSCORE, DESIGNATION FROM T28 GROUP BY DESIGNATION ORDER BY SUM(SCORE) DESC;

--HAVING CLAUSE
	SELECT SUM(SCORE) AS SUMSCORE, DESIGNATION FROM T28 GROUP BY DESIGNATION WHERE SUM(SCORE)>300 ORDER BY SUM(SCORE) ;--NOT ALLOWED
	SELECT SUM(SCORE) AS SUMSCORE, DESIGNATION FROM T28 GROUP BY DESIGNATION HAVING SUM(SCORE)>300 ORDER BY SUM(SCORE) DESC ;

--DISTINCT AVOID DISPLAYING THE DUPLICATE RECORDS
	SELECT designation FROM T28;
	SELECT DISTINCT designation FROM T28;
	SELECT count(DISTINCT designation) FROM T28;
	SELECT count(designation) FROM T28;