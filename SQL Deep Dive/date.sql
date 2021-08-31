/* 
what is timezone?
there is point in the world and we offset every other country's time based on that 
center point of time, that ended up being in greenwich.
GREENWICH MEAN TIME: GMT is a time zone

what is UTC? universal coordinate time: is a time standard

TIMESTAMPS: IS A DATE WITH TIME AND POTNETIALLY WITH TIMEZONE INFO

*/

--dates operators    

--current date 
select NOW()::date; -- e.g 2001-01-3
select CURRENT_DATE;

--to formate current date to any other specific format
select TO_CHAR(CURRENT_DATE, 'dd/MM/yyyy');

-- what if we want to calulate the difference between to dates
select now() - '1999/01/28'  -- this return the difference in days

--casting the date 
select  date'1999/01/28' -- '1999-01-28'

-- age calculation: returns # of years, months, days
select AGE(date '1800-01-01') as age -- output 221 years 7 mons 16 days

select AGE(date '1995-11-07', date '2000-01-28') as age -- difference between two ages

-- EXTRACT DAY, MONTH, YEAR
select EXTRACT(DAY FROM date'1995-11-07') as DAY 
select EXTRACT(MONTH FROM date'1995-11-07') as month
select EXTRACT(YEAR FROM date'1995-11-07') as year

-- round down a date using DATE_TRUNC
select DATE_TRUNC('year', date'1995-11-07') --1995-01-01 
select DATE_TRUNC('month', date'1995-11-07') --1995-11-01 
select DATE_TRUNC('day', date'1995-11-07') -- this not gonna round down the days


-- INTERVAL:gives an easy way to talk about time in a readable manner
-- you can subtracte or add periods of time to any given date 
select * from orders 
where orderdate  > date'2004-01-01' +  interval '30 days'

select * from orders 
where orderdate <= now() - interval '30 days'
-- output all the orders that has been ordered about 30 ago from the given date which here is now()
select * from orders 
where orderdate <= now() - interval '30 months'

select * from orders 
where orderdate <= now() - interval '30 year'

select * from orders 
where orderdate <= now() - interval '1 year 2 months 3 days'

select * from orders 
where orderdate <= now() - interval '3 week ago'

select * from orders 
where orderdate <= now() - interval '1 year 3 hours 20 minutes'

--exercises
/*
* DB: Employees
* Table: employees
* Question: Get me all the employees above 60, use the appropriate date functions
*/

SELECT AGE(birth_date), * FROM employees
WHERE (
   EXTRACT (YEAR FROM AGE(birth_date))
) > 60 ;


-- alternative, 2021 - the date of 61 year age 
SELECT count(birth_date) FROM employees
WHERE birth_date < now() - interval '61 years' -- 61 years before the current date



/*
* DB: Employees
* Table: employees
* Question: How many employees where hired in February?
*/

SELECT count(emp_no) FROM employees
where EXTRACT (MONTH FROM hire_date) = 2;

/*
* DB: Employees
* Table: employees
* Question: How many employees were born in november?
*/

SELECT COUNT(emp_no) FROM employees
WHERE EXTRACT (MONTH FROM birth_date) = 11;

/*
* DB: Employees
* Table: employees
* Question: Who is the oldest employee?
*/

SELECT MAX(AGE(birth_date)) FROM employees;



/*
* DB: Store
* Table: orders
* Question: How many orders were made in January 2004?
*/

SELECT COUNT(orderid)
FROM orders
WHERE DATE_TRUNC('month', orderdate) = date '2004-01-01';

