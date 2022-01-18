/*The CHOOSE() function returns the item from a list of items at a specified index.

The following shows the syntax of the CHOOSE() function:

CHOOSE ( index, elem_1, elem_2 [, elem_n ] )*/

use dml;

--example 1
SELECT CHOOSE(2, 'First', 'Second', 'Third') Result;

--example 2
select * from orders;

SELECT orderid,orderdate,
      CHOOSE(MONTH([orderdate]),'January','February','March','April','May','June',
      'July','August','September','October','November','December') AS ordermonth
  FROM orders;

--example 3
SELECT CHOOSE(1, 'Apple', 'Orange', 'Kiwi', 'Cherry') AS Result1;

SELECT CHOOSE(2, 'Apple', 'Orange', 'Kiwi', 'Cherry') AS Result2;

SELECT CHOOSE(3, 'Apple', 'Orange', 'Kiwi', 'Cherry') AS Result3;

SELECT CHOOSE(4, 'Apple', 'Orange', 'Kiwi', 'Cherry') AS Result4;

SELECT CHOOSE(5, 'Apple', 'Orange', 'Kiwi', 'Cherry','Strawberry') AS Result5;

SELECT CHOOSE(6, 'Apple', 'Orange', 'Kiwi', 'Cherry','Strawberry') AS Result5;


/*The SQL CASE Statement
The CASE statement goes through conditions and returns a value when the first condition is met (like an if-then-else statement). 
So, once a condition is true, it will stop reading and return the result. 
If no conditions are true, it returns the value in the ELSE clause.
If there is no ELSE part and no conditions are true, it returns NULL.*/

/*Types of CASE Statement
There are two forms of CASE statement in MS SQL Server:

Simple CASE Statement
Searched CASE Statement*/

--Example
use dml;

--simple
SELECT empid,empname,designation, 
CASE designation 
    WHEN 'Developer' THEN 'CGVAK DEVELOPER DEPARTMENT'  
    WHEN 'Designer' THEN 'CGVAK DESIGNER DEPARTMENT'  
    WHEN 'HR' THEN 'CGVAK HR DEPARTMENT'  
    ELSE 'CGVAK TESTER DEPARTMENT'  
END AS Department  
FROM Trainees28;  

--searched
SELECT empid,empname,score,
CASE
    WHEN score = 98 THEN 'Excellent'
    WHEN score = 97 THEN 'Good'
    ELSE 'Average'
END AS Remarks
FROM Trainees28;
