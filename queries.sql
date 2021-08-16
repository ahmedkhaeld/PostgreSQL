/*
SQL COMMANDS 
# DCL (DATA CONTROL LANGUAGE): GRANT & REVOKE, ability to give access to data set 
# DDL (DATA DEFINITION LANGUAGE): CREATE (create database|table),
                                ALTER(change state of something), 
                                DORP(delete something), RENAME, 
                                TRUNCATE(fully remove data inside), COMMENT
# DQL (DATA QUERY LANGUAGE): SELECT
# DML (DATA MODIFICATION LANGUAGE): INSERT, UPDATE, DELETE, MERGE, CALL, EXPLAIN PALN, LOCK TABLE

 */

 /* 
 COMMON SELECT MISTAKES
 # MISSPELLING COMMANDS
 # USING ; INSTEAD OF , OR VICE VERSA
 # USING " " INSTEAD OF '' >>> SINGLE QUOTES ARE FOR TEXT, DOUBLE QUOTES FOR TABLES
 */




/* 4 renaming columns */
SELECT
 emp_no AS "Employee #", 
 birth_date AS "Birthday", 
 First_name AS "First name" 
 FROM "public"."employees"

 /*
  COLUMN CONCATENATION
  CONCAT FUNCTION RUN AGAINST EACH ROW
  MAKE YOUR DATA PRETIER/SIMPLER
  CONCATENATE COLUMNS TOGTHER TO FORM ONE COLUMN
  */
  SELECT CONCAT(emp_no, 'is a ', title) AS "Employee Title" FROM titles
/* 
TYPES OF FUNCTIONS
AGGREGATE: aggregate data, they take all of the date and produce one single value
AVG()
COUNT(): SELECT count(emp_no) FROM employees;
MIN()
MAX(): SELECT max(salary) FROM salaries;
SUM()  SELECT sum(salary) FROM salaries;
SCALAR: run against each individual row, get multiple outputs

*/

/* 
FILTERING DATA
*/
SELECT first_name 
From employees
WHERE gender= 'F';

SELECT first_name, last_name 
From employees
WHERE first_name= 'MO' AND last_name= 'Binni';

SELECT first_name, last_name, hire_date 
From employees
WHERE first_name= 'Georgi' AND last_name= 'Facello' ANd hire_date='1986-06-26' ;

/* ORDER OF OPERATIONS 
here we want any person whose is firstname and last name geogri facello or bezalel simmel
AND chain a group of attibutes 
where SQL sees the OR it is going to start a new filter 
good practice put each filter in a ()
*/

SELECT first_name, last_name, hire_date 
From employees
WHERE (first_name= 'Georgi' AND last_name= 'Facello' ANd hire_date='1986-06-26') OR (first_name='Bezalel' AND last_name= 'Simmel');

/*EXERCISE 
HOW MANY FMEALE CUSTOMERS DO WE HAVE FROM THE STATE ='OR' AND STATE='NY'
the first solution is the simple one that specify that each state with the femal gender
the second solution combine the state is like take common factor which is gender
the third is INCORRECT because that means select the females from the OR and all gender from NY
 */
 select count(*) from customers
where  gender= 'F' AND state='NY' or  gender= 'F'and state='OR';

select  gender, state from customers
where  (state='OR' OR state='NY') and gender= 'F'; 


select  gender, state from customers
where gender= 'F' and state='OR' or state='NY'; 



/* 
WHAT IF YOU WANT TO FILTER ON EVERYTHING BUT THIS ONE THING
using NOT keyword
question
how many customers are not 55 old?
*/
select count(*) from customers
where not  age=55;

/*
comparison operators > !> !< >= <= = !=
for rangs
*/
-- operators precedence: multiple operators is evaluated based on the priority of operators 
-- parenthese > multiplicity/division > subtraction/addition > NOT > AND > OR 





