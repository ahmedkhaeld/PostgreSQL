# PostgreSQL
# DB Management: WHAT TO LEARN
* THE DIFFERENT TYPES OF DATA
* HOW TO CREAT A DATABASE
* HOW TO CREATE TABLES
* HOW TO INSERT/UPDATE/...DATA
## TYPES OF DATABASES IN A RDBMS


 <img src="https://user-images.githubusercontent.com/40498170/131546582-0812e384-4db2-4d0e-972d-3d2ecd5cddc9.png" width="900" height="200"/>
 what exactly is the process that goes behind creating that database?
 Because for everything that is created, there must be a map, a blueprint, some kind of structure behind it that tells it, you know, what am I making?
  what a template database is? So when we look at the types of databases in a database management system and from the management perspective,
  while the regular databases are what we're used to.
  And on the other end, there's the template database where you're looking at, hey, this is the structure 
  I kind of want to have in place.Whenever I create a database, they're kind of related to each other because a template is a blueprint
  and the regular database is built off of a blueprint.A template database is that secret sauce, that kind of like structure that we were talking about.
  And it's configurable. We can create our own templates
  #### CREATING A DATABASE
  WHEN YOU SETUP YOUR POSTGRE 3 DATABASES WERE CREATED: POSTGRES TEMPLATE0 TEMPLATE1 <br />
  1- POSTGRES DATABASE <br />
  THIS IS THE DEFAULT DATABASE THAT IS CREATED WHEN YOU SETUP POSTGRES(INITDB) <br />
  so the first time you initialize postgres you can connect to the postgres database to setup your first database <br />
 
 ` psql -U <user> <database> `
  `postgres-# \conninfo` <br />
  
  
  You are connected to database "postgres" as user "postgres" via socket in "/temp" at port "5432"  <br />
  2- TEMPLATE0 DATABASE <br />
  THIS IS THE TEMPLATE THAT IS USED TO CREATE TEMPLATE1- NEVER CHANGE IT! <br />
  IT IS A BACKUP TEMPLATE <br />
  3- TEMPLATE1 DATABASE <br />
  THIS IS THE TEMPLATE THAT IS USED TO CREATE NEW DATABASES. ANY CHANGES WE MAKE TO THIS TEMPLATE ARE AUTOMATICALLY APPLIED
  TO ALL NEW DATABASE. <br />
  ONE THING TO NOTE IS THAT BECAUSE TEMPLATE1 IS THE DEFAULT TEMPLATE- IF IT IS BEING ACCESSED/CONNECTED TO, NO NEW DATABASES
  CAN BE CREATED UNTIL THE CONNECTION IS CLOSED! <br />
  `exit` from the session so other one could be connected <br />
  
   #### SO HOW DO YOU CREATE A DATABASE? 
  this creates a database with all the defaults for you, it will use template1 <br/>
  ` CREATE DATABSE NAME ` <br />
  if you want to override it, by using the WITH statement <br />
 `[ [WITH] [OWNER [=] USER_NAME] `<br />
 `[TEMPLATE [=] template]` <br />
 `[ENCODING [=] encoding] `<br />
 `[LC_COLLATE [=] collate]` <br />
 `[LC_CTYPE [=] lc_ctype] `<br />
 `[TABLESPACES [=] tablespaces]` <br />
 `[CONNECTION LIMIT [=] connlimit]` <br />
 <br />
 connect to postgres and creat ztm database in linux <br />
 ` sudo -u postgres psql postgres ` <br />
 ` CREATE DATABASE ztm;`
 #### DATABASE ORGANIZATION
 DATABASES OFTEN CONTAIN MANY TABLES, VIEW, ETS... DEPENDING ON HOW MUCH YOU CARE, YOU MAY WANT TO ORGANIZE THEM IN A LOGICAL WAY!<br />
 
 * POSTGRES SCHEMAS <br />
 POSTGRES OFFERS THE CONCEPT OF "SCHEMAS" THINK OF IT LIKE A BOX IN WHICH YOU CAN ORGANIZE TABLES, VIEWS, INDEXES, ETC.
 let's say we were creating a database structure for a company and we had a sales department,a marketing department, all of these other different departments.
 Where are we going to create a database per department, know all the data needs to be intermix so that 
 we can kind of select and pluck data and query effectively among that one database.<br />
 Why would you go and split that prematurely? <br />
 That sounds like a lot of work, creating a database per organizational unit, so to speak, per department.<br />
 We're going to organize the tables, the views in the indexes, in schemas. <br />
 And so we can create a schema called sales. We can create a schema called payroll. 
 We can create a schema called H.R. and technology and engineering and all of the different departments <br />
 By default, each database gets a public schema. unless you specify a schema, the default is always going to be assumed public.<br />
 ` SELECT * FROM employess ` <br /> 
 ` SELECT * FROM public.employees ` same as above <br />
 
 * SHOW ALL SCHEMAS <br />
 ~ `mydatabase=# \dn` <br />
 
 * CREATE A SCHEMA   <br />
  ~ `mydatabase=> CREATE SCHEMA sales;` <br />
  
  #### REASON TO USE SCHEMAS:
  * to allow many users to use one database without interfering with each other. <br />
  What does that mean? <br />
  because in one schema, you can't have two tables with the exact same name.  <br />
  * to organize database objects into logical groups to make them more manageable. <br />
  * third-party applications can be put into separate schemas so they do not collide with the names of other objects. <br />
  It's about not interfering with the global data, right? If you separate things into schemas, you can have duplicate names,     you can have duplicate named objects
  that are not necessarily the same because they're in a different logical group. But you're still operating on the same     database.<br />
  #### ROLES IN POSTGRES
  WHEN WE TALK ABOUT ROLES, WE TALK ABOUT SECURITY. ROLES ARE VITAL TO ANY DBMS THEY DETERMINE WHAT'S ALLOWED!<br />
  WHEN WE SET UP ROLES, WE'RE BASICALLY SETTING UP FUNCTIONS TO WHICH PEOPLE ARE ALLOWED AND NOT ALLOWED
  * ROLES <br />
  A ROLE CAN BE A USER OR A GROUP, IT DEPENDS ON HOW YOU SETUP THE ROLE <br />
  ROLES HAVE THE ABILITY TO GRANT MEMEBERSHIP TO ANOTHER ROLE <br />
  so you can give a role to a role, and when that role is given to someone else, they automatically have both of those roles.<br/>
  So roles have the ability to grant membership to another role as well. So there's the chain of permissions of which rules can have roles and then give roles to users<br />
  When you look at roles, roles have attributes and privileges and attributes are basically the same thing as a privilege.
  Like attributes define a privilege. But there are privileges that aren't attributes as well. <br />
  Like you can have an attribute that says you're a super user and that can give you the privilege to do whatever you want.
  But you can give individual privileges to a role that have nothing to do with an attribute, just like super user.
  Super user is an attribute and it specifies a couple of privileges.
  But the individual privilege could be read access, right, access to everything, the ability to create databases, those are privileges.
   * ROLE ATTRIBUTE <br />
   WHEN A ROLE IS CREATED IT IS GIVEN CERTAIN ATTRIBUTES <br />
   THE PRIVILEGES OF A ROLE ARE DETERMINED IN PART BY ITS ATTRIBUTES <br />
    
   ATTRIBUTES             |  COMMON ATTRIBUTES
