SELECT 
    first_name, 
    last_name, 
    salary
FROM 
    employees
WHERE 
    salary >
    (   SELECT 
            salary
        FROM 
            employees
        WHERE 
            last_name ='Bull');

