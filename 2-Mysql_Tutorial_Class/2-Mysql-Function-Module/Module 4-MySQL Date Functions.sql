
/* MySQL ADDTIME() Function */


--add hours to the time 
select addtime('2023-10-23 14:30:00', '03:30:45');

-- Add minutes to the time 
SELECT ADDTIME('00:30:00', '00:15:00');

--  Using the ADDTIME() function with negative time intervals
SELECT ADDTIME('00:15:00', '-00:10:00');


/* MySQL DATE_ADD() Function */

select date_add('2025-12-10 23:10:23', interval 1 second) as time_taken;

-- adding day 
SELECT 
    DATE_ADD('1999-12-31 00:00:01',
        INTERVAL 1 DAY) result;    
        
        
        
        
--adding multiple day, time, and seconds 
SELECT 
    DATE_ADD('1999-12-31 23:59:59',
        INTERVAL '1:1' MINUTE_SECOND) result;
        
   
--     
        
        
