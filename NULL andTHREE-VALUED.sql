
/* ------------
CHECKING FOR EMPTY VALUES
WHEN A RECORD DOES NOT HAVE A VALUE IT IS CONSIDERED EMPTY
NULL REPRESENT MISSING/EMPTY VALUES
NUL is different from being a zero or a field that may contain text and have some spaces in 
special value that across the board is just used for things that you do not know exist yet 
data should never come into your database without being sanitized or checked for correct values.

Is it OK for me to leave stuff blank?
three things that you need to keep in mind.
Be careful, be mindful and be deliberate.
* be careful, what I mean is be very careful with what you make, Nullable.be defensive.
make everything not nullable, and then be very deliberate about what you want to be nullable.
 * be mindful, whatever you turn into now may have effects on queries that other people will write,
 so maybe don't make Fields Nullable, that you have to do calculations on.
* be deliberate, make a choice and stick to it, document it, make it clear that 
field, that particular record of data is going to be nullable
make a document outlining why it's nullable and why you made that choice.

be defensive: always check for nulls when necessary.
1. filter out nulls  
THE "IS" OPERATOR 
ALLOWS TO FILTER ON VALUES THAT ARE NULL , NOT NULL, TRUE OR FALSE
2. CLEAN UP THE DATA
NULL COALESCING: ABILITY TO REPLACE NULL VALUES TO OPERATE ON THE DATA 


*/

SELECT first_name, last_name 
FROM students
WHERE last_name IS NOT NULL;

-- SELECT THE FIELD THAT IS EMPTY: IS NOT FALSE= TRUE
SELECT first_name 
FROM students
WHERE last_name='' IS NOT FALSE;

-- COALESCE: ENABLE TO REPLACE NULL VALUE IN A COLUMN THAT MAY HAVE NULL IS THERE ANY WITH SUBTITUTE
-- COALESCE: MEANS PUT A FALLBACK VALUE TO IS NEARLY THE FIELD WOULD HAVE

SELECT sum(coalase(age, 15)) AS age
FROM students
-- here if there a null field then put the age to 15, 
-- so that to not leave a person that should have an age to reach approx sum all the students


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

