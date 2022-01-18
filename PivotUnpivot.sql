use dml;
/*Pivot and Unpivot in SQL
In SQL, Pivot and Unpivot are relational operators that are used 
to transform one table into another in order to achieve more simpler view of table. 
Conventionally we can say that Pivot operator converts the rows
data of the table into the column data. 
The Unpivot operator does the opposite that is it transform the column based data into rows.*/

--EXAMPLE 1

Create Table course 
( 
CourseName nvarchar(50) primary key, 
CourseCategory nvarchar(50),
Price int  
) 

Insert into course  values('C', 'PROGRAMMING', 5000) 
Insert into course  values('JAVA', 'PROGRAMMING', 6000) 
Insert into course  values('PYTHON', 'PROGRAMMING', 8000) 
Insert into course  values('C#', 'PROGRAMMING', 8000) 
Insert into course  values('SQL', 'RDBMS', 8000) 
Insert into course  values('ORACLE', 'RDBMS', 8000) 

SELECT * FROM course 

--SYNTAX
/*SELECT (ColumnNames) 
FROM (TableName) 
PIVOT/UNPIVOT
 ( 
   AggregateFunction(ColumnToBeAggregated)
   FOR PivotColumn IN (PivotColumnValues)
 ) AS (Alias) //Alias is a temporary name for a table*/


--Now, applying PIVOT operator to this data:

select * from course;
SELECT CourseName, PROGRAMMING,RDBMS
FROM course 
PIVOT 
( 
SUM(Price) FOR CourseCategory IN (PROGRAMMING, RDBMS ) 
) AS PivotTable 

--Applying UNPIVOT operator:

SELECT CourseName, CourseCategory, Price 
FROM 
(
SELECT CourseName, PROGRAMMING, RDBMS FROM course 
PIVOT 
( 
SUM(Price) FOR CourseCategory IN (PROGRAMMING, RDBMS) 
) AS PivotTable
) P 
UNPIVOT 
( 
Price FOR CourseCategory IN (PROGRAMMING, RDBMS)
) 
AS UnpivotTable

--EXAMPLE 2
CREATE TABLE pivot_demo    
(    
   Region varchar(45),    
   Year int,    
   Sales int    
)  

INSERT INTO pivot_demo  
VALUES ('North', 2010, 72500),  
('South', 2010, 60500),  
('South', 2010, 52000),  
('North', 2011, 45000),  
('South', 2011, 82500),    
('North', 2011, 35600),  
('South', 2012, 32500),   
('North', 2010, 20500);   

--PIVOT Operator
SELECT * FROM pivot_demo;

SELECT Year, North, South FROM     
(SELECT Region, Year, Sales FROM pivot_demo ) AS Tab1    
PIVOT    
(SUM(Sales) FOR Region IN (North, South)) AS Tab2    
ORDER BY Tab2.Year;  

SELECT Region, [2010], [2011], [2012] FROM     
(SELECT Region, [Year], Sales FROM pivot_demo ) AS Tab1    
PIVOT    
(SUM(Sales) FOR [Year] IN ([2010], [2011], [2012])) AS Tab2  
ORDER BY Tab2.Region;

--UNPIVOT Operator

SELECT Region, Year, Sales FROM (  
SELECT Year, North, South FROM     
(SELECT Region, Year, Sales FROM pivot_demo ) AS Tab1    
PIVOT    
(SUM(Sales) FOR Region IN (North, South)) AS PivotTable    
) P  
--Perform UNPIVOT Operation  
UNPIVOT    
(    
Sales FOR Region IN (North, South)    
) AS UnpivotTable  