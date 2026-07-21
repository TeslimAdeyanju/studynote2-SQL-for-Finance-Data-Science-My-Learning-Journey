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
    


    
    