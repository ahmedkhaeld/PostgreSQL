# PostgreSQL
# DB Management: WHAT TO LEARN
* THE DIFFERENT TYPES OF DATA
* HOW TO CREAT A DATABASE
* HOW TO CREATE TABLES
* HOW TO INSERT/UPDATE/...DATA
## TYPES OF DATABASES IN A RDBMS

![Screenshot from 2021-08-31 19-11-12](https://user-images.githubusercontent.com/40498170/131546582-0812e384-4db2-4d0e-972d-3d2ecd5cddc9.png)
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
  ~ `psql -U <user> <database>` <br />
  ~ `postgres-# \conninfo` <br />
  ` You are connected to database "postgres" as user "postgres" via socket in "/temp" at port "5432" ` <br />
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
  It's about not interfering with the global data, right? If you separate things into schemas, you can have duplicate names, you can have duplicate named objects
  that are not necessarily the same because they're in a different logical group. But you're still operating on the same database.<br />
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






















  
 
 
 
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
  
  

  
