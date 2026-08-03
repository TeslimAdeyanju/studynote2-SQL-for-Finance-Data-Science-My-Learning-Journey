    /*-- Database: Sakila*/
    /*-- Set Operator*/
    /*-- EXCEPT Operator*/
    /*-- Example 1: Retrieve all unique first and last names across customers and staff*/
   
   
 /*-- Example 1 — Customers Who Rented But Never Made a Payment*/
 /*-- Business Scenario: The finance team needs to identify customers with outstanding balances — 
 -- those who have rental records but no corresponding payment on file. This is a classic accounts 
 -- receivable gap analysis: who owes money?*/
 
 /*-- Add customer name and contact details to the EXCEPT result*/
 SELECT
         c.customer_id,
         CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
         c.email,
         c.store_id,
         c.active
     FROM customer c
     WHERE c.customer_id 
         IN 
         (
         /*-- Inner EXCEPT query: renters with no payment record*/
         SELECT 
                 DISTINCT customer_id 
             FROM rental
          
         EXCEPT
          
         SELECT 
                 DISTINCT customer_id 
             FROM payment )
     ORDER BY 
         c.last_name ASC;
         
         
       
 /*-- Example 2 — Films in the Catalogue That Have Never Been Rented*/
 /*-- Business Scenario: The inventory manager wants to identify dead stock — films that exist in 
 -- the film catalogue but have never appeared in a rental transaction. These are candidates for 
 -- removal, redistribution, or promotional pricing.*/
 /*-- All film IDs in the catalogue*/
 SELECT 
         DISTINCT f.film_id,
         f.title,
         f.rating,
         f.rental_rate
     FROM film f /*-- Base set: entire film catalogue*/
 
 EXCEPT
 
 /*-- Film IDs that have appeared in at least one rental (via inventory)*/
 SELECT 
         DISTINCT f.film_id,
         f.title,
         f.rating,
         f.rental_rate
     FROM film f
     JOIN inventory i ON f.film_id = i.film_id /*-- Link film to physical copies*/
     JOIN rental r    ON i.inventory_id = r.inventory_id /*-- Link copy to rental record*/
     ORDER BY 
         rental_rate DESC, 
         title ASC;
         
         
         
     
 /*-- Example 3 — Active Customers Who Have Not Rented in 2005*/
 /*-- ### Business Scenario: The CRM team is running a **re-engagement campaign**. They want to
 -- contact all currently active customers who have not made a single rental during 2005 — the core
 -- trading year in the Sakila data. These are dormant accounts that need to be reactivated.*/
 /*-- Full re-engagement campaign list with customer details*/
 SELECT
         c.customer_id,
         CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
         c.email,
         c.store_id
     FROM customer c
     WHERE c.active = 1
         AND c.customer_id 
         IN 
         (
         /*-- Active customers not in the 2005 rental records*/
         SELECT 
                 DISTINCT customer_id
             FROM customer
             WHERE active = 1
         
      UNION
         
         SELECT 
                 DISTINCT customer_id
             FROM rental
             WHERE rental_date >= '2005-01-01'
                 AND rental_date < '2006-01-01' )
     ORDER BY 
         c.store_id, 
         c.last_name ASC;
 
 
 
 /*-- Example 4 — Actors Who Appeared in Action Films But Not in Comedy Films*/
 /*-- ### Business Scenario: The talent acquisition team wants to identify **Action-genre 
 -- specialists** — actors who have credits in Action films but have **never** appeared in a Comedy 
 -- film. These are candidates for a new Action-only franchise campaign.*/
 /*-- Actors who appeared in at least one Action film (base set)*/
 SELECT
         DISTINCT a.actor_id,
         CONCAT(a.first_name, ' ', a.last_name) AS actor_name
     FROM actor a
     JOIN film_actor fa    ON a.actor_id = fa.actor_id
     JOIN film_category fc ON fa.film_id = fc.film_id
     JOIN category c       ON fc.category_id = c.category_id
     WHERE c.name = 'Action'
 
 EXCEPT
 
 /*-- Actors who appeared in at least one Comedy film (exclusion set)*/
 SELECT
         DISTINCT a.actor_id,
         CONCAT(a.first_name, ' ', a.last_name) AS actor_name
     FROM actor a
     JOIN film_actor fa    ON a.actor_id = fa.actor_id
     JOIN film_category fc ON fa.film_id = fc.film_id
     JOIN category c       ON fc.category_id = c.category_id
     WHERE c.name = 'Comedy'
     ORDER BY
         actor_name ASC;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 