

select 
      id,
      JSON_OBJECTAGG(first_name, last_name) as attributes
from student
group by id 
 
