
//CREATE TABLE//

DROP TABLE IF EXISTS students;

CREATE TABLE students (
    student_id INT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(100),
    enrollment_year INT NOT NULL,
    PRIMARY KEY(student_id)
);


DESCRIBE students;

--

Alter Table students
add phone_number VARCHAR(20) AFTER email


--

ALTER TABLE students
ADD address VARCHAR(255) AFTER phone_number,
ADD guardian_name VARCHAR(100) AFTER address;


---
ALTER TABLE students
MODIFY phone_number VARCHAR(30);

ALTER TABLE students
MODIFY guardian_name VARCHAR(100) FIRST;


--
ALTER TABLE students
MODIFY guardian_name varchar(50) NOT NULL,
MODIFY phone_number VARCHAR(11) NULL AFTER student_id;


--
ALTER TABLE students
CHANGE guardian_name emergency_contact VARCHAR(100);


--
Alter table students 
drop column address, 
drop column email


Describe students

--


RENAME TABLE students TO student_records;


Describe student_records

ALTER TABLE student_records
ADD COLUMN email VARCHAR(100)

ALTER TABLE student_records
ADD CONSTRAINT unique_email UNIQUE (email);


SHOW CREATE TABLE student_records


--

ALTER TABLE student_records
DROP INDEX unique_email;






// Module- TEMPORARY TABLES 

--Example 1

--create a temporary table 
CREATE TEMPORARY TABLE credits(
  customerNumber INT PRIMARY KEY, 
  creditLimit DEC(10, 2)
);


--insert into the temporary table 
INSERT INTO credits(customerNumber, creditLimit)
SELECT 
  customerNumber, 
  creditLimit 
FROM 
  customers 
WHERE 
  creditLimit > 0;

-- query from the temporary table 
SELECT * FROM credits;


-- Example 2

--create a temporary budget table 
CREATE TEMPORARY TABLE budget(
     productLine VARCHAR(50), 
     orderYear YEAR,
     orderValue DECIMAL(42,2)
     );

--insert into the budget table 
insert into budget(productLine, orderYear, orderValue)
     select productLine, 
            orderYear, 
            orderValue
     from sales; 
    
--  view the insert data 
select * from budget;        

-- view only the year from the data budget 
select orderyear
from budget;          
            
       
select * 
from sales
limit 10

            
            
            
            
            
         
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            














