use Trainees28;

--Identity -auto-increment
--Syntax: IDENTITY [(seed,increment)]
/*Seed: Starting value of a column. The default value is 1.
Increment: It specifies the incremental value that is added to the identity column 
value of the previous row. 
The default value is 1.*/

Create Table Person
(
     PersonId int identity(1, 1),
     Name nvarchar(20)
);

Insert into Person values ('Nevetha');
Insert into Person values ('James');
select * from Person;
Insert into Person values ('Mark');
Delete from Person where PersonId = 3;
Insert into Person values('Smith');
Insert into Person values(5,'Jancy');--not correct format to insert in identity column
select * from Person;

/*To explicitly supply a value for the identity column

First, turn on identity insert – SET Identity_Insert Person ON
Secondly, you need to specify the identity column name in the insert query as shown below*/

SET Identity_Insert Person ON;
Insert into Person(PersonId, Name) values(5, 'jancy');--correct format to insert in identity column
select * from Person;
Insert into Person values(5, 'Dean');--not allowed shd specify in this format Insert into Person(PersonId, Name) values(3, 'Sara');

Insert into Person values('Sam');--identity will not work
SET Identity_Insert Person OFF;
select * from Person;

--Reset the Identity Column Value in SQL Server
DBCC CHECKIDENT(Person, RESEED, 0); --Use DBCC command to reset the identity column value

Insert into Person values('Dean');

Select SCOPE_IDENTITY()
Select @@IDENTITY
Select IDENT_CURRENT('Person')

/*
SCOPE_IDENTITY(): The SCOPE_IDENTITY() built-in function returns the last identity column value that is created within the same session and the same scope.
@@IDENTITY: The @@IDENTITY() built-in function returns the last identity column value that is created in the same session but with any scope.
IDENT_CURRENT(‘TableName’): The IDENT_CURRENT() built-in function returns the last identity column value that is created for a specific table across any session and any scope.
*/
--In detail in triggers

drop table person;