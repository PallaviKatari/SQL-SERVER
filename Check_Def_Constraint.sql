use Trainees28;
--Emp Table
--CHECK AND DEFAULT CONSTRAINT
CREATE TABLE Emp
( 
    Emp_id       INT NOT NULL CHECK(Emp_id BETWEEN 0 AND 1000), 
    Emp_name     VARCHAR(30) NOT NULL, 
    Entered_date DATETIME NOT NULL CHECK(Entered_date <= CURRENT_TIMESTAMP), 
    Dept_no      INT CHECK(Dept_no> 0) ,
	City varchar(255) DEFAULT 'Coimbatore'
) ;
INSERT INTO Emp
            (Emp_id, 
             Emp_name, 
             Entered_date, 
             Dept_no
			 ) 
VALUES      (1, 
             'Nevetha', 
             '2018-04-28 12:18:46.813', 
             10) -- Allowed 
INSERT INTO Emp 
            (Emp_id, 
             Emp_name, 
             Entered_date, 
             Dept_no) 
VALUES      (100, 
             'Nivi', 
             '2018-04-28 12:18:46.813', 
             200) --Not Allowed

			 select * from Emp;

			 drop table emp