--GROUP BY 
/* 
 what if you wanted to do that on department basis?
What if you wanted to group your data into logical groups?
let's say by department, by salary, category by gender?
Group by group by is a keyword that is used to summarize or aggregate data by groups.
Grouping data into logical buckets allows us to operate against those buckets individually.

why would you group data?
And the answer is to get in-depth information by group.
We want to get that in-depth knowledge, that specific information by that group, again, for instance,
by department, the salaries by department or the amount of employees by department, 
or the total amount of salaries paid by department.
I really need to know it by department or by start date, like grouping them by like year of start.
When did we hire the most expensive employees

How does it work? What does it look like?
So group by split's data into groups or chunks, so we can apply functions against a group 
rather than the entire table.

Now let's take a look at what that looks like.
because and we learned that count sum min max, they just they return one record
we want to know the total amount of employees by department.
when we do group by department, it group all the employees of each similar department into one group
now we could apply count on department group to get the employees number for that group 

So if we group these by department number.
What we're going to see is that, OK, we're getting groups so D1, D2, D3 these three interesting.
So group the data, it took every single department in the group that by department number
So every single employee that was in department one is now in this logical group.

Think about it this way.
What we basically did is we said, hey, group it by the department number.
So every time I find these zero zero one, which is unique, just put that record in that bucket.

the power of group by is when we create these groups, the purpose of it 
is to run functions against some other part of the data.
We use group buy exclusively or almost exclusively with the aggregate functions, with sum min max count, etc

HOW DEOS IT WORK?
look at split-apply-combine.png image
GROUP BY UTILIZES A SPLIT-APPLY-COMBINE STARTEGY 
split the similar record horizontally to groups, 
to get a column of repeated similar data, attached with column of different data 
applly an aggregate function to the data on the column of different data, so output of one record
combine every group with its output from the aggregate function

*/
-- count for me every employee in each department.
SELECT dept_no, COUNT(emp_no) 
FROM dept_emp
GROUP BY dept_no;


--find the number of payment transactions that each staff has been processed.
select staff_id, COUNT(payment_id)
FROM payment
GROUP BY staff_id;

-- count total amount that each customer has been paid.
select customer_id, SUM(amount) 
FROM payment    
GROUP BY customer_id;

--GROUP BY with multiple columns.
SELECT 
	customer_id, 
	staff_id, 
	SUM(amount) 
FROM 
	payment
GROUP BY 
	staff_id, 
	customer_id
ORDER BY 
    customer_id;
/*
group by cluase divides the rows in the payment table by the values in the 
customer_id and staff_id columns. for each group of (customer_id, staff_id),
the SUM() calculates the total amount.
 */

 -- GROUP BY clause with the JOIN clause

 /*
 unlike the previous example, this query joins payment table with the customer table
 and group customers by thier names.
  */
 SELECT
	first_name || ' ' || last_name full_name,
	SUM (amount) amount
FROM
	payment
INNER JOIN customer USING (customer_id)    	
GROUP BY
	full_name
ORDER BY amount DESC;	








/*
IMPORTANT NOTE: ORDER OF OPERATIONS IS LIKE THIS.
FROM > WHERE > GROUP BY > SELECT > ORDER
*/


--HAVING
/*
what if i want to filter out groups
there is keyword HAVING it's added after group by, applies filters to a group as a whole
FROM > WHERE > GROUP BY > HAVING > SELECT > ORDER

HAVING is similar to WHERE, the difference is that
WHERE applies filters to individual rows
HAVING applies filters to a groups as a whole

When we apply aggregate functions against a group, the having class can filter against the output of
that aggregate function.
 */
 SELECT
	column1,
	aggregate_function (column2)
FROM
	table_name
GROUP BY
	column1
HAVING
	condition;

/* 

payment table 
(*payment_id, customer_id,staff_id, rental_id, amount, payment_date)
--find the total amount of each customer: only customers who have been spending more than 200
*/
SELECT
	customer_id,
	SUM (amount)
FROM
	payment
GROUP BY
	customer_id
HAVING
	SUM (amount) > 200;


/* 

customer table
(*customer_id, store_id, first_name, last_name, email, address_id, activebool, create_date)
find the number of customers per store:
clause to select the store that has more than 300 customers:

*/
SELECT
	store_id,
	COUNT (customer_id)
FROM
	customer
GROUP BY
	store_id