:-------------------------:|:-------------------------:
![Screenshot from 2021-08-31 23-43-35](https://user-images.githubusercontent.com/40498170/131579760-852579c9-19bb-40ad-aebf-753bd39f08e8.png)  |  ![Screenshot from 2021-08-31 23-39-15](https://user-images.githubusercontent.com/40498170/131579482-d40f5bd5-1d00-40c7-9d2c-a269c964da0a.png)
<br />
So when we look at certain attributes, certain attributes that can be given to a role is, for instance,
creative, know, create DB so you can tell a role whether or not it is allowed to create databases,
you can give a role, the ability to create a role or not create a role. <br />
You can give a role, the attribute to in or not be able to log in.
And on top of that, you can give a role, the ability to be a super user or not be a super user.<br />
We're telling a roll, hey, these are some of the attributes that you can have and, you know, by
giving it the attribute, you're also defining a privilege.<br />


switch users to the postgres user: <br />
` sudo su - postgres` <br />
Connect with psql <br />
` postgres@demo:~$ psql -U postgres` <br />

* CREATING ROLE <br />
`CREATE ROLE readonly WITH LOGIN ENCRYPTED PASSWORD 'readonly;'`<br />
 WHEN CREATING A ROLE,BY DEFAULT ONLY THE CREATOR OF THE DATABASE OR SUPERUSER HAS ACCESS TO ITS OBJECT
alway encrypt when storing a role that can login <br />
* VIEW ROLES  <br />
`Database=>\du`
 gives a table of role name and list of roles attributes that each role has <br />
 
 ```
 sudo -u postgres psql postgres
 CREATE role test_role_with_login WITH LOGIN ENCRYPTED PASSWORD 'password';
 CREATE USER test_user_with_login WITH ENCRYPTED PASSWORD 'password';
 postgres=# \du
 exit
 
 ```
  or <br />
 
 ```
 sudo -u postgres createuser --interactive
Shall the new role be a superuser? (y/n) n
Shall the new role be allowed to create databases? (y/n) n
Shall the new role be allowed to create more new roles? (y/n) y
sudo -u postgres psql postgres
postgres=# ALTER ROLE test_interactive WITH ENCRYPTED PASSWORD 'password';

 ```

Drop a role <br />
` postgres=# DROP ROLE demorole1;` <br />

#### PRIVILEGES
ATTRIBUTES CAN ONLY DEFINE SO MANY PRIVILEGES!
WHEN YOU ARE NOT A "SUPERUSER" WHAT YOU CAN DO IS FAIRLY LIMITED, DEPENDING ON WHAT DEFAULT PRIVILES ARE SET <br />
BY DEFAULT OBJECT ARE ONLY AVAILABLE TO THE ONE WHO CREATES THEM <br />
THIS MEANS PRIVILESGES NEED TO BE GRANTED FOR NEW ROLES AND USERS TO HAVE ACCESS TO CERTIN DATA <br />

* GRANTING PRIVILES <br />
```
GRANT ALL PRIVILES ON <TABLE> TO <USER>
GRANT ALL ON TABLES [IN SCHEMA <schema>] TO <user>;
GRANT [SELECT, UPDATE, INSERT,...] ON <table> [IN SCHEMA <schema>] TO <user>;
```

 ```
 sudo -u postgres createuser --interactive
Enter name of role to add: privilegetest
Shall the new role be a superuser? (y/n) n
Shall the new role be allowed to create databases? (y/n) n
Shall the new role be allowed to create more new roles? (y/n) n
psql -U postgres Employees
Employees=#  SELECT * FROM titles;

 ```
 here retrieve all the data from titles <br />
 but if we did
 ```
 psql -U privilegetest Employees
 Employees=> SELECT * FROM titles;
 ```
 ERROR: permisision denied for table titles <br />
 because here only the owner or superuser has access <br />
 superuser can grant roles to other users by default, you can create user that can grant other roles as well.<br />
 
 ```
 psql -U postgres Employees
 Employees= GRANT SELECT ON titles TO  privilegetest;
 ```
 also can revoke <br />
  ```
 psql -U postgres Employees
 Employees= REVOKE SELECT ON titles FROM  privilegetest;
 ```
 IF YOU WANT GRANT EVERYTHING <br />
  ```
 psql -U postgres Employees
 Employees= GRANT ALL ON ALL TABLES IN SCHEMA public TO  privilegetest;
 ```
 IF YOU WANT REVOKE EVERYTHING <br />
  ```
 psql -U postgres Employees
 Employees= REVOKE ALL ON ALL TABLES IN SCHEMA public FROM  privilegetest;
 ```
 CREATE SPECIFIC  ROLE TO READONLY TO USER AND GRANT THIS ROLE 
   ```
 psql -U postgres Employees
 Employees= CREATE ROLE employee_read;
 Employees= GRANT SELECT ON ALL TABLES IN SCHEMA public TO  employee_read;
 Employees= GRANT employee_read TO  privilegetest;
 ```
 #### BEST PRACTICES
 WHEN MANAGING ROLES AND PERMISSIONS ALWAYS GO WITH THE "PRINCIPLE OF LEAST PRIVILEGE" <br />
 says give no privileges at all and then start layering them.Don't start off with super users and then revoke privileges or    not that you could. But don't start with users that have all of the privileges and then remove privileges.
 No start with no privileges at all and start layering them like a cake.
 And with that you have total control because when you create new users, they're not allowed to do anything.
 And then you start giving them access to certain portions and they have to continuously ask for access.
 You have to be extremely cautious with data. <br />
 
 #### DATA TYPES
 IS NOTHING MORE THAN A CONSTRAINT PLACE ON A FIELD TO ONLY ALLOW THAT TYPE OF DATA TO BE FILLED IN. IT'S IMPORTANT BECAUSE 
 IT TELLS THE SYSTEM HOW IT CAN/SHOULD HANDLE THE DATA IN THAT FIELD <br />
 
 * BOOLEAN <br />
 A BOOLEAN TYPE CAN HOLD TRUE, FALSE, OR NULL <br />
 it also can convert [1,yes,y,t,true]  to TRUE |  [0,no,f,false] to FALSE. <br />
 
 * CHARACTER <br />
 POSTGRES PROVIDES THREEE CHARACTER DATA TYPES:  <br />
 CHAR(N): FIXED LENGTH WITH SPACE PADDING  <br />
 VARCAHR(N): VARIABLE LENGTH WITH NO PADDING  <br />
 TEXT: UNLIMITED LENGTH TEXT <br />
 
 * NUMERIC  <br />
 THERE ARE TWO TYPES OF NUMBERS IN POSTGRES: INTEGERES[SMALLINT,INT,BIGINT] AND FLOATING[FLOAT4, FLOAT8, DECIMAL]  POINTS <br/>
 
 * ARRAYS <br />
 A GROUP OF ELEMENTS OF THE SAME TYPE. EVERY DATA TYPE IN POSTGRES HAS AN ARRAY EQUIVALENT <br />
 
 ### CREATE DATA
 ##### DATABASE MODELS
 ##### WHAT IS A MODEL?
 A model would help you think ahead up front and not have to make as many changes as you go along.
 A little bit of thinking ahead will take you away farther.
 A model is a design that is used to visualize what we are going to build. <br />
 ##### An Entity Relationship Diagram (ERD)
 <br/>
 
 <img src="https://user-images.githubusercontent.com/40498170/131753239-7f0f792d-faef-4d67-ae4b-4c89bd598b1c.png" width="500" height="500"/>
 
 that is what is used to create a model, and it denotes entites <br />
 #### RULES TO FOLLOW IN ORDER TO BUILD A DIAGRAM:
 * TABLE NAMES MUST BE SINGULAR!
 * COLUMNS MUST BE LOWERCASE WITH UNDERSCORES
 * BE CONSISTENT! WRITE DOWN YOU RULES!
 #### let's create data
 ```
CREATE TABLE student( 
student_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL,
email TEXT CHECK (email ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'),
date_of_birth DATE NOT NULL
);

ztm=# create extension if not exists "uuid-ossp";
ztm=# \dt

 ```
 
           List of relations
           
 Schema |  Name   | Type  |  Owner   
:--------:|:---------:|:-------:|:----------:
 public | student | table | postgres
 
(1 row)
<br />
 
  ` ztm=# \d student` <br />
                               Table "public.student" 

 
   column      |  type                  | collation | Nullable |  Default
:--------------------:|:--------------------:|:-----------:|:------------:|:----------:
 student_id    | uuid                   |           | not null | uuid_generate_v4()
 first_name    | character varying(255) |           | not null | 
 last_name     | character varying(255) |           | not null | 
 email         | character varying(255) |           | not null | 
 date_of_birth | date                   |           | not null |
<br />
Indexes:
    "student_pkey" PRIMARY KEY, btree (student_id) <br />
    #### CONSTRAINTS
    ARE A TOOL TO APPLY VALIDATION METHODS AGAINST DATA THAT WILL BE INSTERTED.<br />
    ##### COLUMNS CONSTRAINTS
     
 <img src="https://user-images.githubusercontent.com/40498170/131769439-72a8dcc7-368d-4fe9-a179-f11bfeab5bc0.png" 
      width="900" height="500" />
<br />
Here are some different constraints that you can apply on a column and the meaning.
So what do they do?

So when we look at column constraints, we're trying to look at a constraint that will be applied uniquely
to that specific column, not multiple columns, just that one.
And so one that we're very, very familiar with and one that we've seen throughout the course.
Not no, it cannot be null.
It has to have a value, it cannot be the value, not so that's pretty easy.
We know all about no values were no professionals.

When we look here, primary key is another one, and we just applied this to the student table and the
column will be the primary key and that is very important.
We're saying, hey, this column, this column is going to be the primary.
Now, when we talked about primary keys, we also talked about primary keys being able to be multiple
columns.
Well, when you apply a column constraint, you're not going to be able to do that.
It is for that column specifically.
So one column is the primary.

And then we have the unique constraint and what the unique constraint says is it can only contain unique
values, so you can only have unique values in this column.
They can't overlap with any other values.
And NUL is considered unique.
You can't just fill in anything.
It has to be a unique value.
NUL is considered to be unique as well.
Remember that no null is the same.


Well, this one is Check
So what is it going to check?
what are we going to do with this one?
Well, we're applying a special condition to check against.
So, hey, here, here's a custom check.
here's a special condition that I want you to check for the values in this column.
And this could be, for instance, that email validation we spoke about, that phone number validation.
you want a specific sequence or that you want specific characters to be present
or whatever else you can fill in a unique special conditions to check against.
And that is what check is for.

The constraint references what ths references do.
What does it mean?
Well, we've talked about primary keys and we've talked about unique, but we're aware, for example.
Well, that's what references for references to constrain values of a column to only be the values that
exist in a column in another table.
Well, that sounds oddly like a foreign guy.
So what we're seeing here is when you apply the constraint references, you're pointing to a different
table and a specific column in that table.
So you're referencing somewhere else and you're saying, hey, anything you fill in here, it has to
correspond with a value in that column, in that other table.

#### TABLE CONSTRAINTS
A TABLE CONSTRAINT DEFINITION IS NOT TIED TO A PARTICULAR COLUMN, AND IT CAN ENCOMPASS MORE THAN ONE COLUMN. <br />
UNIQUE (column_list): can only contain unique values (NULL is unique) <br />
PRIMARY KEY (column_list): columns that will be the primary key <br />
CHECK (condition): a condition to check when inserting or updating <br />
REFERENCES: foreign key relationship to a column <br />
YOU WRITE THE CONSTRAINTS AT THE BOTTOM <br />


```
CREATE TABLE student( 
student_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL,
date_of_birth DATE NOT NULL,
CONSTRAINT pk_student_id PRIMARY KEY (student_id)
);
```
#### CUSTOM DATA TYPES
POSTGRES ALLOWS YOU TO CREATE CUSTOM DATA TYPES TO STORE SHAPES OF DATA THAT ARE MORE COMPLEX <br />
ztm database -> functions and write this custom data type
```
create domain Rating smallint check (value > 0 and value <=5);

create type Feedback as(
student_id UUID,
rating Rating,
feedback TEXT);
```
Feedback will be a custom data type that will have a student ID, a rating and feedback, and the rating will be a small integer that can range from one to five. The student ID will be a UID and feedback will be text. <br />
create a domain and in a domain is just a specific type of data that can have a check. <br />
A domain is nothing more than an alias for an existing type that can have a check constraint <br />

Use case: create course table and insert data into it (a mini migration scenario) 
```
create table course( 
course_id UUID primary key default uuid_generate_v4(),
"name" text not null, 
description text, 
subject_id UUID references subject(subject_id),
teacher_id UUID references teacher(teacher_id),
feedback feedback[]

);
```
here insert data into two fields 
```
insert into course  (
"name", 
description 
) values ( 
'DataBase',
'learn about db management and querying'
);
```
First: subject_id, and teacher_id in course table will have null values for that inserted record <br />
 we were allowed to create a course, but we didn't have to give it a teacher idea and we didn't have to give it a subject.
 So when we created our foreign key reference, we didn't actually tell it that it had to enforce it. <br />
 So it's allowed to be. Well, we don't want that, do we? <br />
 We want our table to like, you know, we need a teacher, a teacher for sure, has to make a course.And, you know, every course needs a subject. So we're going to do an altar table. <br />
 the situation here, we a have a record already with less constraints, but when we alter the table constraints, the existing
 record must be on the same newly constraints. <br/>
 okay, first do update statement to old record so there is no null fields, then do the constraints alteration. <br />
 ```
update course 
set subject_id='96d40705-36c0-4dbf-977a-961b74f22a28'
where subject_id is Null;
```
```
update course 
set teacher_id='c06398c2-b161-4920-a1ca-8545eabf4843'
where teacher_id is Null;
```
now update the foriegn keys constraints <br />

```
alter table course alter column subject_id set not null;
alter table course alter column teacher_id set not null;
```
after that if we try to insert a data without filling subject_id and teacher_id this will not work <br />
` 21:04:12 Kernel error: ERROR:  null value in column "subject_id" of relation "course" violates not-null constraint` <br />

##### Adding Feedback to a course
 ```
 update course 
set feedback=array_append(feedback, 
row(
'1038a603-526b-45d2-8f56-5746470d06e0',
5,
'Great Course'
)::feedback

)where course_id='ed0fdc40-7849-4c9a-95be-1c7d4f5ec6dd'
```
we're going to set feedback and we're going to array append.
So now that we're working with arrays, we have a feedback array and we have to append to that array.
And what we're going to do is to the feedback array, the existing array.
We're going to append the row. <br/>
This is the syntax you can use to define a custom row of any specific type. <br />
we have the student ID, we have our score, which is a five, and we have our feedback, which is great course.
Now that we have this, we're going to cast it to the type feedback and we're going to say, hey, do
it where the course_id is equal to this id;

----------
But one of the downfalls of this It's not going to check. If this student I.D. exists, and sure, I'm getting a lot of five stars, but I can't verify from who. <br />
I have to do an update instead of an insert and I have to update the course information every time.
I don't want to be updating my course, every time I want to insert feedback somewhere and I want to keep it separate from the course.
. how are we going to change this in order to accommodate feedback from multiple students and to a course? <br />
we need to change our custom data type into something completely different. We need to shape it into a table. <br />
And the reason we're going to shape it into the table is because when we use tables, we can follow 
the relational model. Primary key, foreign key interaction constraints, checks.

<img src= "https://user-images.githubusercontent.com/40498170/131938371-56af003f-a298-4d46-986e-cacc89f977c0.png"  width="900" height="500" />
what we did was we made it a relationship <br/>
Each individual feedback can belong to one student, but a student can leave multiple feedback, right?
So a student can leave multiple feedback and feedback belongs to one course, but a course can have multiple feedback.
So one individual feedback has to belong to a certain course and a certain student.
But students in courses can have multiple feedbacks.<br />

```
create table feedback ( 
student_id UUID not null references student(student_id),
course_id UUID not null references course(course_id),
feedback text, 
rating rating, 
constraint pk_feedback PRIMARY key  (student_id, course_id )
)
```
before executing this query, we have to change feedback to feedback_deprecated at Tables>type <br/>

insert data into feedback <br />
```
INSERT INTO feedback( 
student_id, 
course_id,
feedback, 
rating 
) values ( 
'1038a603-526b-45d2-8f56-5746470d06e0',
'76e121e8-00db-4bc6-909b-c526c1c9e9be',
 'great great course',
 5
);
```
------
### BACKUPS 
disaster will strike, you will hit a scenario where something
unexpected happens, you may not know what it is and it depends very much on the scenario you're working in. <br />
Are your databases in the cloud? <br />
Are the on premise? <br />
Do you have your own hardware? <br />
when disaster strikes, when unexpected things happen, we need to have a strategy in place. <br />
How am I going to make the backups? <br />
What type of backups am I going to make? <br />
Why am I going to make these backups? <br />
All of these questions need to be answered. <br />

#### HAVE A PLAN
1- BACKUP PLAN
2- DISASTER RECOVERY PLAN
3- TEST YOUR PLANS

The disaster recovery plan tells you exactly. OK, a database went down.  <br />
What are we going to do?  <br />
The applications go into maintenance mode. Everything is basically put to a stop, a halt.  <br />
And these are the procedures we're going to follow   <br />
from the first hour, We're going to assess what exactly happened and why it happened.  <br />
The second hour, we're going to start putting in place the backups in the recovery procedures in place.  <br />
The third hour, we're going to give a status report.  <br />

#### WHAT CAN GO WRONG?
1- HARDWARE FAILURES: hard drive Could be five years old, six years old, have a lot of reads and writes just one day i'm done
2- VIRUSES
3- POWER OUTAGES: Power outages, short circuiting of components.
4- HACKERS
5- HUMAN ERROR

#### HOW DO I MAKE A PLAN
DETERMINE WHAT NEEDS TO BE BACKED UP <br />
you may have to back up your operating system because your operating system may have certain options in place. <br />

#### WHAT TO BACKUP 
1- FULL BACKUP
2- INCREMENTAL
3- DIFFERNTIAL
4- TRANSACTION LOG

Always do a full backup of your database first, always have one for backup. And then from there you can go in the side.
Well, am I going to do more full backups or what am I going to do from here on out?
Am I always going to do a full that's a very good strategy.
you could, hey, let me do an incremental backup. And an incremental backup is basically saying, hey, here's my full backup.
When you do your very first full backup, when you do an incremental backup, you're doing everything 
that changed since the last incremental backup. It's everything that changed since the last incremental.

then you have a differential backup, it's always everything that changed since the first full backup.

And then you have transaction log.
Transaction log is one of those things where on a day to day basis transactions are happening, people
are committing to the code base changes are happening.
This is like a live snapshot of what happened that hour, that day that whatever increment you take
transaction logs at, which should be at a short interval, you want it maybe every 15, half an hour,or every 1 or 2 hours <br/>

#### BACKING UP In Postgres
[Chapter 25. Backup and Restore](https://www.postgresql.org/docs/12/backup.html) <br/>
[Reliable PostgreSQL Backup & Restore](https://pgbackrest.org/) <br/>

------
#### TRANSACTIONS
At the end of the day, a database is a shared resource. So many, many users will access it concurrently.
updates, deletes, drops, creates. All of these things affect the state of the database.
And since the database is shared, well, how do we make sure that when five or six or seven people
are accessing it, that the database stays consistent? <br />

That's where we look at transactions, transactions are a unit of instructions you see with transactions.
Basically, what we're trying to achieve is a unit of instructions that is going to run in isolation
and not affect the state of the database until it's done.

HOW WE WE KEEP THINGS CONSISTENT?
the DBMS has a mechanism in place to manage transactins <br />

And then it becomes a question of if someone is going to commit those changes, then it becomes a question
of, well, who's first?<br />
And that's where the database will get smart and it will lock certain resources while an update is happening
so that other transactions won't get into a weird state.

<img src="https://user-images.githubusercontent.com/40498170/132083633-d5e51640-fb19-4196-8120-7335eded3b7a.png"  width="1000" height="300" />
So when we look at the life cycle of a transaction, we see that a transaction will start.So you're running your query, right?
And that goes into an active state.And so when it goes into an active state, well, then it's going to run itself.
And so then it's going to execute itself. This is what we call partially committed.
But if it fails for any reason, well, then it it'll get aborted. 
So if it fails because something else is utilizing that resource or it just failed because of a query
misbehave, then it will go into a failed state, it will be aborted and the transaction will automatically be ended.

#### show case between two sessions doing conflict transaction

```
A                                                             | B
BEGIN;                                                        | BEGIN;
DELETE FROM employees WHERE emp_no BETWEEN 10000 AND 10005;   |                                                       
*  partially commited state for A                             |
                                                              | DELETE FROM employees WHERE emp_no BETWEEN 10000 AND 10005;
                                                              | * for B it is hanging,resource is being locked
ROLLBACK                                                      | * unlcoked now, delete5,because A ended the T by rollingback
                                                              | END;
                                                              | * now the T is committed for B
BEGIN;                                                        |
DELETE FROM employees WHERE emp_no BETWEEN 10000 AND 10005;   |
delete 0: this transaction delete nothing                     |
END;                                                          |
 
```
 So basically, what it comes down to is in a transaction, when you're in this partially committed state,
 what you decide to do, whether you decide to commit or abort really determines how other transactions
 are going to play out.
 resources get locked while transactions are happening and they are in this partially committed
 state if you're trying to access or do something to the same resource.
 
 #### TRANSACTIONS PROPERTIES (ACID)
 * ATOMICITY: EITHER EXECUTE ENTIRELY OR NOT AT ALL
 * CONSISTENCY: EACH TRANSACTION SHOULD LEAVE THE DATABASE IN A CONSISTENT STATE (COMMIT OR ROLLBACK)
 * ISOLATION: TRANSACTION SHOULD BE EXECUTED IN ISOLATION FROM OTHER TRANSACTIONS
 * DURABILITY: AFTER COMPLETION FO A TRANSACTION, THE CHANGES IN THE DATABASE SHOULD PERSIST
 
 The I and acid isolation transactions should be executed in isolation from other transactions. <br/>
 OK, this is important because when we look at transactions, they can't go and affect each other.
 They're both basically think of it like them executing in two separate sandboxes.
 So you start a transaction to start a transaction. they both have access to the same database.<br />
 But what's actually happening is they've created this little sandbox in which they can play.
 They can update, delete, insert, select. They can do all of these things within that transaction.
 And then when they decide, hey, I'm going to commit, well, that's when the database management software
 kicks in and says, well, this transaction is doing these things. So what you're doing may fail roll back, probably. <br/>
 
 But what we're trying to say here is that transactionA & transaction B started off with the same sandbox.
 But what happened in Transaction A isn't known to transaction B until time of commit or roll 
 
 

 
 
 
 
 
                       





















      
    
    
 























  
 
 
 
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
  
  

  
