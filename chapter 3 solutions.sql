/* Write a SQL statement to retrieve all customer names (cust_names) from the Customers table, and display the results sorted from Z to A.*/

-- ascending 
select cust_name from customers
order by cust_name desc;


-- wothout descending 
select cust_name from customers
order by cust_name;


-- questions 2
select cust_id, order_num
from orders 
order by cust_id, order_num desc;


/*question 3*/

select quantity, item_price
from OrderItems
order by item_price;