HAVING
	COUNT (customer_id) > 300;



--example
/*
let's play around this query, here we are trying to select the department name 
and count employees of each department
note: in employees we don't have the departments name, so we do two joins 
we are grouping by departments name, so in each group name count the employees it contains
our clauses are: 
filter 1: get all female employees in each department
filter 2: filter out the departments that have over 25000 female employees

dept_name and emp_no these two will form the header of each group  
so the group by and having will be using only those two fields 
   
if you want to put the gender filter in having it must be added in the group
so HAING can operate the filter on those fields withing the groups

 */

select d.dept_name, COUNT(e.emp_no) as " # of employees"
from employees as e
inner join dept_emp as de ON de.emp_no= e.emp_no
inner join departments as d ON de.dept_no =d.dept_no
where e.gender='F' 
group by d.dept_name
having count(e.emp_no > 25000)
order by COUNT(e.emp_no) desc;

/*
*  How many people were hired on did we hire on any given hire date?
*  Database: Employees
*  Table: Employees
*/

SELECT hire_date, COUNT(emp_no) as "amount"
FROM employees
GROUP BY hire_date
ORDER BY "amount" DESC;

/*
*  Show me all the employees, hired after 1991 and count the amount of positions they've had
*  Database: Employees
*/

SELECT e.emp_no, count(t.title) as "amount of titles"
FROM employees as e
JOIN titles as t USING(emp_no)
WHERE EXTRACT (YEAR FROM e.hire_date) > 1991
GROUP BY e.emp_no
ORDER BY e.emp_no; 





/* 
GROUP BY
how to work with?
what kind of questions we can answer?
where some of the limitations are? 
e.g get me the most recent date that employees got a salary bump(max salary)
here is situation 
some times we need to combine multiple grouping to correlate the result of each grouping to
another. the want query is valid result with no conflict.

 combining multiple results from multiple selects.
 when we get data sets back, we can combine those data sets.
 We can combine the results of multiple selects into an output.

 Union is one of those powerful things where if you want to run multiple queries 
 and combine the results into one table, it can help you do that.

SELECT <COL1>, SUM(COL2) 
FROM TABLE
GROUP BY COL1  
UNION
SELECT SUM(COL2) 
FROM TABLE
what this union is going to do is it's going to take the result from first and it's going to take
the results from second and it's going to merge them 
so that you can see this result inside of the same dataset.

also you can do UNION ALL, which does not remove duplicate records
*/

/*
top_rated_films table                      most_popular_films table
title                    release_year      title                    release_year
The Shawshank Redemption 1994              An American Pickle       2020
The Godfather            1972              The Godfather            1972
12 Angry Men             1957              Greyhound                2020
 */
SELECT * FROM top_rated_films
UNION
SELECT * FROM most_popular_films;

/* 
title                    release_year 
An American Pickle       2020
Greyhound                2020     
The Shawshank Redemption 1994              
The Godfather            1972          
12 Angry Men             1957            
*/




-- first select, get the sum of NULL in the prod_id
-- second select get the total quantity of solid items for each product
select null as "prod_id", sum(ol.quantity)
from orderlines as ol 
union 
select prod_id as "prod_id", sum(ol.quantity)
from orderlines as ol 
group by prod_id 
order by prod_id desc;

/*what if i want to show the result of multiple groupings in one query.
GROUPING SETS
allows to combine the outputs of multiple groupings
GROUPING SETS works as the same way as UNION would
a subclause of group by that allows you to define multiple groupings
*/
-- groug set of nothing and group set of prod_id  
select prod_id as "prod_id", sum(ol.quantity)
from orderlines as ol 
group by 
   GROUPING SETS(
       (),
       ( prod_id )
   )
order by prod_id desc;


/* 
=> SELECT * FROM items_sold;
 brand | size | sales
-------+------+-------
 Foo   | L    |  10
 Foo   | M    |  20
 Bar   | M    |  15
 Bar   | L    |  5
(4 rows)
QUERY
get the sales of each brand, sales of each size, overall sales=()
*/
=> SELECT brand, size, sum(sales) 
FROM items_sold 
GROUP BY 
GROUPING SETS 
     ((brand), (size), ());
/*
 brand | size | sum
-------+------+-----
 Foo   |      |  30
 Bar   |      |  20
       | L    |  15
       | M    |  35
       |      |  50
(5 rows)
 */