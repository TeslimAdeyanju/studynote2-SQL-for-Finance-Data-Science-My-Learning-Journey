 
--Average 
select 
avg(buyprice) as 'Average Price'
from products;

--
SELECT 
    AVG(buyprice) AS 'Avergae classic Car Price'
FROM 
    products
WHERE 
    productline = 'Classic Cars'
    
--

select avg(qty) as "production"
from inventory
where qty >50

--

select left(productDescription, 50)
from products

--

select count(buyprice), count(distinct buyprice)
from products

--

select format(avg(distinct buyprice), 2) as for_1, 
avg(distinct buyprice) as for_2,
round(avg(distinct buyprice),2) as for_3
from products

--

select 
productline as b, 
avg(buyprice) as 'average Price'
from products
group by b;

--

select 
productline as b, 
avg(buyprice) as average_Price
from products
group by b
having average_Price >50

--
SELECT 
    format(AVG(pl_avg),2) as final FROM (   
    SELECT
            format(AVG(buyprice), 2) AS pl_avg
        FROM 
            products
        GROUP BY 
            productline ) 
            AS AVG
 

--

select 
concat(customerName, '', contactLastName)
from customers

--

select format(avg(creditLimit),  2) as amount
from customers
group by state

--
select round(avg(creditLimit),  2) as amount
from customers
group by state


--
SELECT
    AVG(IF(productline = 'Classic Cars', buyprice, NULL)) / AVG(buyprice) 'Classic Cars/ Products'
FROM
    products;

--
select 
count(addressLine2)
from customers

--
select 
count(*)
from customers

--
--
select 
count(distinct addressLine2)
from customers

--

select city,
avg(creditlimit) as avr_amount,
count(*)
from customers
group by city

---
select 
group_concat(distinct title 
      order by title asc 
      separator ';') as lis
from t1

--
CREATE TABLE t (
    v CHAR
);

INSERT INTO t(v) VALUES('A'),('B'),('C'),('B');

SELECT 
    GROUP_CONCAT(DISTINCT v
        ORDER BY v ASC
        SEPARATOR ';')
FROM
    t;









































