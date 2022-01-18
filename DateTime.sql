USE DML;

--DATE FUNCTIONS
/*
SQL Server SYSDATETIME, SYSDATETIMEOFFSET and SYSUTCDATETIME Functions
SQL Server High Precision Date and Time Functions have a scale of 7 and are:

SYSDATETIME – returns the date and time of the machine the SQL Server is running on
SYSDATETIMEOFFSET – returns the date and time of the machine the SQL Server is running on plus the offset from UTC
SYSUTCDATETIME - returns the date and time of the machine the SQL Server is running on as UTC*/

-- higher precision functions 
SELECT SYSDATETIME()       AS 'DateAndTime';        -- return datetime2(7)       
SELECT SYSDATETIMEOFFSET() AS 'DateAndTime+Offset'; -- datetimeoffset(7)
SELECT SYSUTCDATETIME()    AS 'DateAndTimeInUtc';   -- returns datetime2(7)

/*SQL Server CURRENT_TIMESTAMP, GETDATE() and GETUTCDATE() Functions
SQL Server Lesser Precision Data and Time Functions have a scale of 3 and are:

CURRENT_TIMESTAMP - returns the date and time of the machine the SQL Server is running on
GETDATE() - returns the date and time of the machine the SQL Server is running on
GETUTCDATE() - returns the date and time of the machine the SQL Server is running on as UTC*/

-- lesser precision functions - returns datetime
SELECT CURRENT_TIMESTAMP AS 'DateAndTime'; -- note: no parentheses   
SELECT GETDATE()         AS 'DateAndTime';    
SELECT GETUTCDATE()      AS 'DateAndTimeUtc'; 

/*SQL Server DATENAME Function
DATENAME – Returns a string corresponding to the datepart specified for the given date*/
-- date and time parts - returns nvarchar 
SELECT DATENAME(YEAR, GETDATE())        AS 'Year';        
SELECT DATENAME(QUARTER, GETDATE())     AS 'Quarter';     
SELECT DATENAME(MONTH, GETDATE())       AS 'Month Name';       
SELECT DATENAME(DAYOFYEAR, GETDATE())   AS 'DayOfYear';   
SELECT DATENAME(DAY, GETDATE())         AS 'Day';         
SELECT DATENAME(WEEK, GETDATE())        AS 'Week';        
SELECT DATENAME(WEEKDAY, GETDATE())     AS 'Day of the Week';     
SELECT DATENAME(HOUR, GETDATE())        AS 'Hour';        
SELECT DATENAME(MINUTE, GETDATE())      AS 'Minute';      
SELECT DATENAME(SECOND, GETDATE())      AS 'Second';      
SELECT DATENAME(MILLISECOND, GETDATE()) AS 'MilliSecond'; 
SELECT DATENAME(MICROSECOND, GETDATE()) AS 'MicroSecond'; 
SELECT DATENAME(NANOSECOND, GETDATE())  AS 'NanoSecond';  
SELECT DATENAME(ISO_WEEK, GETDATE())    AS 'Week';    

/*SQL Server DATEPART Function
DATEPART – returns an integer corresponding to the datepart specified*/

-- date and time parts - returns int
SELECT DATEPART(YEAR, GETDATE())        AS 'Year';        
SELECT DATEPART(QUARTER, GETDATE())     AS 'Quarter';     
SELECT DATEPART(MONTH, GETDATE())       AS 'Month';       
SELECT DATEPART(DAYOFYEAR, GETDATE())   AS 'DayOfYear';   
SELECT DATEPART(DAY, GETDATE())         AS 'Day';         
SELECT DATEPART(WEEK, GETDATE())        AS 'Week';        
SELECT DATEPART(WEEKDAY, GETDATE())     AS 'WeekDay';     
SELECT DATEPART(HOUR, GETDATE())        AS 'Hour';        
SELECT DATEPART(MINUTE, GETDATE())      AS 'Minute';      
SELECT DATEPART(SECOND, GETDATE())      AS 'Second';      
SELECT DATEPART(MILLISECOND, GETDATE()) AS 'MilliSecond'; 
SELECT DATEPART(MICROSECOND, GETDATE()) AS 'MicroSecond'; 
SELECT DATEPART(NANOSECOND, GETDATE())  AS 'NanoSecond';  
SELECT DATEPART(ISO_WEEK, GETDATE())    AS 'Week'; 

/*SQL Server DAY, MONTH and YEAR Functions
DAY – returns an integer corresponding to the day specified
MONTH– returns an integer corresponding to the month specified
YEAR– returns an integer corresponding to the year specified*/

SELECT DAY(GETDATE())   AS 'Day';                            
SELECT MONTH(GETDATE()) AS 'Month';                       
SELECT YEAR(GETDATE())  AS 'Year';  

