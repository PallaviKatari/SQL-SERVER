use g2;
select * from trainees28;
/*RANK Function in SQL Server
The RANK Function in SQL Server is a kind of Ranking Function. This function will assign the number to each row within the partition of an output. It assigns the rank to each row as one plus the previous row rank. When the RANK function finds two values that are identical within the same partition, it assigns them with the same rank number. In addition, the next number in the ranking will be the previous rank plus duplicate numbers. Therefore, this function does not always assign the ranking of rows in consecutive order.

The RANK function is also a sub-part of window functions. The following points should be remembered while using this function:

It always works with the OVER() clause.
It assigns a rank to each row based on the ORDER BY clause.
It assigns a rank to each row in consecutive order.
It always assigns a rank to rows, starting with one for each new partition.*/

--RANK() Function
--This function is used to determine the rank for each row in the result set.

SELECT empid,empname,designation,score,
RANK () OVER (ORDER BY score desc) AS Rank_No   
FROM trainees28;  

SELECT empid,empname,designation,score,
RANK () OVER (ORDER BY score desc) AS Rank_No   
FROM deptdev;  

--PARTITION BY CLAUSE

SELECT empid,empname,designation,score,
RANK () OVER (partition by designation ORDER BY score desc) AS Rank_No   
FROM trainees28;  

/*In the above example
The OVER clause sets the partitioning and ordering of a result before the associated window function is applied.
The PARTITION BY clause divides the output produces by the FROM clause into the partition. 
Then the function is applied to each partition and re-initialized when the division border crosses partitions. 
If we have not defined this clause, the function will treat all rows as a single partition.
The ORDER BY is a required clause that determines the order of the rows in a descending or ascending manner
 based on one or more column names before the function is applied.*/

 /*ROW_NUMBER() Function
This function is used to return the unique sequential number for each row within its partition. 
The row numbering begins at one and increases by one until the partition's total number of rows is reached.
It will return the different ranks for the row having similar values that make it different from the RANK() function.*/

SELECT empid,empname,designation,score,
ROW_NUMBER() OVER (ORDER BY score desc) AS Rank_No   
FROM trainees28; 

SELECT empid,empname,designation,score,
ROW_NUMBER() OVER (partition by designation ORDER BY score desc) AS Rank_No   
FROM trainees28;

/*DENSE_RANK() Function
This function assigns a unique rank for each row within a partition as per the specified column value without any gaps. 
It always specifies ranking in consecutive order. 
If we get a duplicate value, this function will assign it with the same rank, and the next rank being the next sequential number.
This characteristic differs DENSE_RANK() function from the RANK() function. */

SELECT empid,empname,designation,score,
DENSE_RANK() OVER (ORDER BY score desc) AS Rank_No   
FROM trainees28; 

SELECT empid,empname,designation,score,
DENSE_RANK() OVER (partition by designation ORDER BY score desc) AS Rank_No   
FROM trainees28; 

/*NTILE(N) Function
This function is used to distribute rows of an ordered partition into a pre-defined number (N) of approximately equal groups. 
Each row group gets its rank based on the defined condition and starts numbering from one group. 
It assigns a bucket number for every row in a group representing the group to which it belongs.*/

SELECT empid,empname,designation,score,
NTILE(3) OVER (ORDER BY score desc) AS Rank_No   
FROM trainees28;

SELECT empid,empname,designation,score,
NTILE(2) OVER (ORDER BY score desc) AS Rank_No   
FROM trainees28;

SELECT empid,empname,designation,score,
NTILE(2) OVER (partition by designation ORDER BY score desc) AS Rank_No   
FROM trainees28;
