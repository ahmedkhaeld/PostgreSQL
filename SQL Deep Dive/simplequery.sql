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