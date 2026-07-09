-- Databe: classicmodel 

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
            orders.orderNumber = orderdetails.orderNumber)