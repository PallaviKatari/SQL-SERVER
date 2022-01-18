--JOINS
--A JOIN clause is used to combine rows from two or more tables, 
--based on a related column between them.

/*(INNER) JOIN: Returns records that have matching values in both tables
LEFT (OUTER) JOIN: Returns all records from the left table, and the matched records from the right table
RIGHT (OUTER) JOIN: Returns all records from the right table, and the matched records from the left table
FULL (OUTER) JOIN: Returns all records when there is a match in either left or right table*/
USE DML;

CREATE TABLE onlinecustomers (customerid INT PRIMARY KEY IDENTITY(1,1) ,CustomerName VARCHAR(100) 
,CustomerCity VARCHAR(100) ,Customermail VARCHAR(100))
GO
CREATE TABLE orders (orderId INT PRIMARY KEY IDENTITY(1,1) , customerid INT  ,
ordertotal float ,discountrate float ,orderdate DATETIME)
GO
CREATE TABLE sales (salesId INT PRIMARY KEY IDENTITY(1,1) , 
orderId INT  ,
salestotal FLOAT)
GO

--INSERT COMMAND
INSERT INTO [dbo].[onlinecustomers]([CustomerName],[CustomerCity],[Customermail]) VALUES (N'Salvador',N'Philadelphia',N'tyiptqo.wethls@chttw.org')
INSERT INTO [dbo].[onlinecustomers]([CustomerName],[CustomerCity],[Customermail]) VALUES (N'Gilbert',N'San Diego',N'rrvyy.wdumos@lklkj.org')
INSERT INTO [dbo].[onlinecustomers]([CustomerName],[CustomerCity],[Customermail]) VALUES (N'Ernest',N'New York',N'ymuea.pnxkukf@dwv.org')
INSERT INTO [dbo].[onlinecustomers]([CustomerName],[CustomerCity],[Customermail]) VALUES (N'Stella',N'Phoenix',N'xvsfzp.rjhtni@rdn.com')
INSERT INTO [dbo].[onlinecustomers]([CustomerName],[CustomerCity],[Customermail]) VALUES (N'Jorge',N'Los Angeles',N'oykbo.vlxopp@nmwhv.org')
INSERT INTO [dbo].[onlinecustomers]([CustomerName],[CustomerCity],[Customermail]) VALUES (N'Jerome',N'San Antonio',N'wkabc.ofmhetq@gtmh.co')
INSERT INTO [dbo].[onlinecustomers]([CustomerName],[CustomerCity],[Customermail]) VALUES (N'Edward',N'Chicago',N'wguexiymy.nnbdgpc@juc.co')
 
GO

INSERT INTO [dbo].[orders]([customerid],[ordertotal],[discountrate],[orderdate]) VALUES (3,1910.64,5.49,CAST('03-Dec-2019' AS DATETIME))
INSERT INTO [dbo].[orders]([customerid],[ordertotal],[discountrate],[orderdate]) VALUES (4,150.89,15.33,CAST('11-Jun-2019' AS DATETIME))
INSERT INTO [dbo].[orders]([customerid],[ordertotal],[discountrate],[orderdate]) VALUES (5,912.55,13.74,CAST('15-Sep-2019' AS DATETIME))
INSERT INTO [dbo].[orders]([customerid],[ordertotal],[discountrate],[orderdate]) VALUES (7,418.24,14.53,CAST('28-May-2019' AS DATETIME))
INSERT INTO [dbo].[orders]([customerid],[ordertotal],[discountrate],[orderdate]) VALUES (55,512.55,13.74,CAST('15-Jun-2019' AS DATETIME))
INSERT INTO [dbo].[orders]([customerid],[ordertotal],[discountrate],[orderdate]) VALUES (57,118.24,14.53,CAST('28-Dec-2019' AS DATETIME))
GO

INSERT INTO [dbo].[sales]([orderId],[salestotal]) VALUES (3,370.95)
INSERT INTO [dbo].[sales]([orderId],[salestotal]) VALUES (4,882.13)
INSERT INTO [dbo].[sales]([orderId],[salestotal]) VALUES (28,370.95)
INSERT INTO [dbo].[sales]([orderId],[salestotal]) VALUES (13,882.13)
INSERT INTO [dbo].[sales]([orderId],[salestotal]) VALUES (55,170.95)
INSERT INTO [dbo].[sales]([orderId],[salestotal]) VALUES (57,382.13)
INSERT INTO [dbo].[sales]([orderId],[salestotal]) VALUES (25,190.95)
INSERT INTO [dbo].[sales]([orderId],[salestotal]) VALUES (27,382.13)
GO

--SELECT
select * from onlinecustomers;

select * from orders;

select * from sales;

--INNER JOIN 2 TABLES
SELECT OC.CUSTOMERID,customerName, customercity, customermail
FROM onlinecustomers AS oc
   INNER JOIN
   orders AS o
   ON oc.customerid = o.customerid

SELECT onlinecustomers.CUSTOMERID,customerName, customercity, customermail
FROM onlinecustomers
   INNER JOIN
   orders
   ON onlinecustomers.customerid = orders.customerid

--INNER JOIN 3 TABLES
SELECT OC.CUSTOMERID,customerName, customercity, customermail, salestotal,o.orderid
FROM onlinecustomers AS oc
   INNER JOIN
   orders AS o
   ON oc.customerid = o.customerid
   INNER JOIN
   sales AS s
   ON o.orderId = s.orderId;

--LEFT JOIN 2 TABLES
SELECT OC.CUSTOMERID,customerName, customercity, customermail,orderid,orderdate
FROM onlinecustomers AS oc
   LEFT JOIN
   orders AS o
   ON oc.customerid = o.customerid

--RIGHT JOIN 2 TABLES
SELECT OC.CUSTOMERID,customerName, customercity, customermail,orderid
FROM onlinecustomers AS oc
   RIGHT JOIN
   orders AS o
   ON oc.customerid = o.customerid

--FULL JOIN 2 TABLES
SELECT OC.CUSTOMERID,customerName, customercity, customermail,orderid
FROM onlinecustomers AS oc
   FULL JOIN
   orders AS o
   ON oc.customerid = o.customerid

--FULL JOIN 3 TABLES
SELECT customerName, customercity, customermail, ordertotal,salestotal
FROM onlinecustomers AS c
   FULL JOIN
   orders AS o
   ON c.customerid = o.customerid
   FULL JOIN
   sales AS s
   ON o.orderId = s.orderId


 