/* Chapter 3 */

-- question 1
select prod_id, prod_name, prod_price
from products
where prod_price = 9.49;


/* question 2 */ 
select prod_id, prod_name, prod_price
from products
where prod_price >= 9.49;

/*question 3*/ 

SELECT DISTINCT order_num
from orderitems
where order_num >=100


-- question 4;

select
      prod_name, prod_price
from products
where prod_price between 3 and 6
order by prod_price;










