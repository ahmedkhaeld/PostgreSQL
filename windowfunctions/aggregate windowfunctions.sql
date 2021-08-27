-- SUM  
/* 
SUM THE VALUES WITHIN A GROUP DEPENDING ON THE FRAMING
i want to know how much cumulatively a customer has ordered at our store


So we're taking the window data that we got and we're going to partition it by customer ID 
So we're creating a partition by the customer and then we're going 
to order it by the order ID and by doing that, by creating that partition by customer id and 
just ordering it by the order ID, we can now cumulatively sum the amount that they spent.
So it's going to go by order ID. So it's going to go look at the previous 
and then take the current and some of those all together.

the way that you combined partition in order
can create interesting results because we're partitioning by the customer, this is the group 
and then we're saying ordered by the order ID so the individual or ID.
Then, when we sum this, we're going to take into account the previous and the current.
*/
select 
   o.orderid, 
   o.customerid,
   o.netamount, 
   sum(o.netamount) over(
       partition by o.customerid 
       order by o.orderid
   ) as "customer orders"
from orders as o
order by o.customerid
------------------------------------------------------
-- ROW_NUMBER() 
/* 
it doesn't take into account framing. It doesn't matter what you put there.

So what if I want to know where my product is positioned in the category by price?

*/
select prod_id,  
       price,
       category,
       row_number() over(
           partition by category order by price 
       ) as "postion in category by price" 
from products;