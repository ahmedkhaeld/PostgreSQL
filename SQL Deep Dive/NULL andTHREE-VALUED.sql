-- THREE-VALUED LOGIC
-- EXPRESSION COULD RETURN TRUE OR NULL OR FALSE 
-- sidenot: NULL=NULL ,NULL<>NULL both return null not true 
-- (NULL=1)OR(1=1) return true
-- (NULL=1) AND (0=1) return null because null and anything is nullable

SELECT <column> 
FROM <table> 
WHERE <column> IS NULL  
-- return true if it's nullable. IS is asking is there any NULLABLE or not

SELECT <column> 
FROM <table> 
WHERE <column> = NULL 
-- return null if there is nullable. because null= null return null 

SELECT <column> 
FROM <table> 
WHERE (<column> = NULL) OR (NOT <column> = NULL) 
-- return nothing, all row are going to be rejected, null equality return nothing   

SELECT <column> 
FROM <table> 
WHERE (<column> IS NULL) OR ( <column> IS NOT NULL)
-- return everything. rows that have value and rows that don't have value


--THREE-VALUED EXERCISE

/*
* DB: Store
* Table: customers
* Question: adjust the following query to display the null values as "No Address"
*/
SELECT COALESCE(address2, 'No Address') AS address
FROM customers

