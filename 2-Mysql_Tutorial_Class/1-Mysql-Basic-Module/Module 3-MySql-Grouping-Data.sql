select count(*)
from offices;

select count(email) as mail 
from employees;

SELECT COUNT(DISTINCT officeCode) AS total_department
FROM employees;


select status
from orders;


-- applying group
select status,
from orders
group by status;




-- same as distinct 

select distinct status
from orders;


--
select status, count(*)
from orders
group by status;


---Uisng join with group 
select status, sum(quantityOrdered * priceEach) as Total_Amount
from orders 
join orderdetails 
using(ordernumber)
group by 1

--- select info withing the same group 
SELECT 
  orderNumber, 
  SUM(quantityOrdered * priceEach) AS total 
FROM 
  orderdetails 
GROUP BY 
  orderNumber

-- using example 
SELECT
    year(orderdate) as order_date,
    SUM(quantityOrdered * priceEach) AS Total_Amount
FROM
    orders
INNER JOIN
    orderdetails
USING
    (orderNumber)
WHERE
    status = 'Shipped'
GROUP BY
    year(orderdate)

--

select month(orderdate) as month
from orders
group by month(orderdate)

--

SELECT 
    MONTH(paymentdate) AS active_month, 
    AVG(amount) AS average_income
FROM 
    payments
GROUP BY 
    active_month
ORDER BY 
    active_month

--
SELECT
    count(customerNumber) as Total_Amount,
    month(orderNumber) as month
FROM
    orders
GROUP BY
    month(orderNumber)






























