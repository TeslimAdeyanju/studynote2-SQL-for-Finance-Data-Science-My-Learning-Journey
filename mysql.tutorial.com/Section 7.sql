-- 

SELECT
    firstName,
    lastName
FROM
    employees
UNION
SELECT
    contactFirstName,
    contactLastName
FROM
    customers;



    SELECT
    CONCAT(firstName,' ',lastName) fullname
FROM
    employees
UNION SELECT
    CONCAT(contactFirstName,' ',contactLastName)
FROM
    customers;


SELECT
    concat(firstName,' ',lastName) fullname
FROM
    employees
UNION SELECT
    concat(contactFirstName,' ',contactLastName)
FROM
    customers
ORDER BY fullname;




SELECT
    CONCAT(firstName, ' ', lastName) fullname,
    'Employee' as contactType
FROM
    employees
UNION SELECT
    CONCAT(contactFirstName, ' ', contactLastName),
    'Customer' as contactType
FROM
    customers
ORDER BY
    fullname


SELECT
    CONCAT(firstName,' ',lastName) fullname
FROM
    employees
UNION SELECT
    CONCAT(contactFirstName,' ',contactLastName)
FROM
    customers
ORDER BY 1;


SELECT
    firstName
FROM employees
EXCEPT
SELECT
    contactFirstName
FROM customers;



SELECT
    firstName
FROM employees
EXCEPT
SELECT
   contactFirstName
FROM customers
ORDER BY firstName;



SELECT
   firstName
FROM employees
EXCEPT ALL
SELECT
   contactFirstName
FROM customers
ORDER BY firstName;


SELECT
    firstName
FROM
    employees
INTERSECT
SELECT
    contactFirstname
FROM
    customers;


SELECT
    firstName
FROM
    employees
INTERSECT
SELECT
    contactFirstname
FROM
    customers
ORDER BY firstName;



SELECT
    firstName
FROM
    employees
INTERSECT ALL
SELECT
    contactFirstname
FROM
    customers
ORDER BY firstName;




select DATABASE()

show DATABASEs

use tysql

select *
from customers

use information_schema

select *
from tables

CREATE DATABASE eightco

select databases()


show create DATABASE eightco
EXIT

EXIT

DROP DATABASE eightco

DROP DATABASE TESTDB

SELECT DATABASE()

SHOW DATABASES



SELECT
  engine,
  support
FROM
  information_schema.engines
ORDER BY
  engine;

show ENGINES


SELECT
  engine,
    support
FROM
  tysql.engines
ORDER BY
  engine;


  CREATE TABLE TestTable AS
SELECT contactFirstName, contactLastName
FROM customers;

drop TestTable



SELECT
    firstName,
    lastName
FROM
    employees
UNION
SELECT
    contactFirstName,
    contactLastName
FROM
    customers;