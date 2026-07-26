 /*-- Database: Sakila*/
 /*-- Set Operator*/
 /*-- INTESECT Operator*/
 
 
 /*-- ### Business Scenario*/
 
 
 /*-- The operations manager wants to identify **loyal cross-store customers** — customers who have*/
 /*-- visited and rented from **both Store 1 and Store 2**. This is the textbook INTERSECT use case:*/
 /*-- find the common members across two independent groups.*/
 SELECT
         DISTINCT r1.customer_id
     FROM sakila.rental AS r1
     JOIN sakila.staff AS s ON r1.staff_id = s.staff_id
     WHERE s.store_id = 1
  
 INTERSECT
 
 SELECT
         DISTINCT r1.customer_id
     FROM sakila.rental AS r1
     JOIN sakila.staff AS s ON r1.staff_id = s.staff_id
     WHERE s.store_id = 2

 /*-- Example 2 — Films Available in Both Stores' Inventor*/
 /*-- Business Scenario*/
 /*-- The stock management team wants a list of films that are **physically stocked in both Store 1 
 and Store 2**. These are films where both locations carry at least one copy — useful for
 -- coordinating stock transfers and pricing consistency reviews.*/
 SELECT 
         DISTINCT f.film_id,
         f.title,
         f.rating,
         f.rental_rate
     FROM sakila.film AS F
     JOIN sakila.inventory AS i ON F.film_id = i.film_id
     WHERE i.store_id = 1
 
 INTERSECT
 
 SELECT 
         DISTINCT f.film_id,
         f.title,
         f.rating,
         f.rental_rate
     FROM sakila.film AS F
     JOIN sakila.inventory AS i ON F.film_id = i.film_id
     WHERE i.store_id = 2
     ORDER BY
         F.rental_rate DESC,
         F.title ASC
     
     
    /*-- Example 3 — Customers Who Both Rented and Made a Payment in the Same Month*/
 /*-- ### Business Scenario*/
 /*-- The finance and operations team wants to cross-reference rental activity with payment records 
 -- for **June 2005** — identifying customers who appear in **both** the rental records and payment 
 -- records for that month. This confirms that customers who rented also completed payment (a data 
 -- quality and reconciliation check).*/
 SELECT 
         DISTINCT r1.customer_id
     FROM sakila.rental as r1
     WHERE r1.rental_date >= '2005-06-01' 
         AND r1.rental_date < '2005-07-01'
     
     INTERSECT
     
  SELECT 
         DISTINCT p1.customer_id
     FROM sakila.payment as p1
     WHERE p1.payment_date >= '2005-06-01' 
         AND p1.payment_date < '2005-07-01'
     
     
 /*--    ### Extended version — with customer name enrichment using a subquery*/
 /*--*/
 /*--Once you have the intersecting `customer_id` list, you can wrap it in a subquery to pull in 
 -- descriptive details:*/
   
   -- Add customer name details to the INTERSECT result using a subquery
 SELECT
         c.customer_id,
         CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
         c.email,
         c.store_id
     FROM customer c
     WHERE c.customer_id 
         IN 
         (
         /*-- Inner INTERSECT query produces the matching customer_ids*/
         SELECT 
                 DISTINCT customer_id
             FROM rental
             WHERE rental_date >= '2005-06-01' 
                 AND rental_date < '2005-07-01'
         
         INTERSECT
         
         SELECT 
                 DISTINCT customer_id
             FROM payment
             WHERE payment_date >= '2005-06-01' 
                 AND payment_date < '2005-07-01' )
     ORDER BY 
         c.last_name ASC;
 
     
 /*-- Example 4 — Actors Who Appeared in Both Action and Comedy Films*/
 /*-- The marketing team is building a versatile talent shortlist — actors who have demonstrated
 -- range by appearing in both Action and Comedy films. These actors are ideal for cross-genre
 -- promotional campaigns.*/
 /*-- Actors who appeared in at least one Action film*/
 SELECT 
         DISTINCT a.actor_id,
         CONCAT(a.first_name, ' ', a.last_name) AS actor_name
     FROM actor a
     JOIN film_actor fa    ON a.actor_id = fa.actor_id
     JOIN film_category fc ON fa.film_id = fc.film_id
     JOIN category c       ON fc.category_id = c.category_id
     WHERE c.name = 'Action' /*-- Genre filter: Action only*/
 
 INTERSECT
 
 /*-- Actors who appeared in at least one Comedy film*/
 SELECT 
         DISTINCT a.actor_id,
         CONCAT(a.first_name, ' ', a.last_name) AS actor_name
     FROM actor a
     JOIN film_actor fa    ON a.actor_id = fa.actor_id
     JOIN film_category fc ON fa.film_id = fc.film_id
     JOIN category c       ON fc.category_id = c.category_id
     WHERE c.name = 'Comedy' /*-- Genre filter: Comedy only*/
     ORDER BY 
         actor_name ASC;
 
 -- Example 5 — High-Value Customers Active IN Both Revenue AND Rental Volume
 /*-- ### Business Scenario*/
 /*-- The CRM team wants to identify **premium customers** — specifically those who rank in the ** 
 -- top 100 by total spend** AND simultaneously in the **top 100 by rental count**. These dual- 
 -- qualification customers represent the most engaged and valuable segment for a VIP loyalty 
 -- programme.*/
 

 SELECT
         customer_id
     FROM payment
     GROUP BY
         customer_id
     ORDER BY
         SUM(amount) DESC
     LIMIT 100 
 /*-- Only the top 100 spenders*/
 INTERSECT
  
 /*-- Top 100 customers by total rental count*/
 SELECT
         customer_id
     FROM rental
     GROUP BY
         customer_id
     ORDER BY
         COUNT(rental_id) DESC
     LIMIT 100;
 /*-- Only the top 100 renters*/
 
 
 -- -- Enrich the intersection result with full customer profile
 SELECT
         c.customer_id,
         CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
         c.email,
         c.store_id,
         SUM(p.amount) AS total_spent,
         COUNT(r.rental_id) AS total_rentals
     FROM customer c
     JOIN payment p ON c.customer_id = p.customer_id
     JOIN rental r  ON c.customer_id = r.customer_id
     WHERE c.customer_id 
         IN 
         ( SELECT 
                 customer_id 
             FROM ( SELECT 
                         customer_id 
                     FROM payment
                     GROUP BY 
                         customer_id 
                     ORDER BY 
                         SUM(amount) DESC 
                     LIMIT 100 ) AS top_spenders
          
         INTERSECT
          
         SELECT 
                 customer_id 
             FROM ( SELECT 
                         customer_id 
                     FROM rental
                     GROUP BY 
                         customer_id 
                     ORDER BY 
                         COUNT(rental_id) DESC 
                     LIMIT 100 ) AS top_renters )
     GROUP BY
         c.customer_id, 
         c.first_name, 
         c.last_name, 
         c.email, 
         c.store_id
     ORDER BY
         total_spent DESC;
 
 
 
 