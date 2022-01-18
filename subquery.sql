use dml;
/*A SUBQUERY is a SQL query within a SQL statement.
 A subquery can be part of a SELECT, INSERT, UPDATE or DELETE statement and is itself always a SELECT query. 
 It is also possible for a subquery to have another subquery within it. 
 A subquery within a subquery is called a NESTED SUBQUERY and the phenomenon is called NESTING. 
 SQL Server supports 32 levels of nesting i.e. 32 subqueries in a statement. 
 A SUBQUERY is also called an INNER QUERY or INNER SELECT and the main SQL statement 
 of which it is a part and which it feeds with data is called the OUTER QUERY or MAIN QUERY.*/

select * from onlinecustomers;
select * from orders;
select * from sales;
select * from Trainees28;

 --SQL Server SUBQUERY –  WHERE subquery example
 --SELECT select_list FROM table_name WHERE (subquery);
 --select * from emp where id=10;

SELECT customerid,orderid, orderdate,ordertotal
FROM orders
WHERE customerid IN
(SELECT customerid FROM onlinecustomers WHERE customercity in ('New york','chicago'))
ORDER BY ordertotal DESC;

SELECT *   
    FROM sales
    WHERE salestotal IN (SELECT salestotal   
    FROM sales   
    WHERE salestotal>400); 

--SQL Server SUBQUERY –  SELECT subquery example
--select empid,empname from emp;

SELECT empid,empname,designation,
(SELECT prjcode FROM deptdev d WHERE d.empid = t.empid) Prjcode
FROM Trainees28 t; --only deptdev prjcode details will be displayed

select * from Trainees28;
select * from Deptdev;

--SQL Server SUBQUERY –  FROM subquery example
--Find all employees whose score is greater than the average score of the deptdev.

select T.EMPID, T.EMPNAME, T.DESIGNATION, T.SCORE from
(select avg(SCORE) as averageScore from Deptdev) as D, Trainees28 as T
where T.Score > D.averageScore;

--Subqueries with the INSERT Statement
create table DeptdevToppersbackup 
(
empid int,
empname varchar(25),
score int,
prjcode int
);

drop table DeptdevToppersbackup;

INSERT INTO DeptdevToppersbackup  
   SELECT empid,empname,score,prjcode FROM Deptdev   
   WHERE empid IN (SELECT empid
   FROM Deptdev where score >97);

   select * from DeptdevToppersbackup;
   select * from Deptdev;

--Subqueries with the UPDATE Statement
--update emp set empid=100 where empname='abc';

	UPDATE orders  
   SET discountrate = discountrate * 0.25   
   WHERE customerid IN (SELECT customerid FROM onlinecustomers  
      WHERE customercity IN('Chicago','New York'));  

	select * from onlinecustomers;
	select * from orders;

--Subqueries with the DELETE Statement
--delete from emp where empid>10;

	DELETE FROM orders   
	WHERE customerid IN (SELECT customerid FROM onlinecustomers  
      WHERE customercity IN('Chicago','New York'));  

INSERT INTO [dbo].[orders]([customerid],[ordertotal],[discountrate],[orderdate]) VALUES (7,912.55,13.74,CAST('15-Sep-2019' AS DATETIME))
INSERT INTO [dbo].[orders]([customerid],[ordertotal],[discountrate],[orderdate]) VALUES (3,418.24,14.53,CAST('28-May-2019' AS DATETIME))

--Subquery
--When a query is included inside another query, the Outer query is known as Main Query, and Inner query is known as Subquery.
--Nested Query –
--In Nested Query,  Inner query runs first, and only once. 
--Outer query is executed with result from Inner query.
--Hence, Inner query is used in execution of Outer query.

--There are mainly two types of nested queries:

/*Independent Nested Queries: In independent nested queries, query execution starts from innermost query to outermost queries. 
The execution of inner query is independent of outer query, but the result of inner query is used in execution of outer query.
Various operators like IN, NOT IN, ANY, ALL etc are used in writing independent nested queries.*/

--Find details of customers who have ordered.(simple subquery)
SELECT * FROM onlineCustomers WHERE 
CustomerID IN (SELECT CustomerID FROM Orders);

--If we want to find out empid of employees in deptdes who are neither 
--in ‘Prjcode100’ nor in ‘Prjcode101’, it can be done as:(subquery using NOT IN)

Select * from deptdes where empid NOT IN

(SELECT empid from deptdes where prjcode=100 or prjcode=101);

--Nested query

--If we want to find out the sales details of customers who are either from ‘Chicago’ or ‘New York’, it can be done as:
select * from onlinecustomers;
select * from orders;
select * from sales;

Select salesid from sales where orderid IN

(Select orderid from orders where customerid IN

(SELECT customerid from onlinecustomers where CustomerCity='Chicago'  or CustomerCity='New York'));

--ANY ALL OPERATORS
--ANY means that the condition will be true if the operation is true for any of the values in the range.
--ALL means that the condition will be true only if the operation is true for all values in the range. 

SELECT empid,Empname,Designation
FROM Trainees28
WHERE empid = Any (SELECT empid FROM Deptdev);

SELECT * 
FROM onlinecustomers
WHERE customerid = Any (SELECT customerid
                       FROM orders
                       WHERE orderid<5);

SELECT empid,Empname,Designation,score
FROM Trainees28
WHERE score = Any (SELECT avg(score) FROM Deptdev);

SELECT empid,Empname,Designation,score
FROM Trainees28
WHERE score = All (SELECT avg(score) FROM Deptdev);
					 
/*Correlated Query –
In Correlated Query,  Outer query executes first and for every Outer query row Inner query is executed. 
Hence, Inner query uses values from Outer query.*/

--Find details of customers who have ordered.(correlated subquery)
SELECT * FROM onlineCustomers where 
EXISTS (SELECT CustomerID FROM Orders 
WHERE Orders.CustomerID=onlineCustomers.CustomerID);

select * from deptdev;
SELECT EMPID,EMPNAME,DESIGNATION,SCORE
FROM DEPTDEV
WHERE EXISTS (SELECT EMPNAME FROM TRAINEES28
WHERE DEPTDEV.EMPID=TRAINEES28.EMPID AND SCORE>97);

select * from trainees28;


--SQL correlated subquery in the WHERE clause example
--The following query finds all employees whose score is higher than the average score of the employees in their departments

SELECT 
    *
FROM
    Trainees28 t
WHERE
    score > (SELECT 
            AVG(score)
        FROM
            Trainees28
        WHERE
            designation = t.designation) --correlated query
ORDER BY 
   designation,empid,empname;

SELECT 
    *
FROM
    Trainees28;