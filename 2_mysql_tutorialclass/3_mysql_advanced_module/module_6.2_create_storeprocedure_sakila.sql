
-- create a proedure Scenario: Find all films by rating
CREATE PROCEDURE 
    GetFilmsByRating(
                     IN filmRating VARCHAR(10)
                     )
BEGIN
    SELECT
        film_id,
        title,
        rating,
        release_year,
        rental_rate
    FROM 
        film
    WHERE 
        rating = filmRating
    ORDER BY 
        title;
 
END;


--Scenario: Find customers by city and country
CREATE PROCEDURE
    GetCustomersByLocation(
                           IN cityName    VARCHAR(50),
                           IN countryName VARCHAR(50)
                           )
BEGIN
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        ci.city,
        co.country,
        c.email
    FROM
        customer AS c
    INNER JOIN
        address a
    ON
        c.address_id = a.address_id
    INNER JOIN
        city ci
    ON
        a.city_id = ci.city_id
    INNER JOIN
        country co
    ON
        ci.country_id = co.country_id
    WHERE
        ci.city = cityName
    AND co.country = countryName;

END; 











































      
      
      
      