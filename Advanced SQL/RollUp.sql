/* 
we have a select, and what we are selecting is
extraction of the year, month, day, and sum of orderline quantity
how much was sold on the year, month, and days available, but the interesting part is
what if i wanted to know, how much did i sell on each day, and then how much did i sell on
each month, and then how much did i sell on each year, and i wanted it to be a progressive set
so meaning i want to know each individual day by year and month
then know each every month by year
and every individual year the total quantity, what was sold



*/


SELECT EXTRACT(YEAR FROM orderdate) AS "YEAR", 
       EXTRACT(MONTH FROM orderdate) AS "MONTH",
       EXTRACT(DAY FROM orderdate) AS "DAY",
       SUM(ol.quantity)
FROM orderlines As ol
GROUP BY
    GROUPING SETS(
        (EXTRACT(MONTH FROM orderdate)), -- BY YEAR

        (  -- BY YEAR AND MONTH
            EXTRACT (YEAR FROM orderdate),
            EXTRACT (DAY FROM orderdate)
        ),

        (   -- BY YEAR MONTH DAY
            EXTRACT(YEAR FROM orderdate),
            EXTRACT (MONTH FROM orderdate),
            EXTRACT (DAY FROM orderdate)
        ),

        (   -- BY MONTH DAY
            EXTRACT (MONTH FROM orderdate),
            EXTRACT (DAY FROM orderdate) 
        ),

             -- BY MONTH
            (EXTRACT (MONTH FROM orderdate)),
            -- BY DAY
            (EXTRACT (DAY FROM orderdate)),
            () -- THE TOTAL QUANTITY WE SOLD ACROSS ALL TIME

    )
ORDER BY    
   EXTRACT (YEAR FROM orderdate),
   EXTRACT (MONTH FROM orderdate),
   EXTRACT (DAY FROM orderdate);


/* 
ROLL UP 
IT WILL TAKE A GROUP AND IT WILL MAKE ALL OF EXTRACTION BY ITSELF.
it's going to basically say, hey, this is the group you're giving me to roll up.
So what I'm going to do is I'm going to do it by month, then year.
Then I'm going to do it by year month.
Then I'm going to do it by year and so forward and so forth.
It's going to basically make all of those combinations up until nothing.
what rollup does is it's going to take these three things and it's going to make every possible
combination between these three things.

This is commonly used for analysis over hierarchical data; e.g., total salary by department, 
division, and company-wide total.
*/

SELECT EXTRACT(YEAR FROM orderdate) AS "YEAR", 
       EXTRACT(MONTH FROM orderdate) AS "MONTH",
       EXTRACT(DAY FROM orderdate) AS "DAY",
       SUM(ol.quantity)
FROM orderlines As ol
GROUP BY
    ROLLUP(
       
            EXTRACT(YEAR FROM orderdate),
            EXTRACT (MONTH FROM orderdate),
            EXTRACT (DAY FROM orderdate)
    )
ORDER BY    
   EXTRACT (YEAR FROM orderdate),
   EXTRACT (MONTH FROM orderdate),
   EXTRACT (DAY FROM orderdate);