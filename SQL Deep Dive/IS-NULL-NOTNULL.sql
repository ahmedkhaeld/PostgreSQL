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