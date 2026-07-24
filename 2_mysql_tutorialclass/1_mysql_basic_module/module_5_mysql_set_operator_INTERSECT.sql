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
     
     
     
     
     
     
     
     
    