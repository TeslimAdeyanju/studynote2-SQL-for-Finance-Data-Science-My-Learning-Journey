--Topic: CASE
SELECT 
    customerName, 
    COUNT(*) orderCount
FROM
    orders
INNER JOIN customers 
        USING (customerNumber)
GROUP BY customerName
ORDER BY COUNT(*);

--
WITH cte AS (
        SELECT 
                customerName, 
                COUNT(*) orderCount
        FROM
                orders
        INNER JOIN customers 
                USING (customerNumber)
        GROUP BY customerName
)

SELECT 
    customerName, 
    orderCount,
    CASE orderCount
                WHEN 1 THEN 'One-time Customer'
        WHEN 2 THEN 'Repeated Customer'
        WHEN 3 THEN 'Frequent Customer'
        ELSE 'Loyal Customer'
        end customerType
FROM
    cte
ORDER BY customerName;


--

SELECT 
    customerName, 
    state, 
    country
FROM
    customers
ORDER BY (
    CASE
        WHEN state IS NULL THEN country
        ELSE state
    END
);


SELECT DISTINCT status
FROM orders
ORDER BY status;

--

SELECT 
    SUM(CASE
        WHEN status = 'Shipped' THEN 1
        ELSE 0
    END) AS 'Shipped',
    
    SUM(CASE
        WHEN status = 'On Hold' THEN 1
        ELSE 0
    END) AS 'On Hold',
    
    SUM(CASE
        WHEN status = 'In Process' THEN 1
        ELSE 0
    END) AS 'In Process',
    
    SUM(CASE
        WHEN status = 'Resolved' THEN 1
        ELSE 0
    END) AS 'Resolved',
    
    SUM(CASE
        WHEN status = 'Cancelled' THEN 1
        ELSE 0
    END) AS 'Cancelled',
    
    SUM(CASE
        WHEN status = 'Disputed' THEN 1
        ELSE 0
    END) AS 'Disputed',
    
    COUNT(*) AS Total
FROM
    orders;



-- Topic: IF statement

select if(1 =2, 'true', 'false')






