/* Date and Timestamp Format Conversions */

-- select current date 

select current_date;

select localtimestamp;

select current_timestamp;

select now();

--function to return timestamp 

select current_time;

select localtime;

--truncate a date 

SELECT date_trunc('year','2025-08-22 22:19:58'::timestamp);

SELECT date_trunc('day','2025-08-22 22:19:58'::timestamp);

SELECT date_trunc('hour','2025-08-22 22:19:58'::timestamp);

SELECT date_trunc('week','2025-08-22 22:19:58'::timestamp);


--date_part function 

SELECT date_part('day', CURRENT_TIMEstamp);
select date_part('month', current_timestamp);
select date_part('year', current_timestamp);

--extract function to etract day, time, and hour 
select extract('day' from current_timestamp);
select extract ('hour' from current_timestamp);

--using to_char function to extract days in character 
select to_char(current_timestamp, 'day');
SELECT to_char(current_timestamp, 'month');


--creating a date format using the make_date, makedate, date_from_parts, or date fromparts function.
select make_date(1977, 10, 26);
SELECT to_date(concat(2020,'-',09,'-',01), 'yyyy-mm-dd');


/* DATE MATH */ 

--selecting days from interval 
select date('1977-10-26') - date('2025-08-26') as days;

select  date('2025-08-01') - date('2025-08-26') as days;-- sutracting the date in reverse order

select  date('2025-08-26') - date('2025-08-01') as days; -- we cant change the order too to avoid negative 


--Aside the above function, we can also use 'age function' 

SELECT age(date('2020-05-31'), date('2020-06-30')) as days;

-- extract days, months, and years from a date intrval 
SELECT age(date('2025-10-25'), date('1977-10-26')) as years;

-- combing the code toghere
select extract (days from age(date('2025-10-25'), date('1977-10-26'))) as years;


-- Method 1: Extract years from AGE function
SELECT EXTRACT(year FROM AGE(DATE('2025-10-25'), DATE('1977-10-26'))) AS years;

-- Method 3: Get complete age breakdown
SELECT 
    EXTRACT(years FROM AGE(DATE('2025-10-25'), DATE('1977-10-26'))) AS years,
    EXTRACT(months FROM AGE(DATE('2025-10-25'), DATE('1977-10-26'))) AS months,
    EXTRACT(days FROM AGE(DATE('2025-10-25'), DATE('1977-10-26'))) AS days;


-- Dates interval 
 select date('1977-10-26') + interval '48 years' as new_age;


/* TIME MATH */

-- We can add interval to time 
SELECT time '05:00' + interval '3 hours' as new_time;

-- we can subtract interval from time too 
SELECT time '05:00' - interval '3 hours' as new_time;

-- mutltiplication of time and interval 
SELECT time '05:00' * 2 as time_multiplied;

--Intervals can also be multiplied, resulting in a time value:
SELECT interval '1 second' * 2000 as interval_multiplied;


/* THE RETAIL SALES DATA SET */


-- Trend of monthly retail and food services sales
SELECT 
    sales_month , 
    sales 
FROM 
    retail_sales 
WHERE 
    kind_of_business = 'Retail and food services sales, total';
    
-- Trend of yearly total retail and food services sales   
SELECT 
    date_part('year',sales_month) AS sales_year , 
    SUM(sales)                    AS sales 
FROM 
    retail_sales 
WHERE 
    kind_of_business = 'Retail and food services sales, total' 
GROUP BY 
    1; 
    
-- Comparing components
SELECT 
    date_part('year',sales_month) AS sales_year , 
    kind_of_business,
    SUM(sales) AS sales 
FROM 
    retail_sales 
WHERE 
    kind_of_business in ('Book stores' ,'Sporting goods stores','Hobby, toy, and game stores')
GROUP BY 
    1, 2; 
    
-- Monthly trend of sales at women’s and men’s clothing stores
SELECT 
    sales_month , 
    kind_of_business , 
    sales 
FROM 
    retail_sales 
WHERE 
    kind_of_business IN ('Men''s clothing stores' , 
                         'Women''s clothing stores');
                         
-- using case
SELECT 
    sales_month , 
    kind_of_business , 
    sales,
    CASE
    WHEN sales >= 1000 then 'high_sales'
    when sales <= 500 then 'low_sales'
    else 'mid_sales'
    end as insight 
FROM 
    retail_sales 
WHERE 
    kind_of_business IN ('Men''s clothing stores' , 
                         'Women''s clothing stores');


-- extract the year aggregates for two columns 
SELECT
    date_part('year',sales_month) AS sales_year ,
    kind_of_business ,
    SUM(sales) AS sales
FROM 
    retail_sales
WHERE 
    kind_of_business IN ('Men''s clothing stores' ,
                         'Women''s clothing stores')
GROUP BY 
    sales_year, 
    kind_of_business



-- grouping data base on pattern 

SELECT
    date_part('year',sales_month) AS sales_year ,
    sum(CASE when kind_of_business = 'Women''s clothing stores' then sales
        end) as women_sales, 
    sum(CASE when kind_of_business = 'Men''s clothing stores' then sales
        end) as men_sales
FROM 
    retail_sales
WHERE 
    kind_of_business IN ('Men''s clothing stores' ,
                         'Women''s clothing stores')
GROUP BY 
    sales_year



select *
from retail_sales 
limit 100






































