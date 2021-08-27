--fisrt value 

/*
return a value evaluated against the first row within its partion.
if we have some kind of group of data in a window
function or even the entire window, we're just going to grab the very, very first value.

i want to know how my price compares to the item with the lowest price in the same category
we're going to select product and price category, first value of price,
and then we're going to partitioned by category.
and then we're going to order by the price.
clause rang, since we want the lowest price, we have to order the entire partition 
from top to bottom in price, so that we're sure that we always get the first.

*/
select 
   prod_id,
   price,
   category,
   first_value(price) over(
       partition by category 
       order by price 
       range between unbounded preceding and unbounded following
   ) as "cheapest in category"
from products;
/*
how does that work?
look @ first_value windowfunction.png
Well, if we grabbed products and then we said we're grabbing the product, 
I need the price in the category
Well, if we grab our window function and we said, hey, I want to 
know the cheapest in the category,
so let me grab the window of data that we just had.let me go and sort them by category
And inside that category, I'm going to order them by price.
And because the window function works in a way where even though I'm using order by, 
it's going to evaluate everything that came before it.
I'm pretty sure that when it's ordering, I'm always with first value 
going to get the very, very lowest price
And because of that, if I matched the category, I'm creating the category 
and I'm sorting the category, hat means that I'm going to 
get the very first value of the price in that category.
 */


/*
alt, we could use min and it's better than first_value.
 */
select 
   prod_id,
   price,
   category,
   min(price) over(
       partition by category 
   ) as "cheapest in category"
from products;

---------------------------------------------------------
-- last_value:
/* 
i want to know how my price compares to the item with the highest price in the same catgegory

*/

select 
   prod_id,
   price,
   category,
   last_value(price) over(
       partition by category 
       order by price 
       range between unbounded preceding and unbounded following
   ) as "most expensive in category"
from products;

-- or
select 
   prod_id,
   price,
   category,
   max(price) over(
       partition by category 
   ) as "most expensive in category"
from products;