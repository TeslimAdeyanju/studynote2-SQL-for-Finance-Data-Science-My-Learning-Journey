    /** 3.1  COMPLETE GUIDE: SINGLE-ROW OPERATORS WITH AGGREGATE FUNCTIONS**/ 
   
   
    /*-- 1. USING > (GREATER THAN) WITH AGGREGATE FUNCTIONS*/
   -- Example 1.1: > with AVG()
   -- Business Scenario: "Find all films with a rental rate higher than the average rental rate
   SELECT
          film_id,
          title,
          rental_rate
   FROM   film
   WHERE  rental_rate >
          ( SELECT
                  AVG(rental_rate)
          FROM    film );
   
   
   /*-- Example 1.2: > with MAX()*/
   /*-- Business Scenario: "Find customers who have made more payments than the customer with the 
   -- maximum number of payments"*/
   SELECT
            c.customer_id,
            c.first_name,
            c.last_name,
            COUNT(p.payment_id) AS payment_count
   FROM     customer AS c
   JOIN     payment AS p
   USING 
            customer_id
   GROUP BY c.customer_id,
            c.first_name,
            c.last_name
   HAVING
            COUNT(p.payment_id) >=
            ( SELECT
                    MAX(payment_count)
            FROM   ( SELECT
                             customer_id,
                             COUNT(*) AS payment_count
                    FROM     payment
                    GROUP BY customer_id) AS customer_payments)
   
   
   /*-- Example 1.3: > with SUM()*/
   /*-- Business Scenario: "Find films that have generated more total revenue than the average film's 
   -- total revenue"*/
   SELECT
          ROUND(AVG(film_revenue), 2)
   FROM   ( SELECT
                   SUM(p2.amount) AS film_revenue
          FROM     sakila.film AS f2
          JOIN     sakila.inventory AS i2
          USING
                   (film_id)
          JOIN     sakila.rental AS r2
          USING
                   (inventory_id)
          JOIN     sakila.payment AS p2
          USING 
                   rental_id
          GROUP BY f2.film_id) AS average_revenue
   
   
    /*-- Example 1.4: > with MIN()*/
   --Business Scenario: "Find all films longer than the shortest film duration"
   SELECT 
          film_id, 
          title, 
          LENGTH
   FROM   film
   WHERE  LENGTH > 
          ( SELECT 
                  MIN(LENGTH)
          FROM    film ;
   
   
    /*-- Example 1.5: > with COUNT()*/
   --Business Scenario: "Find actors who have appeared in more films than the average actor"
   SELECT 
            a.actor_id,
            a.first_name,
            a.last_name,
            COUNT(fa.film_id) AS film_count
   FROM     actor as a
   JOIN     film_actor as fa ON a.actor_id = fa.actor_id
   GROUP BY a.actor_id,
            a.first_name,
            a.last_name
   HAVING 
            COUNT(fa.film_id) > 
            ( SELECT 
                    AVG(film_count)
            FROM    ( SELECT 
                             actor_id,
                             COUNT(*) AS film_count
                    FROM     film_actor
                    GROUP BY actor_id ) AS actor_film_counts );
                                                                                        
   
   
   
   
   /*-- 2. Using < (Less Than) with Aggregate Functions*/
   
    /*-- Example 2.1: < with AVG()*/
   -- Business Scenario: "Find all budget-friendly films priced below the average rental rate"
   SELECT 
          film_id, 
          title, 
          rental_rate, 
          rating
   FROM   film
   WHERE  rental_rate < 
          ( SELECT 
                  AVG(rental_rate)
          FROM    film );
   
   
    /*-- Example 2.2: < with MAX()*/
   --Business Scenario: "Find all films shorter than the longest film"
   SELECT 
            film_id,
            title,
            LENGTH,
            (SELECT 
                    MAX(LENGTH) 
            FROM    film) AS longest_film_duration
   FROM     film
   WHERE    LENGTH < 
            ( SELECT 
                    MAX(LENGTH)
            FROM    film )
   ORDER BY LENGTH DESC;
  
  
    /*-- Example 2.3: < with MIN()*/
   -- Business Scenario: "Identify films with rental duration longer than the minimum rental duration (if any exist)
   SELECT 
          film_id, 
          title, 
          rental_duration
   FROM   film
   WHERE  rental_duration >
          ( SELECT 
                  MIN(rental_duration)
          FROM    film );
  
   
    /*-- Example 2.4: < with COUNT()*/
   -- Business Scenario: "Find categories with fewer films than the average number of films per category
   SELECT 
             c.category_id,
             c.name,
             COUNT(fc.film_id) AS film_count
   FROM      category c
   LEFT JOIN film_category fc ON c.category_id = fc.category_id
   GROUP BY  c.category_id,
             c.name
   HAVING 
             COUNT(fc.film_id) < 
             ( SELECT 
                     AVG(films_per_category)
             FROM    ( SELECT 
                              category_id,
                              COUNT(*) AS films_per_category
                     FROM     film_category
                     GROUP BY category_id ) AS category_counts );
                                                                                                
   
   
   
   
   /*-- 3. Using = (Equals) with Aggregate Functions*/
   
   /*-- Example 3.1: = with MAX()*/
   --Business Scenario: "Find the most expensive film(s) in the inventory"
   SELECT 
          film_id, 
          title, 
          rental_rate
   FROM   film
   WHERE  rental_rate = 
          ( SELECT 
                  MAX(rental_rate)
          FROM    film );

  
   
    /*-- Example 3.2: = with MIN()*/
   -- Business Scenario: "Find the cheapest film(s) available for rental"
   SELECT 
          film_id, 
          title, 
          rental_rate, 
          rating
   FROM   film
   WHERE  rental_rate = 
          ( SELECT 
                  MIN(rental_rate)
          FROM    film );

   
    /*-- Example 3.3: = with AVG()*/
   -- Business Scenario: "Find customers whose total spending exactly matches the average customer spending
   SELECT 
            c.customer_id,
            c.first_name,
            c.last_name,
            SUM(p.amount) AS total_spent,
            (SELECT 
                    AVG(customer_total)
            FROM    (SELECT 
                             customer_id, 
                             SUM(amount) AS customer_total
                    FROM     payment
                    GROUP BY customer_id) AS totals) AS avg_spending
   FROM     customer c
   JOIN     payment p ON c.customer_id = p.customer_id
   GROUP BY c.customer_id, 
            c.first_name, 
            c.last_name
   HAVING 
            SUM(p.amount) = 
            ( SELECT 
                    AVG(customer_total)
            FROM    ( SELECT 
                             customer_id, 
                             SUM(amount) AS customer_total
                    FROM     payment
                    GROUP BY customer_id ) AS customer_totals );

 
    /*-- Example 3.4: = with COUNT()*/
   -- Business Scenario: "Find films that have been rented exactly as many times as the most-rented film
   SELECT 
            f.film_id, 
            f.title,
            COUNT(r.rental_id) AS rental_count
   FROM     film f
   JOIN     inventory i ON f.film_id      = i.film_id
   JOIN     rental r    ON i.inventory_id = r.inventory_id
   GROUP BY f.film_id, 
            f.title
   HAVING 
            COUNT(r.rental_id) = 
            ( SELECT 
                    MAX(rental_count)
            FROM    ( SELECT 
                             f2.film_id,
                             COUNT(r2.rental_id) AS rental_count
                    FROM     film AS f2
                    JOIN     inventory i2 ON f2.film_id      = i2.film_id
                    JOIN     rental r2    ON i2.inventory_id = r2.inventory_id
                    GROUP BY f2.film_id ) AS film_rentals );

   
   
   
   
    /*-- 4. Using >= (Greater Than or Equal To) with Aggregate Functions*/
   --Business Scenario: "Find films with replacement cost at or above the average"
   SELECT 
            film_id, 
            title, 
            replacement_cost,
            (SELECT 
                    AVG(replacement_cost) 
            FROM    film) AS avg_cost
   FROM     film
   WHERE    replacement_cost >= 
            ( SELECT 
                    AVG(replacement_cost)
            FROM    film )
   ORDER BY replacement_cost;

   
      /*-- Example 4.1: >= with AVG()*/
   -- Business Scenario: "Find actors who have appeared in as many or more films than the most prolific actor"
   SELECT 
            a.actor_id,
            a.first_name,
            a.last_name,
            COUNT(fa.film_id) AS film_count
   FROM     actor a
   JOIN     film_actor fa ON a.actor_id = fa.actor_id
   GROUP BY a.actor_id,
            a.first_name,
            a.last_name
   HAVING 
            COUNT(fa.film_id) >= 
            ( SELECT 
                    MAX(film_count)
            FROM    ( SELECT 
                             actor_id, 
                             COUNT(*) AS film_count
                    FROM     film_actor
                    GROUP BY actor_id ) AS actor_counts );

   
   
   /*-- Example 4.2: >= with MAX()*/
   -- Business Scenario: "Find actors who have appeared in as many or more films than the most prolific actor"
    SELECT
            a.actor_id,
            a.first_name,
            a.last_name,
            COUNT(fa.film_id) AS film_count
   FROM     actor AS a
   JOIN     sakila.film_actor AS fa ON a.actor_id = fa.actor_id
   GROUP BY a.actor_id,
            a.first_name,
            a.last_name
   HAVING 
            COUNT(fa.film_id) >= 
            ( SELECT 
                    MAX(film_count)
            FROM   ( SELECT 
                             actor_id, 
                             COUNT(*) AS film_count
                    FROM     sakila.film_actor
                    GROUP BY actor_id) AS actor_count)
   
   
   /*-- Example 4.3: >= with MIN()*/
   
  -- Business Scenario: "Find all films with length at or above the minimum length (basically all films)"
  
     SELECT
          film_id,
          title,
          LENGTH
   FROM   sakila.film
   WHERE  LENGTH>=
          ( SELECT
                  MIN(LENGTH)
          FROM    film);
   

   
   /*-- Example 4.4: >= with SUM()*/
   
   -- Business Scenario: "Find customers who have spent at least as much as the average customer spending"
    SELECT
            c.customer_id,
            c.first_name,
            c.last_name,
            SUM(p.amount) AS total_spend
   FROM     sakila.customer AS c
   JOIN     sakila.payment AS p ON p.customer_id = c.customer_id
   GROUP BY c.customer_id,
            c.first_name,
            c.last_name
   HAVING 
            SUM(p.amount) >= 
            ( SELECT
                    AVG(customer_spending)
            FROM    ( SELECT
                             customer_id,
                             SUM(amount) AS customer_spending
                    FROM     payment
                    GROUP BY customer_id) AS spending_total);
   
   
   /*-- 5. Using <= (Less Than or Equal To) with Aggregate Functions*/
   /*-- Example 5.1: <= with AVG()*/
   
   -- Business Scenario: "Find films with rental duration at or below the average"
      SELECT
            film_id,
            title,
            rental_duration,
            (SELECT
                    AVG(rental_duration)
            FROM    sakila.film) AS avg_duration
   FROM     sakila.film
   WHERE    rental_duration <=
            (SELECT
                    AVG(rental_duration)
            FROM    sakila.film)
   ORDER BY rental_duration DESC;
   
   
   /*-- Example 5.2: <= with MAX()*/
   -- Business Scenario: "Find all films with length at or below the maximum length (all films)"
   SELECT 
          film_id, 
          title, 
          LENGTH
   FROM   film
   WHERE  LENGTH <= 
          ( SELECT 
                  MAX(LENGTH)
          FROM    film );
   
   /*-- Example 5.3: <= with MIN()*/
   -- Business Scenario: "Find the shortest film(s) in the inventory"
   
    SELECT 
          film_id, 
          title, 
          LENGTH, 
          (SELECT 
                  MIN(LENGTH) 
          FROM    film) AS shortest_length
   FROM   film
   WHERE  LENGTH <= 
          ( SELECT 
                  MIN(LENGTH)
          FROM    film);
   
   /*-- Example 5.4: <= with COUNT()*/
   -- Business Scenario: "Find stores with rental counts at or below the average rentals per store"
   SELECT
         s.store_id,
         COUNT(r.rental_id) AS rental_count,
         (SELECT
               AVG(store_rentals)
            FROM (SELECT
                     store_id,
                     COUNT(*) AS store_rentals
                  FROM inventory i2
                  JOIN rental r2 ON i2.inventory_id = r2.inventory_id
                  GROUP BY
                     store_id) AS counts) AS avg_rentals
      FROM store AS s
      JOIN sakila.inventory AS i ON s.store_id = i.store_id
      JOIN rental AS r           ON i.inventory_id = r.inventory_id
      GROUP BY
         s.store_id
      HAVING COUNT(r.rental_id) <=
         (SELECT
               AVG(store_rentals)
            FROM ( SELECT
                     i2.store_id,
                     COUNT(*) AS store_rentals
                  FROM inventory AS i2
                  JOIN rental r2 ON i2.inventory_id = r2.inventory_id
                  GROUP BY
                     i2.store_id) AS store_rental_counts);
   
   
   
   /*-- 6. Using <> or != (Not Equal To) with Aggregate Functions*/
   /*-- Example 6.1: <> with AVG()*/
   -- Business Scenario: "Find films with rental rates different from the average (not exactly average)"
   SELECT 
         film_id, 
         title, 
         rental_rate,
         (SELECT 
               AVG(rental_rate) 
            FROM film) AS avg_rate
      FROM film
      WHERE rental_rate <> 
         ( SELECT 
               AVG(rental_rate)
            FROM film )
      ORDER BY 
         rental_rate;
   
   
   /*--Example 6.2: <> with MAX()*/
   -- Business Scenario: "Find all films that are NOT the longest film(s)"
   SELECT 
         film_id, 
         title, 
         LENGTH
      FROM film
      WHERE LENGTH <> 
         ( SELECT 
               MAX(LENGTH)
            FROM film )
      ORDER BY 
         LENGTH DESC;

   
   /*-- Example 6.3: <> with MIN()*/
   -- Business Scenario: "Find all films that are NOT the shortest film(s)"
   SELECT 
         film_id, 
         title, 
         LENGTH
      FROM film
      WHERE LENGTH <> 
         ( SELECT 
               MIN(LENGTH)
            FROM film )
      ORDER BY 
         LENGTH;

   
   
   /*-- Example 6.4: != with COUNT()*/
   -- Business Scenario: "Find actors whose film count is NOT equal to the average"
   SELECT 
         a.actor_id, 
         a.first_name, 
         a.last_name,
         COUNT(fa.film_id) AS film_count,
         (SELECT 
               AVG(actor_film_count)
            FROM (SELECT 
                     actor_id, 
                     COUNT(*) AS actor_film_count
                  FROM film_actor
                  GROUP BY 
                     actor_id) AS counts) AS avg_count
      FROM actor a
      JOIN film_actor fa ON a.actor_id = fa.actor_id
      GROUP BY 
         a.actor_id, 
         a.first_name, 
         a.last_name
      HAVING COUNT(fa.film_id) != 
         ( SELECT 
               AVG(actor_film_count)
            FROM ( SELECT 
                     actor_id, 
                     COUNT(*) AS actor_film_count
                  FROM film_actor
                  GROUP BY 
                     actor_id ) AS actor_film_counts );

   
   
   /*-- 7. Complex Example: Combining Multiple Aggregate Comparisons*/
   --Example 7.1:  "Find films that are above average in price BUT below average in length - premium short films"
    SELECT 
         film_id, 
         title, 
         rental_rate, 
         LENGTH,
         (SELECT 
               AVG(rental_rate) 
            FROM film) AS avg_rate,
         (SELECT 
               AVG(LENGTH) 
            FROM film) AS avg_length
      FROM film
      WHERE rental_rate > 
         ( SELECT 
               AVG(rental_rate)
            FROM film )
      AND LENGTH < 
         ( SELECT 
               AVG(LENGTH)
            FROM film )
      ORDER BY 
         rental_rate DESC, 
         LENGTH;

  
   
   
   /*--Example 7.2: "Find the most expensive film in the shortest category"*/
   -- : "Find the most expensive film in the shortest category"
   SELECT 
         f.film_id, 
         f.title, 
         f.rental_rate, 
         f.length, 
         c.name AS category
      FROM film f
      JOIN film_category fc ON f.film_id = fc.film_id
      JOIN category c       ON fc.category_id = c.category_id
      WHERE f.length = 
         ( SELECT 
               MIN(LENGTH)
            FROM film )
      AND f.rental_rate = 
         ( SELECT 
               MAX(rental_rate)
            FROM film
            WHERE LENGTH = 
               ( SELECT 
                     MIN(LENGTH)
                  FROM film ) );

   
   
   
   
   /*--**3.2  COMPLETE GUIDE: MULTIPLE-ROW OPERATORS (IN, ANY, ALL)/***/
   
   -- Example 1.1: Basic IN with Simple Subquery
   /*--Business Scenario: "Find all customers who have rented films from the 'Action' category"*/
   SELECT 
          customer_id, 
          first_name, 
          last_name, 
          email
   FROM   customer
   WHERE  address_id 
          IN 
          ( SELECT 
                  DISTINCT r.customer_id
          FROM    rental r
          JOIN    inventory i      ON r.inventory_id = i.inventory_id
          JOIN    film_category fc ON i.film_id      = fc.film_id
          JOIN    category c       ON fc.category_id = c.category_id
          WHERE   c.name                             = 'Action');
   
   
   -- Example 1.2: IN with Multiple JOINs
   /*-- Business Scenario: "Find all actors who have appeared in films rented by customer_id 5"*/
   SELECT 
            a.actor_id,
            a.first_name,
            a.last_name,
            COUNT(DISTINCT fa.film_id) AS films_with_customer5
   FROM     actor a
   JOIN     film_actor fa ON a.actor_id = fa.actor_id
   WHERE    fa.film_id 
            IN 
            ( SELECT 
                    DISTINCT i.film_id
            FROM    rental r
            JOIN    inventory i ON r.inventory_id = i.inventory_id
            WHERE   r.customer_id                 = 5 )
   GROUP BY a.actor_id,
            a.first_name,
            a.last_name
   ORDER BY films_with_customer5 DESC;
   
   
   -- Example 1.3: NOT IN - Exclusion Pattern
   /*-- Business Scenario: "Find all films that have NEVER been rented"*/
   SELECT 
            f.film_id, 
            f.title, 
            f.rental_rate, 
            f.length
   FROM     film f
   WHERE    f.film_id NOT 
            IN 
            ( SELECT 
                    DISTINCT i.film_id
            FROM    inventory i
            JOIN    rental r ON i.inventory_id = r.inventory_id )
   ORDER BY f.rental_rate DESC;
   
   
   -- Example 1.4: IN with Subquery on Different Table
   /*-- Business Scenario: "Find all staff members who work at stores that have inventory of 'Horror' 
   -- films"*/
   SELECT 
          s.staff_id, 
          s.first_name, 
          s.last_name, 
          s.email
   FROM   staff s
   WHERE  s.store_id 
          IN 
          ( SELECT 
                  DISTINCT i.store_id
          FROM    inventory i
          JOIN    film_category fc ON i.film_id      = fc.film_id
          JOIN    category c       ON fc.category_id = c.category_id
          WHERE   c.name                             = 'Horror' );
   
   
   
   -- Example 1.5: IN with Aggregated Subquery
   /*-- Business Scenario: "Find customers who have rented films that cost exactly one of the standard 
   -- price points (0.99, 2.99, 4.99)"*/
   SELECT
            DISTINCT c.customer_id,
            c.first_name,
            c.last_name,
            COUNT(DISTINCT r.rental_id) AS total_rentals
   FROM     customer c
   JOIN     rental r    ON c.customer_id  = r.customer_id
   JOIN     inventory i ON r.inventory_id = i.inventory_id
   JOIN     film f      ON i.film_id      = f.film_id
   WHERE    f.rental_rate IN (0.99,
                              2.99,
                              4.99)
   GROUP BY c.customer_id,
            c.first_name,
            c.last_name
   ORDER BY total_rentals DESC;
   
   
 -- Example 2.1: > ANY (Greater Than At Least One)
 --Business Scenario: "Find films more expensive than ANY film in the 'Family' category"
   SELECT 
         f.film_id, 
         f.title, 
         f.rental_rate,
         (SELECT 
               MIN(f2.rental_rate)
            FROM film f2
            JOIN film_category fc2 ON f2.film_id = fc2.film_id
            JOIN category c2       ON fc2.category_id = c2.category_id
            WHERE c2.name = 'Family') AS cheapest_family_film
      FROM film f
      WHERE f.rental_rate > ANY 
         ( SELECT 
               f2.rental_rate
            FROM film as f2
            JOIN film_category as fc ON f2.film_id = fc.film_id
            JOIN category as c       ON fc.category_id = c.category_id
            WHERE c.name = 'Family' )
      ORDER BY 
         f.rental_rate;

 
 -- Example 2.2: < ANY (Less Than At Least One)
 -- Business Scenario: "Find films cheaper than ANY film in the 'New' category"
   SELECT 
         f.film_id, 
         f.title, 
         f.rental_rate,
         (SELECT 
               MAX(f2.rental_rate)
            FROM film f2
            JOIN film_category fc2 ON f2.film_id = fc2.film_id
            JOIN category c2       ON fc2.category_id = c2.category_id
            WHERE c2.name = 'New') AS most_expensive_new_film
      FROM film f
      WHERE f.rental_rate < ANY 
         ( SELECT 
               f2.rental_rate
            FROM film f2
            JOIN film_category fc ON f2.film_id = fc.film_id
            JOIN category c       ON fc.category_id = c.category_id
            WHERE c.name = 'New' )
      ORDER BY 
         f.rental_rate DESC; 
 
 -- Example 2.3: = ANY (Equals At Least One) - Same as IN
 -- Business Scenario: "Find actors who have appeared in 'Comedy' films"
   SELECT 
         a.actor_id, 
         a.first_name, 
         a.last_name
      FROM actor a
      WHERE a.actor_id = ANY 
         ( SELECT 
               fa.actor_id
            FROM film_actor as fa
            JOIN film_category as fc ON fa.film_id = fc.film_id
            JOIN category c       ON fc.category_id = c.category_id
            WHERE c.name = 'Comedy' );

 
 -- Example 2.4: >= ANY (Greater Than or Equal to At Least One)
 -- Business Scenario: "Find films with rental duration at least as long as ANY documentary film"
   SELECT 
         f.film_id, 
         f.title, 
         f.rental_duration,
         c.name AS category,
         (SELECT 
               AVG(f2.rental_duration) as min
            FROM film f2
            JOIN film_category fc2 ON f2.film_id = fc2.film_id
            JOIN category c2       ON fc2.category_id = c2.category_id
            WHERE c2.name = 'Documentary' ) as ff
      FROM film f
      JOIN film_category fc ON f.film_id = fc.film_id
      JOIN category c       ON fc.category_id = c.category_id
      WHERE f.rental_duration > ANY 
         ( SELECT 
               f2.rental_duration
            FROM film f2
            JOIN film_category fc2 ON f2.film_id = fc2.film_id
            JOIN category c2       ON fc2.category_id = c2.category_id
            WHERE c2.name = 'Documentary' )
      ORDER BY 
         f.rental_duration;

 
 
 -- Example 2.5: <> ANY (Not Equal to At Least One)
 -- Business Scenario: "Find customers whose payment amounts differ from at least one payment made by customer_id 1"
   SELECT 
         DISTINCT c.customer_id, 
         c.first_name, 
         c.last_name,
         COUNT(DISTINCT p.payment_id) AS payment_count
      FROM customer c
      JOIN payment p ON c.customer_id = p.customer_id
      WHERE p.amount <> ANY 
         ( SELECT 
               p2.amount
            FROM payment p2
            WHERE p2.customer_id = 1 )
      GROUP BY 
         c.customer_id, 
         c.first_name, 
         c.last_name
      ORDER BY 
         payment_count DESC;

 
 -- Example 3.1: > ALL (Greater Than Every Value)
 -- Business Scenario: "Find films more expensive than ALL films in the 'Documentary' category"
    SELECT
         f.film_id,
         f.title,
         f.rental_rate,
         (SELECT
               MAX(f2.rental_rate)
            FROM film AS f2
            JOIN sakila.film_category AS fc ON f2.film_id = fc.film_id
            JOIN sakila.category AS c       ON fc.category_id = c.category_id
            WHERE c.name = 'Documentary') AS most_expensive_documentary
      FROM film AS f
      WHERE f.rental_rate > ALL
         ( SELECT
               f2.rental_rate
            FROM film AS f2
            JOIN sakila.film_category AS fc ON f2.film_id = fc.film_id
            JOIN sakila.category AS c       ON fc.category_id = c.category_id
            WHERE c.name = 'Documentary');

 
 -- Example 3.2: < ALL (Less Than Every Value)
 -- Business Scenario: "Find films cheaper than ALL films in the 'Games' category"
      SELECT 
         f.film_id, 
         f.title, 
         f.rental_rate,
         (SELECT 
               MIN(f2.rental_rate)
            FROM film f2
            JOIN film_category fc2 ON f2.film_id = fc2.film_id
            JOIN category c2       ON fc2.category_id = c2.category_id
            WHERE c2.name = 'Games') AS cheapest_games_film
      FROM film f
      WHERE f.rental_rate < ALL 
         ( SELECT 
               f2.rental_rate
            FROM film f2
            JOIN film_category fc ON f2.film_id = fc.film_id
            JOIN category c       ON fc.category_id = c.category_id
            WHERE c.name = 'Games' )
      ORDER BY 
         f.rental_rate DESC;

 
 
 -- Example 3.3: >= ALL (Greater Than or Equal to Every Value)
 -- Business Scenario: "Find actors who have appeared in at least as many films as EVERY actor in the top 5"
   SELECT 
         a.actor_id, 
         a.first_name, 
         a.last_name,
         COUNT(fa.film_id) AS film_count
      FROM actor a
      JOIN film_actor fa ON a.actor_id = fa.actor_id
      GROUP BY 
         a.actor_id, 
         a.first_name, 
         a.last_name
      HAVING COUNT(fa.film_id) >= ALL 
         ( SELECT 
               film_count
            FROM ( SELECT 
                     actor_id, 
                     COUNT(*) AS film_count
                  FROM film_actor
                  GROUP BY 
                     actor_id
                  ORDER BY 
                     film_count DESC
                  LIMIT 
                     5 ) AS top5_actors )
      ORDER BY 
         film_count DESC;

 
 
 
 
 
 -- Example 3.4: <= ALL (Less Than or Equal to Every Value)
 -- Business Scenario: "Find customers who have spent less than or equal to ALL customers in the top 10 spenders"
   SELECT 
         c.customer_id, 
         c.first_name, 
         c.last_name,
         SUM(p.amount) AS total_spent
      FROM customer c
      JOIN payment p ON c.customer_id = p.customer_id
      GROUP BY 
         c.customer_id, 
         c.first_name, 
         c.last_name
      HAVING SUM(p.amount) <= ALL 
         ( SELECT 
               total_spending
            FROM ( SELECT 
                     customer_id, 
                     SUM(amount) AS total_spending
                  FROM payment
                  GROUP BY 
                     customer_id
                  ORDER BY 
                     total_spending DESC
                  LIMIT 
                     10 ) AS top10_spenders )
      ORDER BY 
         total_spent;

 
 
 
 
 -- Example 3.5: <> ALL (Not Equal to Every Value) - Same as NOT IN
 -- Business Scenario: "Find films that are NOT in any of the categories favored by customer_id 1"
  
   SELECT 
         f.film_id, 
         f.title
      FROM film f
      JOIN film_category fc ON f.film_id = fc.film_id
      WHERE fc.category_id <> ALL 
         ( SELECT 
               DISTINCT fc2.category_id
            FROM rental r
            JOIN inventory i       ON r.inventory_id = i.inventory_id
            JOIN film_category fc2 ON i.film_id = fc2.film_id
            WHERE r.customer_id = 1 )
      ORDER BY 
         f.title;
  
  