-- 1. Write a MySQL query to find the name (first_name, last_name) and the salary of the employees 
-- who have a higher salary than the employee whose last_name='Bull'.
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

