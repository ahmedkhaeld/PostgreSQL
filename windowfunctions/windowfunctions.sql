/* 
how do we apply functions against a set of rows related to the current row?
how do we take the calculation that we can do against a group and show it against a current row?

example: what if you wante to know the average salary per depratment?
that is easy 
add the average to every salary so we could visually see how much each employee is 
from the average.
like, this is my salary this the average salary for my department, how far off i am from that
HOW DO WE THAT?
WELCOME TO WINDOW FUNCTIONS!
window functions creates a new column based on funcitons performed on a subset 
or "window" of the data(the data we requested)
If you request 10 million records, the window function applies against each individual row.
*/
--SYNTAX
window_function(arg1, arg2,...) over(
    [PARTITION BY partition_expression] 
    [ORDER BY sort_expression [ASC| DESC] [NULLS {FIRST| LAST}]]
)

-- apply window function to get the max salary and show it beside each individual salary
select 
emp_no,
salary,
 max(salary) over()
 from salaries;

-- limit shows top 100 records, but still window function against all the records not only 100
select 
emp_no,
salary,
 max(salary) over()
 from salaries
 LIMIT 100;

-- the query here filter less than 7000, the window function runs against that filter
 select 
emp_no,
salary,
 max(salary) over()
 from salaries
 where salary <7000;

 /* 
 PARTITION BY
 divide rows into groups to apply the function against 
 */
----------------
 /*
  window function as normal without a partition, where we take the average salary
  over the entire window and we say average global salary.
  the average here calculated against all the departments then result avg for all of them.
  */
 select 
emp_no,
salary,
d.dept_name,
 avg(salary) over()
 from salaries
 join dept_emp as de using (emp_no)
 join departments as d using (dept_no )

/* 
 PARTITIONS
what if we want an avgerage for each department
using PARTITION BY: the window function will apply to each department and output an average
for each different deptartment
like group each department and calculate its average
The PARTITION BY clause 
divides rows into multiple groups or partitions to which the window function is applied.
*/
select 
emp_no,
salary,
d.dept_name,
 avg(salary) over(
     partition by d.dept_name
 )
 from salaries
 join dept_emp as de using (emp_no)
 join departments as d using (dept_no )

/*
here a partitions for eahc unique emp_no, a do a count salaries  for each partition,like
emp_no 10001 got a 17 salaries, 10002 got a 6 salaries.
 */
select emp_no, 
    count(salary) over(
      partition by emp_no)
from salaries;

 /* 
 ORDER BY: ORDER THE RESULTS
 The ORDER BY clause
 specifies the order of rows in each partition to which the window function is applied.
 within a window function, order by operated kind of strangely
 when we use order by, we're changing the lens at which we look at the frame.

 The frame clause doesn't apply to ranking functions. Also, the
 frame clause isn't required when no ORDER BY clause is used in
 the OVER clause for an aggregate function. If an ORDER BY
 clause is used for an aggregate function, an explicit frame clause is required.
 -->> When no ORDER BY clause is specified, the implied frame is
 unbounded, equivalent to ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING.

  
 key                 |meaning                                     |
---------------------+--------------------------------------------+
* ROWS OR RANGE      | WHETHER YOU WANT A RANGE OR ROW AS A FRAME | 

* PRECEDING          | ROWS BEFORE THE CURRENT ONE                |  

* FOLLOWING          | ROW AFTER THE CURRENT ONE                  | 

* UNBOUNDED PRECEDING| RETURNS ALL BEFORE OR AFTER                |  
  OR FOLLOWING       |                                            | 
                                                                
* CURRENT ROW        | YOUR CURRENT ROW                           | 
  
-->> but when no frame clause is specified within ORDER BY, the implied frame by default is 
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
PARTITION BY category 
ORDER BY price RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
create a partition by category, order by price, and take that range or data that i just gave
you, and look at everything that came before and the current row
 */
 select emp_no, 
    count(salary) over(
      order by emp_no
      RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
from salaries;


/*
 what if we apply it to a partition by what would happen then?
Well, it depends on the partition you're going to do.
If we said partition by employee number, what would happen if we do that?
Because we said that order by with a partition is going to look solely inside of that partition.
Well, we can know now that it is going to act as if it was a normal partition by.
It's not going to add it to the previous because it's not taking into account
 anything that was in that previous partition.

 */
 select emp_no, 
    count(salary) over(
      partition by emp_no
      order by emp_no)
from salaries;

/*
partition by empo_no and order by salary, our order is the salary, here they are unique  
for partition emp_no 10001, no duplicate salaries, it is going to be cumulatively individaully

 */
 select emp_no, 
    count(salary) over(
      partition by emp_no
      order by salary)
from salaries;


/* 
Take everything into account before and after, and so what's going to happen here as we see?
 taking into account that whole partition 
 THIS QUERY IS EQUAL TO THE FIRST ONE.
 RUN ALL THESE QUERIES TO VISUALIZE THE OUTPUT.
*/

 select emp_no, 
    count(salary) over(
      partition by emp_no
      order by salary
      -- this frame clause is the default, if there is no ORDER BY defined
     RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
from salaries;
-- equal to this query
select emp_no, 
    count(salary) over(
      partition by emp_no)
from salaries;



