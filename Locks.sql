/*As it is meeting  Atomicity(A), Consistency(C), Isolation(I), and Durability(D) requirements it is called a relational database. 
In order to maintain ACID mechanisms, in SQL Server, a lock is maintained. */

/*Locks in SQL Server
The lock is a mechanism associated with a table for restricting unauthorized access to the data. It is mainly used to solve the concurrency problem in transactions.
We can apply a lock on row level, database level, table level, and page level.

We know that multiple users can access databases at the same time. As a result, locking is essential for a successful transaction and protects data from being corrupted or invalidated when several users attempt to read, write, or update a database.
Usually, the lock is an in-memory structure with owners, types, and the hash of the resource they are supposed to protect.
As an in-memory structure, the size of a lock is 96 bytes.

It is better to understand that "A lock is designed to ensure data integrity and consistency while enabling concurrent data access, 
as it forces each transaction to pass the ACID test. When several users access a database to alter its data at the same time, 
it implements concurrency control."

Lock Modes
Lock mode is used to prevent other people to reads or change the locked resource. It can be categorized into the following six types listed below:

Exclusive Lock (X)
Shared Lock (S)
Update Lock (U)
Intent Lock (I)
Schema Lock (Sch)
Bulk Update Lock (BU)

1)Exclusive locks

The exclusive locks are useful in DML operations like INSERT, UPDATE, or DELETE statements. 
This lock, when imposed on a transaction, prevents other persons from accessing the locked resources. 
It means that an exclusive lock can hold only one transaction on a resource at the same time. 
The user of this lock is known as a writer. 

2)Shared Locks

Once the shared locks are applied on the page or row, they will be reserved for reading-only purposes. 
It implies that no other transaction can alter the locked resource as long as the lock is active. 
As the name implies, several transactions can hold this lock on the same resource simultaneously. 
The user of this lock is known as a reader. 

3)Update Locks

The update lock is the same as an exclusive lock, but it is designed to be more adaptable. 
A transaction that already holds a shared lock can be given an update lock. 
In such cases, the update lock can hold another shared lock on the target page or row. 
This lock can be changed to an exclusive lock whenever the transaction that has the update lock is going to alter the data. 

4)Intent Locks

The intent lock is a way for a transaction to inform other transactions about its intention to acquire a lock. 
This lock aims to prevent another transaction from getting a lock on the next object in the hierarchy, ensuring that data modifications are appropriately performed. 
It indicates that this lock is used to create a lock hierarchy. 
It's an important type of lock in the performance aspect. 
It can be divided into three types:

Intent shared (IS): If a page or row holds this lock, then the transaction intends to read resources in the lower hierarchy by obtaining shared locks (S) on those resources independently.
Intent exclusive (IX): If a page or row holds this lock, the transaction intends to change some lower hierarchy resources by obtaining exclusive (X) locks on those resources independently.
Intent update (IU): This lock can only be obtained at the page level, and it transforms to the intent exclusive lock when the update operation is completed.

5)Schema Locks

Schema lock is used in the SQL Server when an operation that depends on the schema of a table is executed. 
It can be divided into two types:

Schema modification (Sch-M): It is used when a DDL statement executes and prevents access to the locked object data while the object's structure is altered.
Schema stability (Sch-S): It is used when a schema-dependent query is compiled and executed as well as generates the execution plan.

6)Bulk Update Locks

This lock is used to copy bulk data into a table by specifying the TABLOCK hint. 
The user generally uses it when he wants to insert a large amount of data into the database.*/

use dml;
--LOCKS EXAMPLE 1
--Step 1
create table demo
(
id int primary key,
name varchar(25),
age int,
department varchar(25)
);

--Step 2
--one row with NULL values
insert into demo(id,name,age,department)values(1,'Paru',21,'IT');
insert into demo(id,name)values(2,'Tharu');

select * from demo;
--Step 3
BEGIN TRAN  
UPDATE demo SET age=20,department='HR' where Id=2; 
SELECT @@SPID AS session_id  
commit


--Step 4
--Now, we will execute the below command to check the sys.dm_tran_lock view:

SELECT * FROM sys.dm_tran_locks; 

--LOCKS EXAMPLE 2
select * from demo;
SET DEADLOCK_PRIORITY low
BEGIN TRANSACTION updatedemo
	UPDATE demo set age=21 where id=2;
	commit TRANSACTION updatedemo

--You will notice that the above transaction doesn’t have a corresponding 
--COMMIT TRANSACTION updatedemo, which means that the changes we’ve just made haven’t been committed to disk yet. 
--Thus, if another database user were to attempt to read the value of empid=2 of demo table , they would receive an endless Executing query … message.

--open sql server in another window and execute the below query
	select * from demo;

	
--Well, what is happening here is that as part of retrieving empid=2 of demo table, 
--the query used in the other window should firstly acquire a shared lock against the demo table,
--but it ends up having to wait for query to complete its changes first.

select * from demo [NOLOCK]--EXECUTE IN OTHER WINDOW OR BY ANOTHER USER

--ROWLOCK EXAMPLE other levels (tablock and paglock)
--Transaction 1
BEGIN TRAN

   UPDATE demo WITH (ROWLOCK)
   SET  department= 'HR'
   WHERE id=1
COMMIT TRAN
--Transaction 2 in another user instance

BEGIN TRAN

   UPDATE demo 
   SET  department= 'Tester'
   WHERE id=1
COMMIT TRAN



grant select,update,delete on demo to g2;
--ROWLOCK does prevent two users from modifying the same row, 
--but it does not, however, prevent two users from locking that same row.

--XLOCK, ROWLOCK
BEGIN TRANSACTION;

SELECT id,name
FROM demo
WITH(XLOCK, ROWLOCK)
WHERE age > 21 ;

UPDATE demo SET age= 21;

COMMIT TRANSACTION;

select * from demo;

/*
Each transaction starts in specific transaction isolation level. 
There are 4 “pessimistic” isolation levels: Read uncommitted, read committed, repeatable read and serializable 
and 2 “optimisitic” isolation levels: Snapshot and read committed snapshot. 
With pessimistic isolation levels writers always block writers and typically block readers (with exception of read uncommitted isolation level). 
With optimistic isolation level writers don’t block readers and in snapshot isolation level does not block writers (there will be the conflict if 2 sessions are updating the same row). 

Regardless of isolation level, exclusive lock (data modification) always held till end of transaction. 
The difference in behavior is how SQL Server handles shared locks below:

In read uncommitted mode, shared locks are not acquired – as result, readers (select) statement can read data modified by other uncommitted transactions even when those rows held (X) locks. 
As result any side effects possible. Obviously it affects (S) lock behavior only. 
Writers still block each other.In any other isolation level (S) locks are acquired and session is blocked when it tries to read uncommitted row with (X) lock. 

In read committed mode (S) locks are acquired and released immediately.

In Repeatable read mode, (S) locks are acquired and held till end of transaction. 
So it prevents other session to modify data once read. 

Serializable isolation level works similarly to repeatable read with exception that locks are acquired on the range of the rows. 
It prevents other session to insert other data in-between once data is read.

You can control that locking behavior with “set transaction isolation level” statement – if you want to do it in transaction/statement scope or on the table level with table hints. 
So it’s possible to have the statement like that:

TABLE HINTS:
read committed mode-NOLOCK
read committed mode-READCOMMITED
Repeatable read mode-REPEATABLEREAD
Serializable-HOLDLOCK
*/


--REFER --http://rdbmsql.com/types-locking-in-sql-server/ 



