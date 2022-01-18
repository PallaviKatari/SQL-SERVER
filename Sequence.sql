use Trainees28;
--sequence
/*A sequence is an object in SQL Server that is used to generate a number sequence. 
This can be useful when we need to create a unique number to act as a primary key.*/

CREATE SEQUENCE [dbo].[SequenceObject]
AS INT
START WITH 1 
INCREMENT BY 1 

--check created sequence in programmability folder under your database folder

--current sequence
SELECT * FROM sys.sequences WHERE name = 'SequenceObject';
--ALTER SEQUENCE [SequenceObject] RESTART WITH 1

--To ensure the value now going to starts from 1, select the next sequence value as shown below.
SELECT NEXT VALUE FOR [dbo].[SequenceObject];

CREATE TABLE Employees
(
    Id INT PRIMARY KEY,
    Name NVARCHAR(50),
    Gender NVARCHAR(10)
);
-- Generate and insert Sequence values
INSERT INTO Employees VALUES
(NEXT VALUE for [dbo].[SequenceObject], 'Ben', 'Male');
INSERT INTO Employees VALUES
(NEXT VALUE for [dbo].[SequenceObject], 'Sara', 'Female');
--start from 1
ALTER SEQUENCE [SequenceObject] RESTART WITH 1
select * from employees;

/*
CREATE SEQUENCE [dbo].[SequenceObject] 
AS INT
START WITH 100
INCREMENT BY -1

CREATE SEQUENCE [dbo].[SequenceObject]
START WITH 100
INCREMENT BY 10
MINVALUE 100
MAXVALUE 150
If we call the NEXT VALUE FOR, when the value reaches 150 (MAXVALUE), we will get the following error.

ALTER SEQUENCE [dbo].[SequenceObject]
INCREMENT BY 10
MINVALUE 100
MAXVALUE 150
CYCLE

To Improve the Performance of Sequence Object
CREATE SEQUENCE [dbo].[SequenceObject]
START WITH 1
INCREMENT BY 1
CACHE 10
*/

--Drop Sequence object

Drop Sequence SequenceObject;

/*
Using SQL Server Graphical User Interface (GUI) to create the sequence object: 
Expand the database folder
Expand Programmability folder
Right-click on the Sequences folder
Select New Sequence
*/