
select *
from customers;

--
SELECT
    customerName,
    contactLastName,
    city,
    state,
    ROW_NUMBER() OVER (PARTITION BY state ORDER BY city) AS row_num
FROM
    customers
WHERE state IS NOT NULL;

--

select *,
ROW_NUMBER() over() as count_number
from payments;

--

select officecode, city, state,
row_number() over(order by city) as row_n
from offices
order by city;

--
select 
      id,
      item_no,
      LAG(id) over() as previous
from inventory;
       
---
select 
     city,
     state,
     country,
     lag(country) over() as previous_n
from offices
where state is not Null;


---
WITH product_category as(
     select productline, count(productline) as line
     from products
     group by productline
)
select line, row_number() over(order by productline desc) as row_n 
from product_category
order by line desc

--



