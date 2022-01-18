--SQL | Numeric Functions
use dml;

SELECT ABS(-243.5) as abs; --absolute value
SELECT ACOS(0.25) as acos;
SELECT ASIN(0.25) as asin;
SELECT ATAN(2.5) as atan;
SELECT CEILING(25.75) as ceiling;
SELECT CEILING(25.05) as ceiling;
SELECT COS(30) as cos;
SELECT COT(6) as cot;
SELECT DEGREES(1.5) as degrees;--It converts a radian value into degrees.
SELECT DEGREES(PI()) as pidegree;
SELECT EXP(10) as exp;
SELECT FLOOR(25.99) as floor;
SELECT ROUND(235.414, 2) AS RoundValue;
SELECT SIGN(255.5);
SELECT SQUARE(4);
--RAND(seed)
--seed	Optional. If seed is specified, it returns a repeatable sequence of random numbers. 
--If no seed is specified, it returns a completely random number
SELECT RAND();--no seed value - so it returns a completely random number >= 0 and <1
SELECT RAND(6);
SELECT RAND()*(10-5+1)+5;--Return a random number >= 5 and <=10:
SELECT RAND()*(10-5)+5;--Return a random decimal number >= 5 and <10:
SELECT POWER(4, 2);

--String Functions
SELECT empname,ASCII(empname) AS NumCodeOfFirstChar FROM trainees28;

select ASCII('A');
select ASCII('a');

SELECT CHAR(65) AS CodeToCharacter;

SELECT CHARINDEX('t', 'Customer') AS MatchPosition;--CHARINDEX(substring, string, start)
SELECT CHARINDEX('OM', 'Customer') AS MatchPosition;
SELECT CHARINDEX('mer', 'Customer') AS MatchPosition;

select empname,charindex('a',empname) from trainees28;

SELECT CONCAT('Hello',' ','Trainees');
SELECT 'Welcome'+' '+'to'+' '+'CG VAK';

SELECT DATALENGTH('CG VAK');
SELECT empname,DATALENGTH(empname) from trainees28;

/*The DIFFERENCE() function compares two SOUNDEX values, and returns an integer.
The integer value indicates the match for the two SOUNDEX values, from 0 to 4.
0 indicates weak or no similarity between the SOUNDEX values.
4 indicates strong similarity or identically SOUNDEX values.*/

SELECT DIFFERENCE('Trainees', 'Trainees');

--Return a string with 10 spaces:
SELECT concat(customerid,space(2),'lives in',space(2),customercity) as Customers from onlinecustomers;

SELECT STR(185.476, 6, 2);--STR(number, length, decimals)
SELECT STR(185.5);

--The STUFF() function deletes a part of a string and then inserts another part into the string, starting at a specified position.
SELECT STUFF('Hello Trainees', 1, 5, 'Hi');--STUFF(string, start, length, new_string)
SELECT STUFF('Hi Trainees!', 12, 1, ' Welcome!!!');

--The SUBSTRING() function extracts some characters from a string.
SELECT SUBSTRING('Hello Trainees', 1, 5) AS ExtractString;--SUBSTRING(string, start, length)
SELECT designation,SUBSTRING(designation, 1, 3) AS ExtractString from Trainees28;

SELECT empname,UNICODE(empname) AS UnicodeOfFirstChar from Trainees28;
SELECT empname,UPPER(empname) AS UnicodeOfFirstChar from Trainees28;
SELECT empname,LOWER(empname) AS UnicodeOfFirstChar from Trainees28;

