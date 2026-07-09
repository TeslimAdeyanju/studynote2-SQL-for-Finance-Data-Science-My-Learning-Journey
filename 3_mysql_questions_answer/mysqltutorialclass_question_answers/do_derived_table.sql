-- database: Sakila
-- model : Mysql
SELECT
    helping_data.customer_id,
    helping_data.year_info,
    helping_data.amount,
    s.active
FROM
    (   SELECT
            c.customer_id,
            YEAR(c.create_date) AS year_info,
            r.inventory_id,
            p.amount,
            p.staff_id
        FROM
            customer AS c
        JOIN
            payment AS p
        USING
            (customer_id)
        JOIN
            sakila.rental AS r
        USING
            (rental_id) ) AS helping_data
JOIN
    sakila.staff AS s
ON
    helping_data.staff_id = s.staff_id;


-- Example 2
SELECT
    info1.actor_id,
    info1.first_name, info1.film_id, fm.rental_rate
FROM
    (   SELECT
            a.actor_id,
            a.first_name,
            a.last_name,
            fa.last_update,
            fa.film_id
        FROM
            actor AS a
        JOIN
            film_actor AS fa
        ON
            a.actor_id = fa.actor_id) as info1
JOIN
    film AS fm
USING
    (film_id);

    
    -- 
 SELECT
    customerGroup,
    COUNT(cg.customerGroup) AS groupCount
FROM
    (   SELECT
            customerNumber,
            ROUND(SUM(quantityOrdered * priceEach)) sales,
            (
            CASE
                WHEN SUM(quantityOrdered * priceEach) < 10000
                THEN 'Silver'
                WHEN SUM(quantityOrdered * priceEach) BETWEEN 10000 AND 100000
                THEN 'Gold'
                WHEN SUM(quantityOrdered * priceEach) > 100000
                THEN 'Platinum'
            END) customerGroup
        FROM
            orderdetails
        INNER JOIN
            orders
        USING
            (orderNumber)
        WHERE
            YEAR(shippedDate) = 2003
        GROUP BY
            customerNumber) as cg
GROUP BY
    cg.customerGroup;

    
    
    
    