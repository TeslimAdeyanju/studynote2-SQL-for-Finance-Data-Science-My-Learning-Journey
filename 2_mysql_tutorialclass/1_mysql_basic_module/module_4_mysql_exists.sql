-- Databe: classicmodel 


SELECT
    customerNumber,
    customerName
FROM
    customers
WHERE
    EXISTS(
     SELECT 1
  FROM orders
  WHERE orders.customernumber = customers.customernumber
  );

SELECT 
    orderNumber, 
    priceEach, 
    quantityOrdered
FROM 
    orderdetails
WHERE 
    EXISTS 
    (   SELECT 
            1 
        FROM 
            orders 
        WHERE 
            orders.orderNumber = orderdetails.orderNumber);
            
            
            
  select *
  from classicmodels.orders
  join classicmodels.orderdetails USING (orderNumber)
  limit 10;
  
  
  -- Example 
SELECT
    customerName as 'Customer Name',
    COUNT(orderNumber) AS 'order Count'
FROM
    customers
RIGHT JOIN
    orders 
ON 
    customers.customerNumber = orders.customerNumber
GROUP BY
    customerName;
    
    
 -- 
 
SELECT 
    customernumber, contactLastName,
    amount,
    paymentDate
FROM 
    classicmodels.customers
JOIN 
    classicmodels.payments 
USING 
    (customerNumber)
JOIN 
    classicmodels.orders 
USING 
    (customerNumber)
LIMIT 
    100;
    
    
 --    
SELECT
    amount,
    paymentDate, checknumber
FROM
    classicmodels.payments
WHERE 
    EXISTS 
    (   SELECT 
            1
        FROM 
            classicmodels.customers
        WHERE customers.customerNumber = payments.customerNumber);
        
        
        
 -- Example 
SELECT
    employeenumber,
    firstname,
    lastname,
    extension
FROM
    employees
WHERE
    EXISTS 
    (   SELECT
            1
        FROM
            offices
        WHERE
            city = 'San Francisco' 
        AND offices.officeCode = employees.officeCode);

    
 -- Example
SELECT 
    productName, 
    buyPrice, 
    productScale
FROM 
    classicmodels.products
WHERE 
    EXISTS 
    (   SELECT 
            1
        FROM 
            classicmodels.orderdetails
        WHERE 
            products.productCode = orderdetails.productCode)
        
    
    
    
    
    
    
    
    
    