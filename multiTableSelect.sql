/* 
Multi table select
Multi table selects are combining the data from multiple tables in order to create a visualization
That can span relationships across tables

*/

Select a.emp_no, CONCAT(a.first_name, a.last_name) as "name", b.salary
From employees as a, salaries as b
Where a.emp_no = b.emp_no;


--JOINS
/*----------------------------------------------------------------
Combines columns from one table with those of another
Take a column from one table that can map to the column of another table  
Join aggregate data from two tables, but it does it based on taking one column from One table that can map to the column of another table   
Most common approach? Link primary key to foreign key

*/

--INNER JOINS
/*
join the rows that match
If you have a columns that links the column from table A to table B you can use inner join
It finds the intersection of two data sets based on a link and it returns a subset
If table a has a thousand records and table b has a thousand records and we link employee no
From table a to table b, and it’s a primary key to a foreign key relationship. And the intersection That find between both table will be showed
*/
--example: link table b to table a, and do it ON the emp_no 
/* 
when you say inner join, you're saying inner join salaries table to employess table and do it ON emp_no (ON what do i wan to join on)
*/
SELECT a.emp_no, CONCAT(a.first_name, ' ', a.last_name) as "name", b.salary
FROM employess as a  
INNER JOIN salaries as b ON b.emp_no = a.emp_no;
ORDER BY a.emp_no ASC;

/* 
what if we wanted to know the salary of a employee but only the ones the led to a new title, got a salary bump that led to a promotion in title
what if we wanted to know the raises from a promotion using inner joins
side note: title changes after two days from the salary raise
side note not every raise leads to a title change, we only search for the rais that led to a title change 
employees <--salaries<-- titles
we know that employees links to salaries through emp_no, but title changes linked to salaries through the from_date

*/
SELECT a.emp_no, CONCAT(a.first_name, ' ', a.last_name) AS "name", 
      b.salary,
      c.title, c.from_date as "promoted on"
FROM employees as a
INNER JOIN salaries as b ON a.emp_no = b.emp_no
INNER JOIN titles AS c ON c.emp_no=a.emp_no AND c.from_date=(b.from_date + interval '2 days')
ORDER BY a.emp_no;

/* 
want to know the original salary: first salary and its title has the same from_date in both tables salaries and titles,  and also the previous conditon 
*/
SELECT a.emp_no, CONCAT(a.first_name, ' ', a.last_name) AS "name", 
      b.salary,
      c.title, c.from_date as "promoted on"
FROM employees as a
INNER JOIN salaries as b ON a.emp_no = b.emp_no
INNER JOIN titles AS c ON c.emp_no=a.emp_no AND ( c.from_date=(b.from_date + interval '2 days') OR c.from_date=b.from_date)
ORDER BY a.emp_no ASC b.from_date DES;


--SELF JOIN: JOINING A TABLE TO ITSELF
/*
does a table have a reference to itself? 
 usually can be done when a table has a foreign key referencing its primary key, there can be a foreign key in a table that references the same primary key in the table
 let's assume this tabel employees
 id     name    startdate   supervisorid
 1      mo      1999-26-03  2
 2      andrei  1980-07-04  2
 here employee id which is andrei is a superivsor to mo, also andrie is supervisor of himself
 query: want to see the supervisor name of an employee
*/
SELECT a.id, a.name as "employee", b.name as " supervisor" 
FROM employee as a, employee as b
WHERE a.supervisorid=b.id

SELECT a.id, a.name as "employee", b.name as " supervisor" 
FROM employee as a 
INNER JOIN employee as b
ON a.supervisorid=b.id

--OUTER JOIN
/* 
return that match and don't match    
what if we also need the rows that don't match?
outer joins also add the data that don't have a match 
LEFT OUTER JOIN: ADD THE DATA THAT DON'T HAVE A MATCH FROM TABLE A WHICH IS LEFT HAND SIDE MEANS IN THE FROM CLAUSE
what is does: let me found everything where a.id=b.id also everywhere i couldn't find a.id, im just going to return that data to you
some values may contain null because you can't find a correlation with b 
any value that does not match is made to be NULL 

*/
--Syntax
select * 
from <table a> AS a 
LEFT [OUTER] JOIN <table b> AS b 
ON a.id = b.id
--use case: want to know how many employees aren't managers
/* 
here it return to combine all employees who are and aren't(NULL), with WHERE clause it excluded the one who are   
*/
select count(emp_no) 
from employees as emp 
LEFT JOIN dept_manager AS dep ON emp.emp_no = dep.emp_no
WHERE dep.emp_no IS NULL


/* 
want to know every salary raise even that didn't lead to title change and also know which ones were a promotion


*/
SELECT a.emp_no, CONCAT(a.first_name, ' ', a.last_name) AS "name", 
      b.salary,
      c.title, c.from_date as "promoted on"
FROM employees as a
INNER JOIN salaries as b ON a.emp_no = b.emp_no
LEFT JOIN titles AS c ON c.emp_no=a.emp_no AND ( c.from_date=(b.from_date + interval '2 days') OR c.from_date=b.from_date)
ORDER BY a.emp_no ASC b.from_date DES;


/*
* DB: Store
* Table: orders
* Question: Get all orders from customers who live in Ohio (OH), New York (NY) or Oregon (OR) state
* ordered by orderid
*/

SELECT c.firstname, c.lastname, o.orderid FROM orders AS o
INNER JOIN customers AS c ON o.customerid = c.customerid
WHERE c.state IN ('NY', 'OH', 'OR')
ORDER BY o.orderid;



/*
* DB: Store
* Table: products
* Question: Show me the inventory for each product
*/

SELECT p.prod_id, i.quan_in_stock
FROM products as p
INNER JOIN inventory AS i oN p.prod_id = i.prod_id 

/*
* DB: Employees
* Table: employees
* Question: Show me for each employee which department they work in
*/

SELECT e.first_name, dp.dept_name
FROM employees AS e
INNER JOIN dept_emp AS de ON de.emp_no = e.emp_no
INNER JOIN departments AS dp ON dp.dept_no = de.dept_no


