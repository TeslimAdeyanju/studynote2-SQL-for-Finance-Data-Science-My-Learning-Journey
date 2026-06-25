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
select a.last_name, film_count
from (
SELECT
    a.actor_id,
    a.first_name,
    a.last_name,
    COUNT(fa.film_id) AS film_count
FROM 
    actor AS a
JOIN 
    film_actor AS fa 
ON 
    a.actor_id = fa.actor_id
GROUP BY 
    a.actor_id,
    a.first_name,
    a.last_name) as info1
    join 
    
    
    
    
    
    