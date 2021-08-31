/* 
operators that can be used to apply in the where clause of sub queries,
and the whole point of these operators is that they'll give you the ability to know
how to operate against multi-column multi-row single-row sub queries.
*/

--EXISTS
/* 
check if the sub query returns any rows.
can you show me all of the customers that make a certain amount of money that have ordered from 
us over certain amount so i could target them with specific ads
*/
select firstname, lastname, income 
from customer as c 
where exists (
     select * 
     from orders as o 
     where c.customerid=o.customerid and totalamount>400
)and income >90000

-- IN OPERATOR
/* 
check if the value is equal to any of the rows in the return (null yields null)
*/
select prod_id 
from products 
where category in (
      select category from categories
      where categoryname in ('Comedy', 'Family', 'Classics')
      )

-- NOT IN OPERATOR
/* 
check if the value is NOT equal to any of the rows in the return (null yields null)
show me everything other than comedy, family, and classics
*/
select prod_id 
from products 
where category in (
      select category from categories
      where categoryname NOT IN ('Comedy', 'Family', 'Classics')
      )

-- ANY/SOME
/* 
CHECK EACH ROW AGAINST THE OPERATOR AND IF ANY COMPARISON MATCHES RETURN TRUE  
*/
select prod_id 
from products 
where category =ANY (
      select category from categories
      where categoryname  IN ('Comedy', 'Family', 'Classics')
      )

-- ALL 
/* 
CHECK EAHC ROW AGAINST THE OPERATOR AND IF ALL COMPARISONS MATCH RETURN TRUE
 
*/
SELECT prod_id, title, sales 
from products 
join inventory as i using (prod_id)
where i.sales> all (
      select avg(sales) from inventory 
      join products as p1 using (prod_id)
      group by p1.category
    )

-- SINGLE VALUE COMPARISON  
/*
subquery must return single row 
checked comparator against single row
 */ 
SELECT prod_id 
from products 
where category = (
     select category from categories 
    where categroryname in ('Comedy')
)