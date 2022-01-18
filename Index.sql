use dml;

/*SQL indexes
An index is a schema object. 
It is used by the server to speed up the retrieval of rows by using a pointer. 
It can reduce disk I/O(input/output) by using a rapid path access method to locate data quickly. 
An index helps to speed up select queries and where clauses, but it slows down data input, with the update and the insert statements. 
Indexes can be created or dropped with no effect on the data. 

For example, if you want to reference all pages in a book that discusses a certain topic, 
you first refer to the index, which lists all the topics alphabetically and 
is then referred to one or more specific page numbers. */

--CREATE INDEX index ON TABLE column;

-- CREATE INDEX index ON TABLE (column1, column2,.....); --For multiple columns

--CREATE UNIQUE INDEX index ON TABLE column;
--Unique indexes are used for the maintenance of the integrity of the data present 
--in the table as well as for the fast performance, 
--it does not allow multiple values to enter into the table. 

/*When should indexes be created – 
 

A column contains a wide range of values
A column does not contain a large number of null values
One or more columns are frequently used together in a where clause or a join condition

When should indexes be avoided – 
 
The table is small
The columns are not often used as a condition in the query
The column is updated frequently*/


--DROP INDEX index; --drop/delete index

--ALTER INDEX IndexName ON TableName REBUILD; --modify

--select * from USER_INDEXES;  --confirming the index

--EXEC sp_rename  index_name, new_index_name,  N'INDEX'; 

/*Types of indexes in SQL Server
SQL Server Indexes are divided into two types. They are as follows:

Clustered index
Non- clustered index*/

/*The Clustered Index in SQL Server defines the order in which the data is physically stored in a table. 
In the case of a clustered index,  the leaf node store the actual data. 
As the leaf nodes store the actual data a table can have only one clustered index. 
The Clustered Index by default was created when we created the primary key constraint for that table. 
That means the primary key column creates a clustered index by default.
When a table has a clustered index then that table is called a clustered table.
 If a table has no clustered index its data rows are stored in an unordered structure.*/

 /*In SQL Server Non-Clustered Index, the arrangement of data in the index table will be different from the arrangement of data in the actual table. 
 The data is stored in one place and the index is stored in another place. 
 Moreover, the index will have pointers to the storage location of the actual data.*/
 use dml;
 select * from trainees28; --display execution or ctrl+L
 --You will not find any performance issues currently as the number of records is less. 
 --But if your table contains a huge amount of data let say 1000000 records, then it will definitely take much more time to get the data.

 CREATE CLUSTERED INDEX IX_Employee_ID ON Toppers(empid ASC);

 select * from Toppers where empid=1;

 --Creating a non-clustered index is basically the same as creating clustered index, but instead of specifying the CLUSTERED clause we specify NONCLUSTERED.
 --We can also omit this clause altogether as a non-clustered is the default when creating an index. 

 CREATE INDEX idx_score ON Trainees28 (score);

 select score from trainees28;

 --DROP INDEX table_name.index_name;
 drop index Toppers.IX_Employee_ID;

EXEC sp_helpindex 'Trainees28'
GO

SELECT
 name AS Index_Name,
 type_desc  As Index_Type,
 is_unique,
 OBJECT_NAME(object_id) As Table_Name
FROM
 sys.indexes
WHERE
 object_id = OBJECT_ID('Trainees28');
GO

--INNER JOIN 3 TABLES (ctrl+L) Excecution plan
SELECT OC.CUSTOMERID,customerName, customercity, customermail, salestotal,o.orderid
FROM onlinecustomers AS oc
   INNER JOIN
   orders AS o
   ON oc.customerid = o.customerid
   INNER JOIN
   sales AS s
   ON o.orderId = s.orderId;

--A filtered index is created simply by adding a WHERE clause to any non-clustered index creation statement.

CREATE NONCLUSTERED INDEX IX_Trainee28_DesTest ON Trainees28 (designation) WHERE designation='Tester';

select designation from trainees28 WHERE designation='Tester';