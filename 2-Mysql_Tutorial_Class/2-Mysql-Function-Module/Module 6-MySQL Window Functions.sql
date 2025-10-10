CREATE TABLE sales(
    sales_employee VARCHAR(50) NOT NULL,
    fiscal_year INT NOT NULL,
    sale DECIMAL(14,2) NOT NULL,
    PRIMARY KEY(sales_employee,fiscal_year)
);

INSERT INTO sales(sales_employee,fiscal_year,sale)
VALUES('Bob',2016,100),
      ('Bob',2017,150),
      ('Bob',2018,200),
      ('Alice',2016,150),
      ('Alice',2017,100),
      ('Alice',2018,200),
       ('John',2016,200),
      ('John',2017,150),
      ('John',2018,250);

SELECT * FROM sales;

SELECT
    SUM(sale)
FROM
    sales;


SELECT
    fiscal_year,
    SUM(sale)
FROM
    sales
GROUP BY
    fiscal_year;
    
    
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(30),
    salary DECIMAL(10,2),
    hire_date DATE
);

INSERT INTO employees VALUES
(1, 'John', 'Finance', 70000, '2020-01-10'),
(2, 'Mary', 'Finance', 60000, '2021-03-05'),
(3, 'Alex', 'IT', 90000, '2019-07-14'),
(4, 'Kate', 'IT', 85000, '2020-09-18'),
(5, 'Emma', 'HR', 50000, '2021-11-01'),
(6, 'Liam', 'HR', 55000, '2018-12-22'),
(7, 'Noah', 'Finance', 65000, '2022-04-09'),
(8, 'Olivia', 'IT', 88000, '2023-06-02');


SELECT
    department,
    employee_name,
    salary,
    AVG(salary) OVER (PARTITION BY department) AS dept_avg_salary
FROM employees;


DROP TABLE sales_data;


CREATE TABLE sales_data (
    order_id INT PRIMARY KEY,
    customer_id VARCHAR(10),
    region VARCHAR(20),
    order_date DATE,
    quarter VARCHAR(2),
    sales DECIMAL(10,2)
);

INSERT INTO sales_data VALUES
(101, 'C1', 'North', '2024-01-01', 'Q1', 5000),
(102, 'C1', 'North', '2024-02-05', 'Q1', 3000),
(103, 'C1', 'North', '2024-03-10', 'Q1', 4000),
(104, 'C2', 'South', '2024-04-03', 'Q2', 6000),
(105, 'C2', 'South', '2024-05-07', 'Q2', 8000),
(106, 'C3', 'West', '2024-06-02', 'Q2', 7000),
(107, 'C3', 'West', '2024-07-06', 'Q3', 5000),
(108, 'C3', 'West', '2024-08-09', 'Q3', 9000);


SELECT * FROM sales_data

SELECT
    region,
    quarter,
    SUM(sales) OVER (PARTITION BY region) AS total_sales_region
FROM sales_data;
