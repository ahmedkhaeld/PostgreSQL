/*
what if you want to store the results of a query?
what if you want to restore the results and reuse them at a later time or query against them?
what if you want to query the results of a query?

views allows you to store and query previously run queries
## are the output of the query we ran
## acts like a table you can query them
## takes very little space to store, we only store the definition fo a view not all of the data 
it returns.

there are 2 types of views: 
MATERIALIZED AND NON-MATERIALIZED

NON-MATERIALIZED VIEW:
QUERY GETS RE-RUN EACH TIME THE VIEW IS CALLED ON.
so we storing a reference to the query. but we re-run it each time that we're calling the view.
we're not storing the results

MATERIALIZED VIEW: 
SOTRES THE DATA PHYSICALLY AND PERIODICALLY UPDATES IT WHEN TABLES CHANGE
So if you insert update, delete data from your table periodically, 
the view is going to look at whatever happened and it's going to update whatever it's stored for 
you for when the table changes.
*/

-- CREATING A VIEW:
create view view_name as query;
--UPDATING A VIEW:
create or replace <view_name> as query;
-- RENAME A VIEW
alter view <view_name> rename to <view_name>;
--DELETING A VIEW:
drop view [if exists] <view_name>;

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