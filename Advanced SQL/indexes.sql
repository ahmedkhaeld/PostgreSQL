/* 
when you want to execute queries, and we're also going to create an index 
to illustrate the performance improvement that you can gain.

SINGLE COLUMN
most requently used column in a query.
The most frequently used column is often the column that you are referring to in every single 
query in the Where clause.So that's the column that you are going to apply an index against.

MULTI-COLUMN 
MOST FREQUENTLY USED COLUMNS IN A QUERY  
applying it against a group of columns in a query, so multiple columns.

UNIQUE INDEX
unique index against a column that can only contain unique values. these are built for speed.

PARTIAL INDEX
an index over a subset of a table. When you create an index,
you can create an index with a specific name on a table and you can give it a specific expression.

IMPLICIT INDEX
created by the database automatically.
when you create a primary key or unique key, so you flag a column as primary key or you
flag a column as a unique key, the database is automatically going to index these.

WHEN DO I USE SPECIFIC TYPE OF INDEX?
INDEX ALGORITHMS
B-TREE (DEFAULT)
best used for comparisons with < <= = >= BETWEEN, IN, IS NULL, IS NOT NULL.

HASH can only handle equality (=) operations checks 

GIN generalized inverted index
best used when multiple values are stored in a single field

GIST generalized search tree    
useful in indexing geometric data and full text search   

*/

CREATE INDEX idx_countrycode on city (countrycode);
--
explain analyze 
select "name", district, countrycode 
from city 
where countrycode In ('TUN', 'BEL', 'NLD')
----------
----------

CREATE INDEX idx_countrycode on city using hash (countrycode);
--
explain analyze 
select "name", district, countrycode 
from city 
where countrycode ='TUN' and countrycode = 'BEL' and countrycode = 'NLD';
