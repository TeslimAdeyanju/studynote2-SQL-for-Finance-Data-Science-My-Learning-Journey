   -- Mysql 
   -- Daily Excercise to simulate learning code 
   -- Database: Sakila
   
   SELECT
         a.name,
         COUNT(*) AS number_views,
         AVG(r.rating) AS avg_rating
      FROM renting AS r
      LEFT JOIN customers AS c ON r.customer_id = c.customer_id
      LEFT JOIN actsin AS ai   ON r.movie_id = ai.movie_id
      LEFT JOIN actors AS a    ON ai.actor_id = a.actor_id
      WHERE c.gender = 'male'
      GROUP BY
         a.name
      HAVING AVG(r.rating) IS NOT NULL
      ORDER BY avg_rating DESC,
         number_views DESC
   ---
   SELECT 
         *
      FROM customers
      WHERE customer_id IN -- Select all customers with more than 10 movie rentals
         (SELECT 
               customer_id
            FROM renting
            GROUP BY 
               customer_id
            HAVING customer_id >10);
   ---
   SELECT 
         *
      FROM customers
      WHERE customer_id IN -- Select all customers with more than 10 movie rentals
         (SELECT 
               customer_id
            FROM renting
            GROUP BY 
               customer_id
            HAVING COUNT(*) >10);
   ---
   SELECT 
         *
      FROM customers
      WHERE customer_id IN 
         ( SELECT 
               COUNT(*)
            FROM renting
            WHERE customer_id <5)
   ---
   SELECT 
         MIN(rating)
      FROM renting AS r
      WHERE r.customer_id = 7;
   ---
   SELECT 
         *
      FROM customers AS c
      WHERE 4 > -- Select all customers with a minimum rating smaller than 4
         (SELECT 
               MIN(rating)
            FROM renting AS r
            WHERE r.customer_id = c.customer_id);
   ----
   SELECT 
         *
      FROM movies AS m
      WHERE 8 < -- Select all movies with an average rating higher than 8
         (SELECT 
               AVG(rating)
            FROM renting AS r
            WHERE r.movie_id = m.movie_id);
   ---
   SELECT 
         *
      FROM customers AS c-- Select all customers with at least one rating
      WHERE EXISTS
         (SELECT 
               *
            FROM renting AS r
            WHERE rating IS NOT NULL
            AND r.customer_id = c.customer_id);
   --
   SELECT 
         fm.title,
         fm.rental_duration,
         SUM(fm.rental_rate * fm.length) AS revenue,
         YEAR(fm.last_update) AS YEAR, 
         pm.amount,
         CASE
            WHEN SUM(fm.rental_rate * fm.length) <500 THEN 'Silver'
            WHEN SUM(fm.rental_rate * fm.length) BETWEEN 500 AND 1000 THEN 'Gold'
            WHEN SUM(fm.rental_rate * fm.length) > 1000 THEN 'Platinum'
            ELSE 'check'
         END AS grouping_list
      FROM film AS fm
      JOIN inventory AS iv 
      USING(film_id)
      JOIN rental AS rt 
      USING(inventory_id)
      JOIN payment AS pm 
      USING(rental_id)
      GROUP BY 
         fm.title, 
         fm.rental_duration, 
         YEAR(fm.last_update), 
         pm.amount
   -- using the consoto database
   SELECT
         CONCAT(c.surname, ' ', c.givenname) AS full_name,
         c.vehicle,
         s.unitprice,
         s.quantity,
         ROUND((s.unitprice * s.quantity):: NUMERIC,2) AS revenue,
         (SELECT
               MAX(unitprice * quantity) 
            FROM sales)
      FROM customer AS c
      JOIN sales AS s 
      USING (customerkey);
   
   --
   SELECT 
         C.customer_id, 
         YEAR(C.create_date) as year_info, 
         r.inventory_id, 
         p.amount
      FROM customer AS C
      JOIN payment AS p 
      USING (customer_id)
      JOIN sakila.rental AS r 
      USING(rental_id)
      LIMIT 5;
   
   
   
    SELECT 
         customer_id, 
         year_info, 
         amount, 
         s.active
      FROM (SELECT
               C.customer_id,
               YEAR(C.create_date) AS year_info,
               r.inventory_id,
               p.amount
            FROM customer AS C
            JOIN payment AS p
            USING (customer_id)
            JOIN sakila.rental AS r
            USING(rental_id)
            ) AS helping_data
      JOIN sakila.staff AS s
      on p.staff_id = s.staff_id
      
   
   
   
   