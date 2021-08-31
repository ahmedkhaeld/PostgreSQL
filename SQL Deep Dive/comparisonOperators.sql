/*
comparison operators > !> !< >= <= = !=
for rangs
*/
-- operators precedence: multiple operators is evaluated based on the priority of operators 
-- parenthese > multiplicity/division > subtraction/addition > NOT > AND > OR 

-- EXERCISE: 
/*
* DB: Store
* Table: Customers
* Question: 
* Select people either under 30 or over 50 with an income above 50000
* Include people that are 50
* that are from either Japan or Australia
*/
SELECT firstname, income, age from customers
where  (income >50000 and (age >30 or age >=50))  and (country = 'Japan' OR country = 'Australia');

-- BETWEEN AND
SELECT <column> 
FROM <table> 
WHERE <column> BETWEEN X AND Y

-- FLITERING MULTIPLE VALUES: use IN KEYWORD
-- CHECK IF A VALUE MATCHES ANY VALUE IN A LIST OF VALUES

-- EXAMPLE: fetch all employess info that matches these numbers
SELECT * FROM employees
WHERE emp_no IN (100001, 100006, 11008)


/*
* DB: Store
* Table: Orders
* Question: 
* What was our total sales in June of 2004 for orders over 100 dollars?
*/
SELECT SUM(totalamount) from orders
WHERE (orderdate >= '2004-06-01' AND orderdate <= '2004-06-30') 
AND totalamount > 100
/*
* DB: Store
* Table: orders
* Question: How many orders were made by customer 7888, 1082, 12808, 9623
*/

SELECT COUNT(orderid)
FROM orders
WHERE customerid IN (7888, 1082, 12808, 9623)


/*
* DB: World
* Table: city
* Question: How many cities are in the district of Zuid-Holland, Noord-Brabant and Utrecht?
*/

SELECT COUNT(id)
FROM city
WHERE district IN ('Zuid-Holland', 'Noord-Brabant', 'Utrecht');



--LIKE: PARTIAL LOOKUP
-- % any number of character after the searched characters
-- - one character  after the searched character

--postgres LIKE only does text comparison, so we must cast whatever we use to text            
-- cast to text 
CAST(salary AS text);
salary::text 

--EXAMPLE: GET EVERY EMPLOYEE WHOS NAME STARTS WITH M 
SELECT first_name FROM employees WHERE first_name LIKE 'M%';

-- ILIKE keyword: case insensitive matching