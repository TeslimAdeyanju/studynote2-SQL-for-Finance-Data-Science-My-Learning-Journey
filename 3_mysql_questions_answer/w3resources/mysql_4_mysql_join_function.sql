   /*-- -- Database: HR_db*/
   /*-- 1. Write a MySQL query to find the addresses (location_id, street_address, city,state_province,*/
   /*-- country_name) of all the departments.*/
   Hint : USE NATURAL JOIN.
   SELECT
         LOCATION_ID,
         STREET_ADDRESS,
         CITY,
         STATE_PROVINCE,
         COUNTRY_NAME
      FROM HR_db.locations
      JOIN HR_db.countries
      USING (COUNTRY_ID)
   -- 2. Write a MySQL query to find the name (first_name, last name), department ID and name of
   -- all*/
   /*-- the employees.*/
   SELECT
         FIRST_NAME,
         LAST_NAME
      FROM HR_db.employees
      JOIN HR_db.departments
      USING (DEPARTMENT_ID)
   /*-- 3. Write a MySQL query to find the name (first_name, last_name), job, department ID and name -- of*/
   /*-- the employees who works in London.*/
   SELECT
         FIRST_NAME,
         LAST_NAME,
         JOB_ID,
         departments.DEPARTMENT_ID
      FROM HR_db.employees
      JOIN HR_db.departments
      USING (DEPARTMENT_ID)
      JOIN HR_db.locations
      WHERE CITY = 'London'
   -- 4. Write a MySQL query to find the employee id, name (last_name) along with their manager_id and name (last_name).
   SELECT
         e.EMPLOYEE_ID,
         e.LAST_NAME,
         m.manager_id,
         m.last_name
      FROM HR_db.employees AS e
      JOIN employees AS m
      USING MANAGER_ID
      WHERE m.MANAGER_ID IS NOT NULL;
   -- 5. Write a MySQL query to find the name (first_name, last_name) and hire date of the employees who was hired after 'Jones'.
   SELECT
         FIRST_NAME,
         employees.LAST_NAME
      FROM employees
      WHERE employees.FIRST_NAME LIKE '%Donald%'
      OR employees.FIRST_NAME LIKE '%Donald%';
   -- 6. Write a MySQL query to get the department name and number of employees in the department.
   SELECT
         DEPARTMENT_NAME,
         COUNT(*) AS dept_count
      FROM HR_db.employees
      JOIN HR_db.departments ON employees.DEPARTMENT_ID = departments.DEPARTMENT_ID
      GROUP BY
         DEPARTMENT_NAME
      ORDER BY
         dept_count;
   -- 7. Write a MySQL query to find the employee ID, job title, number of days between ending date and starting date for all jobs in department 90.
   SELECT
         EMPLOYEE_ID,
         job_title,
         end_date - start_date AS days
      FROM job_history
      JOIN jobs
      WHERE DEPARTMENT_ID = 90;
   -- 8. Write a MySQL query to display the department ID and name and first name of manager.
   SELECT
         e.FIRST_NAME,
         e.MANAGER_ID,
         d.DEPARTMENT_NAME
      FROM employees AS e
      JOIN HR_db.departments AS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;
   -- 9. Write a MySQL query to display the department name, manager name, and city.
   SELECT
         d.DEPARTMENT_NAME,
         e.FIRST_NAME,
         CITY
      FROM employees AS e
      JOIN departments AS d ON e.EMPLOYEE_ID = d.MANAGER_ID
      JOIN HR_db.locations
      USING (location_id);
   -- 10. Write a MySQL query to display the job title and average salary of employees.
   SELECT
         J.JOB_TITLE,
         ROUND(AVG(e.SALARY),2) AS average_salary
      FROM employees AS e
      JOIN jobs AS J
      USING (job_id)
      GROUP BY
         J.JOB_TITLE
      ORDER BY
         J.JOB_TITLE;
   -- 11. Write a MySQL query to display job title, employee name, and the difference between salary of the employee and minimum salary for the job.
   SELECT
         J.Job_title,
         CONCAT(E.FIRST_NAME, " ", E.LAST_NAME) AS full_name,
         (E.SALARY - J.MIN_SALARY) AS diff_salary
      FROM employees AS E
      JOIN jobs AS J
      USING (JOB_ID)
      ORDER BY
         full_name;
         
       
       
       
      -- 12. Write a MySQL query to display the job history that were done by any employee who is currently drawing more than 10000 of salary.
   SELECT
         E.EMPLOYEE_ID,
         E.FIRST_NAME,
         j.START_DATE,
         j.END_DATE,
         E.JOB_ID,
         E.DEPARTMENT_ID
      FROM employees AS E
      JOIN Job_history AS j
      USING (EMPLOYEE_ID)
      WHERE E.SALARY > 10000
      ORDER BY E.DEPARTMENT_ID;
      
      
   -- 13. Write a MySQL query to display department name, name (first_name, last_name), hire date,
   -- salary of the manager for all managers whose experience is more than 15 years.
   SELECT
         D.DEPARTMENT_NAME,
         CONCAT( E.FIRST_NAME, " ", E.LAST_NAME) AS name,
         E.HIRE_DATE,
         E.SALARY
      FROM employees AS E
      JOIN departments AS D
      USING (DEPARTMENT_ID)
 
 