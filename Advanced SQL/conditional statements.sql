select a,
       case when a=1 then 'one' 
            when a=2 then 'two' 
            else 'other' 
        end  
from test;
--CASE STATEMENT 
/* 
case statement can be used in multiple places in a query
each return must be single output
*/
select o.orderid, 
       o.customerid, 
       CASE
         when o.customerid=1
         then 'my first customer'
         else 'not my first customer'
        end,
    o.netamount
from orders as o 
order by o.customerid;

--FILTERING IN A WHERE
/* 
conditional filter
if our customers ID, if he's above 10, so if he's beyond 10, then we're going
to only show the ones that spent less than one hundred dollars.
But if they're between one and 10, then we want to show the customers that spend more than 100

*/
SELECT 
     o.orderid, 
     o.customerid, 
     o.netamount
from orders as o   
where case 
     when o.customerid > 10 then o.netamount < 100 else o.netamout > 100 
      end
order by o.customerid;


-- IN AN AGGREGATE FUNCTIONS
/* 
USE CASE LIKE
if they spent less than 100$ a a gesture of good
*/
select 
    sum (
        case 
         when o.netamount < 100 then -100
         else o.netamount 
        end
    ) as "returns",
    sum(o.netamount) as "normal total" 
from orders as o;

-----------------------------------------------------------------------------------------------
--NULLIF
/* 
WHAT IS YOU WANT TO RETURN NULL IF A CONDITION IS MET?
e.g.if these two values match up, i just want to see null.
e.g fill empty spots with a null to avoid divide by zero issues
the way it works:
*/
NULLIF(0,0) --THIS MATCH RETURN NULL
NULLIF('ABC','DEF') --THIS DOES NOT MATCH SO RETRUN LEFT SIDE ABC