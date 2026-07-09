-- create a list of employeee
CREATE PROCEDURE 
    GetEmployees()
BEGIN
    SELECT
        firstName,
        lastName,
        city,
        state,
        country
    FROM 
        employees
    INNER JOIN 
        offices 
    USING 
        (officeCode);

END;


--Get all orders for a specific customer.
CREATE PROCEDURE 
    GetCustomerOrders(
                      IN p_customer_id INT
                      )
BEGIN
    SELECT 
        *
    FROM 
        orders
    WHERE 
        customerNumber = p_customer_id;
 
END;


--create a high spensing customer
CREATE PROCEDURE
    Highspender(
                IN name_id VARCHAR(50))
BEGIN
    SELECT
        c.customerNumber,
        c.customerName,
        SUM(p.amount) AS total_spent
    FROM
        customers c
    JOIN
        payments p
    ON
        p.customerNumber = c.customerNumber
    WHERE
        c.customerName = name_id
    GROUP BY
        c.customerNumber,
        c.customerName
    HAVING
        SUM(p.amount) > 100000
    ORDER BY
        total_spent DESC;

END;



-- 
CREATE PROCEDURE GetOfficeByCountry(
    IN countryName VARCHAR(255)
)
BEGIN
    SELECT *
    FROM offices
    WHERE country = countryName;
END;
























