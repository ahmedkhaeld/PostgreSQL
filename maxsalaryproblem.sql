/*
get me the most recent date that employees got a salary bump(max salary)
here try this 
make a group of emp_no and salary
10001 60117 1986-06-26
10001 62102 1987-06-26
10001 66074 1988-06-25
here each combination of emp_no and salary form a unique group that has only indivdual from_date
so this does not make it max from_date
 */
 select emp_no, salary, max(from_date)
 from salaries
 group by emp_no, salary


 /* lets try to remove the salary from the group 
 here we grouped by emp_no and applied max(from_date) to each group 
10001 2002-06-22
10002 2001-08-02
10003 2001-12-01
10003 2001-11-27
now the question how to get the salary that correlate to that most recent from_date

 */
  select emp_no,  max(from_date)
 from salaries
 group by emp_no




/*
a perfect scenario to get max salary correlated correct to most recent from_date
is salary is increasing progressivly forward.
so recent from_date has max salary 
this done by this query.
 */
select emp_no, max(from_date), max(salary)            
from salaries
group by emp_no


/* but what if we are not so sure that salary  is progressive forward with from_date 
10001 60117 1986-06-26
10001 62102 1987-06-26
----------------------
10002 60000 1986-06-26
10002 50000 1987-06-26
----------------------
10003 80000 1986-06-26
10003 90000 1987-06-26
*/

-- still the question how to get the most recent max salary

select distinct e.emp_no, e.first_name, e.last_name,
                d.dept_name,
                   LAST_VALUE(s.from_date) over(
                    partition by e.emp_no 
                    order by s.from_date
                    range between unbounded preceding and unbounded following
                ),
                LAST_VALUE(s.salary) over(
                    partition by e.emp_no 
                    order by s.from_date
                    range between unbounded preceding and unbounded following
                ) as "current salary"
from salaries as s 
join employees as e using(emp_no)
join dept_emp as de using(emp_no)
join departments as d using(dept_no)
order by emp_no;

--USING VIEWS:
/* 
GETTING THE MOST RECENT SALARY OF AN EMPLOYEE
create view to have a last salary change.
from here we could make a queries on the view
*/

CREATE VIEW last_salary_change AS 
SELECT e.emp_no,
       max(s.from_date)
FROM salaries as s  
join employees as e using(emp_no)
join dept_emp as de using(emp_no) 
join departments as d using(dept_no)
group by e.emp_no  
order by e.emp_no;
-------------------------------------------
select * from salaries
join last_salary_change as l using(emp_no)
where from_date=l.max
order by emp_no;