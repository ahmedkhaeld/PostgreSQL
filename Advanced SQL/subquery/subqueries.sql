/* 
WHAT IS A SUBQUERY?
A CONSTRUCT THAT ALLOWS YOU TO BUILD EXTREMELY COMPLEX QUERIES.
AN INNER QUERY OR INNER SELECT. MORE OFTEN FOUND IN THE WHERE CLAUSE.
YOU CAN ALSO USE IT IN THE SELECT, FROM, AND HAVING CLAUSE.
with sub queries is the ability to utilize other queries inside of 
our current query to build stronger, more complex queries.


SO IF YOU USE IT TO QUERY DIFFERENT TABLES... HOW IS IT DIFFERENT FROM JOINS
both combine data from different tables 
but subqueries are queries that could stand alone, that can return a single result or a row set 

joins are part of the query, combine rows from one or  more tables based on a match condition
can only return a row set 
*/
-- INSIDE WHERE CLAUSE SYNTAX:
SELECT * FROM <TABLE>
WHERE <COL> <CONDITION> (
    SELECT <COL>, <COL> ,...
    FROM <TABLE>
    [WHERE | GROUP BY| ORDER BY|...]
)

-- INSIDE SELECT STATEMENT: IT MUST RETURNS SINGLE RECORD
SELECT (
    SELECT <COL>
    FROM <TABLE>
    [WHERE | GROUP BY| ORDER BY|...]
)
FROM <TABLE> AS <NAME>

-- INSIDE FROM: THIS LOOKS LIKE SELECT FROM A VIEW
SELECT * 
FROM (
    SELECT <COL>, <COL>,...
    FROM <TABLE>
    [WHERE | GROUP BY| ORDER BY|...]
) AS <NAME> 

-- INSIDE HAVING: 
SELECT * FROM <TABLE>
GROUP BY <COL>
HAVING (
    --MUST RETURN SINGLE RECORD
    SELECT <COL>
    FROM <TABLE>
    [WHERE | GROUP BY| ORDER BY|...]
) > X


select title, 
      price, 
      --here must return single result
      (select avg(price) from products) as "global avg price"
from 
    -- in from return multiple results
    (select * from products where price < 10) as "products sub"



-- USING SUBQUERIES: SHOW ALL THE EMPLOYEES OLDER THAN THE AVG AGE   
select first_name, last_name, birth_date,
       age(birth_date) , 
      (select avg(age(birth_date)) from employees)
from employees  
where age(birth_date) > (select avg(age(birth_date)) from employees where gender = 'M')

-- SHOW THE TITLE BY SALARY FOR EACH EMPLOYEE
--using subquey      
select emp_no, 
       salary,
       from_date,
     -- we can reference an outer in inner query but not the opposite. 
     (select title from titles as t where t.emp_no=s.emp_no and t.from_date=s.from_date)
from salaries as s
order by emp_no;

-- by a left outer join, also is faster than the subquery.
select emp_no, salary, from_date, t.title 
from salary as s
left outer join titles a s t using(emp_no, from_date)
order by emp_no

-- by normal join.
select emp_no, salary, from_date, t.title 
from salary as s
join titles a s t using(emp_no, from_date)
order by emp_no
-----------------------------------------------------------------------------
/* 
getting the latest salaries
subquery: ffewer steps but less performance
how
as where clasue of the subquery is going on each individual record
it is calcualte a subplan
planning time about 0.2
execution time about 18 
*/
-- here took about 18 seconds 
 exlain analyze
select emp_no,
      salary as "most recent salary",
      from_date 
from salaries as s 
where from_date =(
   select max(from_date)
   from salaries as sp 
   where sp.emp_no= s.emp_no
   )
 order by emp_no asc  
 ----------------------  
 -- join a view
 exlain analyze 
 select emp_no,
      salary as "most recent salary",
      from_date 
from salaries as s 
join last_salary_change as ls using (emp_no)
where from_date= ls.max 
 order by emp_no asc  
 --------------------------------------
 -- combine a subquery with a join this query took much less time 
 select emp_no,
      salary as "most recent salary",
      from_date 
from salaries as s 
join (
   select emp_no, max(from_date) as "max"
   from salaries as sp 
   group by emp_no
   ) as ls using (emp_no)
where ls.max=from_date
 order by emp_no asc 