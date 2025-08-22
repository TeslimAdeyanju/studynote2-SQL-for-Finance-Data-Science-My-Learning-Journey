--select current date 

select current_date;

select localtimestamp;

select current_timestamp;

select now()

--function to return timestamp 

select current_time

select localtime

--truncate a date 

SELECT date_trunc('year','2025-08-22 22:19:58'::timestamp);

SELECT date_trunc('day','2025-08-22 22:19:58'::timestamp);

SELECT date_trunc('hour','2025-08-22 22:19:58'::timestamp);

SELECT date_trunc('week','2025-08-22 22:19:58'::timestamp);



--date_part function 

SELECT date_part('day', CURRENT_TIME






