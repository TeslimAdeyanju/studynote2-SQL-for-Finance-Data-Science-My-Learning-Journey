select 
extract(month from paymentdate) as dayofweek,
sum(amount) as inflow,
row_number() over() as ser
from payments
group by dayofweek
order by dayofweek, ser