/*SQL Server DATEFROMPARTS, DATETIME2FROMPARTS, DATETIMEFROMPARTS, DATETIMEOFFSETFROMPARTS, SMALLDATETIMEFROMPARTS and  TIMEFROMPARTS Functions
DATEFROMPARTS – returns a date from the date specified
DATETIME2FROMPARTS – returns a datetime2 from part specified
DATETIMEFROMPARTS – returns a datetime from part specified
DATETIMEOFFSETFROMPARTS - returns a datetimeoffset from part specified
SMALLDATETIMEFROMPARTS - returns a smalldatetime from part specified
TIMEFROMPARTS - returns a time from part specified*/

-- date and time from parts
SELECT DATEFROMPARTS(2019,1,1)                         AS 'Date';          -- returns date
SELECT DATETIME2FROMPARTS(2019,1,1,6,0,0,0,1)          AS 'DateTime2';     -- returns datetime2
SELECT DATETIMEFROMPARTS(2019,1,1,6,0,0,0)             AS 'DateTime';      -- returns datetime
SELECT DATETIMEOFFSETFROMPARTS(2019,1,1,6,0,0,0,0,0,0) AS 'Offset';        -- returns datetimeoffset
SELECT SMALLDATETIMEFROMPARTS(2019,1,1,6,0)            AS 'SmallDateTime'; -- returns smalldatetime
SELECT TIMEFROMPARTS(6,0,0,0,0)                        AS 'Time';          -- returns time

/*SQL Server DATEDIFF and DATEDIFF_BIG Functions
DATEDIFF - returns the number of date or time datepart boundaries crossed between specified dates as an int
DATEDIFF_BIG - returns the number of date or time datepart boundaries crossed between specified dates as a bigint*/

--Date and Time Difference
SELECT DATEDIFF(DAY, 2021-13-09, 2021-03-08)      AS 'DateDif'    -- returns int
SELECT DATEDIFF_BIG(DAY, 2021-13-09, 2021-03-08)  AS 'DateDifBig' -- returns bigint

/*SQL Server DATEADD, EOMONTH, SWITCHOFFSET and TODATETIMEOFFSET Functions
DATEADD - returns datepart with added interval as a datetime
EOMONTH – returns last day of month of offset as type of start_date
SWITCHOFFSET - returns date and time offset and time zone offset
TODATETIMEOFFSET - returns date and time with time zone offset*/

-- modify date and time
SELECT DATEADD(DAY,1,GETDATE())        AS 'DatePlus1';          -- returns data type of the date argument
SELECT EOMONTH(GETDATE(),2)            AS 'LastDayOfNextMonth'; -- returns start_date argument or date

--The following example uses SWITCHOFFSET to display a different time zone offset than the value stored in the database.
CREATE TABLE dbo.test   
    (  
    ColDatetimeoffset datetimeoffset  
    );  
GO  
INSERT INTO dbo.test   
VALUES ('1998-09-20 7:45:50.71345 -5:00');  
GO  
SELECT SWITCHOFFSET (ColDatetimeoffset, '-08:00')   
FROM dbo.test;  --temporary retrieval
GO  
--Returns: 1998-09-20 04:45:50.7134500 -08:00  
SELECT ColDatetimeoffset  
FROM dbo.test;  
--Returns: 1998-09-20 07:45:50.7134500 -05:00  
 
SELECT
    TODATETIMEOFFSET (
        '2019-03-06 07:43:58',
        '-08:00'
    ) result;

SELECT SYSDATETIME() AS [SYSDATETIME()]  ,SYSDATETIMEOFFSET() AS [SYSDATETIMEOFFSET()]  

--CONVERT
SELECT CONVERT (date, SYSDATETIME())  
    ,CONVERT (date, SYSDATETIMEOFFSET())  
    ,CONVERT (date, SYSUTCDATETIME())  
    ,CONVERT (date, CURRENT_TIMESTAMP)  
    ,CONVERT (date, GETDATE())  
    ,CONVERT (date, GETUTCDATE());  

SELECT CONVERT (time, SYSDATETIME()) AS [SYSDATETIME()]  
    ,CONVERT (time, SYSDATETIMEOFFSET()) AS [SYSDATETIMEOFFSET()]  
    ,CONVERT (time, SYSUTCDATETIME()) AS [SYSUTCDATETIME()]  
    ,CONVERT (time, CURRENT_TIMESTAMP) AS [CURRENT_TIMESTAMP]  
    ,CONVERT (time, GETDATE()) AS [GETDATE()]  
    ,CONVERT (time, GETUTCDATE()) AS [GETUTCDATE()]; 

	/*SQL Server ISDATE Function to Validate Date and Time Values
ISDATE – returns int - Returns 1 if a valid datetime type and 0 if not*/

-- validate date and time - returns int
SELECT ISDATE(GETDATE()) AS 'IsDate'; 
SELECT ISDATE(NULL) AS 'IsDate';

--DATEADD (date_part , value , input_date ) 
SELECT DATEADD(second, 1, '2018-12-31 23:59:59') result;
SELECT DATEADD(day, 1, '2018-12-31 23:59:59') result;

select * from orders;
SELECT 
    orderid, 
    customerid, 
    orderdate,
    DATEADD(day, 2, orderdate) estimated_shipped_date
FROM 
    orders;

SELECT DATEADD(month, 4, '2019-05-31') AS result;
