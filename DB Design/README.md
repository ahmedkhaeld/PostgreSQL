# DATABASE AND SYSTEM DESIGN
### SOFTWARE DEVELOPMENT LIFE CYCLE  SDLC
<img src="https://user-images.githubusercontent.com/40498170/132107908-ade42033-ce2d-44e4-abc9-06f89745d5e0.png" width="900" height="300" />

* PHASE 1: REQUIRMENTS ANALYSIS <br />
THIS ENTIRE PHASE IS ABOUT GETTING THE INFORMATION ON WHAT NEEDS TO BE DONE (SCOPE) <br />

* PHASE 2: SYSTEM ANALYSIS <br />
TAKING IN THE REQUIREMENTS AND ANALYZING IF IT CAN BE DONE ON TIME AND ON BUDGET <br />

* PHASE 3: SYSTME DESIGN <br />
DESIGNING THE SYSTME ARCHITECTURE FOR ALL RELATED COMPONENTS: DATABASES, APPS <br />

* PHASE 4: SYSTEM IMPLEMENTATION <br />
BUILDING THE SOFTWARE <br />
----
#### FROM CHAOS TO STRUCTURE
SYSTEM DESIGN IS ALL ABOUT CREATING STRUCTURE THAT CAN BE UNDERSTOOD AND COMMUNICATED
* TOP-DOWN APPROACH: <br />
START FROM 0. OPTIMAL CHOICE WHEN CREATING A NEW DATABASE. ALL REQS ARE GATHERED UP-FORNT <br />
* BOTTOM-UP <br />
THERE'S AN EXISTING SYSTEM OR SPECIFIC DATA IN PLACE. YOU WANT TO SHAP A NEW SYSTEM AROUND THE EXISTING DATA. 
OPTIMAL CHOICE WHEN MIGRATING AN EXISTING DATABASE
----
#### STUDY CASE: DRIVEME ACADEMY <br />
is a driving school where people can take lessons base across the USA. <br />
every school has instructors on payroll and an inventory of cars, truck and motorcycles for teaching.<br />
GOAL: become a household name across the USA for learning how to drive. <br/ >

### Top Down Approach

#### DRIVEME: core reqs
- there's a vechicle inventory for students to rent
- there are employees at every branch
- there is maintenance for the vechiles
- there is an optional exam at the end of your lessons 
- you can only take the exam twice, fail twice, and you must take more lessons
#### CREATE A DATA MODEL BASED ON THE REQS

#### step 1: Entities <br />
<img src="https://user-images.githubusercontent.com/40498170/132117803-804da282-fccf-4b51-b7bd-69182f60aabb.png" width="800" height="400" />
<br/>
 what we're going to do here is we're just going to describe the entities.
 
*  students. <br />
*  Driver instructor. <br />
* vehicles. <br />
* maintenance for vehicles. <br />
what would you hold in a maintenance field? <br/>
Why are we talking about maintenance? <br/>
to determine whether it should be an entity or it's just data that we hold. 
maintenance is a tricky one because when we think of maintenance, well, date of maintenance, what kind of maintenance.
Who did it, where did it happen?. And so now it becomes tricky because vehicles are maintained multiple times a year. <br />
* exams. <br/>
So a student takes an exam now a student to take an exam twice. 
So there are multiple instances of an exam and we want to know the pass or fail.
And you can take it two times and then take more lessons and then take it two more times so you can <br/>
* lessons <br/>
you can only take the exam twice, feel twice, and you must take more lessons. This is a constraint.

So let's order these in a way that makes sense. <br/>
So the school has students and instructors, students follow a lesson. Lessons will have a vehicle and a vehicle has maintenance.
And students can take exams

#### step 2: Attributes <br />
- must be a property of the entity
- must be atomic
- single/multivalued
- keys

### RELATIONAL MODEL

* RELATIONAL SCHEMA
<img src="https://user-images.githubusercontent.com/40498170/132119276-c798b4f0-c2a1-43c5-8bdb-51a62f87077b.png " /> <br/>
we would call the table schema. It is a representation of the data that is going to go into the table. <br />

* RELATIONAL INSTANCE 
<img src="https://user-images.githubusercontent.com/40498170/132119364-e860fb8f-b93a-4270-a994-4a43d38cdfe1.png" /> <br/>
the relation instance is the set of data that relates to the relation schema.
So it's referring to all of the tuples or rows or data inside of that table. <br />

* RELATION KEY <br/>
So the relation key now, we're hitting a pivotal point in the relational model because we're pinpointing
a part of the relational model that is vital to the way that we are going to structure our relationships.
by uniquely identifying each and every row.

  SUPER KEY <br/>
  <img src="https://user-images.githubusercontent.com/40498170/132119498-3ef10b44-3526-4fce-8fc4-37c6da3514dd.png " />
A super key is any combination of attributes that uniquely identify the row. <br />

CANDIDATE KEY <br />
<img src="https://user-images.githubusercontent.com/40498170/132119897-16b6399c-91ad-4cc0-b18e-920814c2a77a.png" /> <br/>
a candidate key is a subset of super key <br />
any combination of these attributes can form a super key as long as they uniquely identify the row. <br/>
But a candidate Key says the minimal amount of attributes that are needed to uniquely identify the row <br />

#### Primary key and Foreign key
<img src="https://user-images.githubusercontent.com/40498170/132120590-e33ef1e5-a937-4cd7-8b8c-878323e0ca33.png " width="1000" height="500" />

So any combination of all of these columns that could uniquely identify the role are considered a super key.
And then we take that and we narrow it down and we say a candidate key is the minimum amount of attributes. <br/>
But what are we going to do with this candidate? <br/>
Well, once we have the key that uniquely identifies the role, we are going to call that our primary key. <br />
now how do we draw our relationships? <br/>
So we have our primary keys and we have them in both the manager table and the employee table. <br/>
now I want to link the managers to their employees who this report to you.
We add a column to the employee table and we call that the foreign key.
We give the column a very specific name, manager_id, And linking it to the manager table <br/>

Now, the data that is filled in automatically has a constraint.
And that constraint is that we can only fill in values that match a value that exists in the manager table primary key <br/>
And we have that direct correlation. One employee can only report to one manager. <br/>

THE COMPOUND KEY: <br />
multiple columns here are uniquely identifying my data and a foreign key <br/>
THE COMPOSITE KEY: <br />
are keys that are formed between multiple columns to uniquely identify data without using the foreign key. <br/>

### DriveMe Atrributes
```
School:  
(school_id,  street_name, street_no, postal_code, state, city)

Instructor: 
(teacher_id, first_name, last_name, hiring_date, date_of_birth, school_id)

Student: 
(student_id, first_name, last_name, date_of_birth, school_id)

Exam:    
(exam_id, student_id, teacher_id, date_take, passed,, lesson_id) 

Lesson:  
(lesson_id, date_of_enrollment, package, student_id)
```

#### step 3: Relationships
links 2 entities togther:  <br/>
- 1 to 1 e.g one student has one car 
- 1 to many  e.g one student can be taught by many teachers
- many to many e.g school has multiple teachers and teacher related to multiple schools

#### CROWSFEET
MULTIPLICITY: ONE OR MANY (left sign) <br/>
CONSTRAINTS : MUST OR OPTIONAL (right sign) <br/>

| Diagram | Description |
| --- | --- |
| <img src="https://user-images.githubusercontent.com/40498170/132123809-0e62815c-f9b2-4701-bf3c-bb6041b9c669.png" width="200" height="100" /> | Many, value could be zero  |
| <img src="https://user-images.githubusercontent.com/40498170/132123888-f2e7a980-5f0c-4738-8417-57ab24678c85.png" width="200" height="100"  />| Many, must have a value |
| <img src="https://user-images.githubusercontent.com/40498170/132123901-8d90a8bc-5171-4d05-af5c-ff80d3e9ba0e.png" width="200" height="100"  /> | One, must have a value |
| <img src="https://user-images.githubusercontent.com/40498170/132123914-5533cf63-f094-458f-a701-180a50dfab38.png" width="200" height="100"  /> | one, value could be zero|

### DriveMe Relationships

<img src="https://user-images.githubusercontent.com/40498170/132141708-2f498e0d-73b8-4792-bf4d-8ac14533a217.png " width="1000" height="500" />

#### Relations in Details

* a school has multiple instructors, but an instructor can only teach at one school

* a school has one or more students, but a student can only go to one school.

* look at lesson well, an instructor can teach one or more lessons, But a lesson only belongs to one instructor <br/>
students can take one or multiple lessons. a lesson can only belong to one student.

* In order to take an exam, you have to have taken lessons. so an exam belongs to one and only one lesson package, 
but a lesson can have multiple exams up to two. So one or more, so up to two.
an instructor can give one or more exams, but an exam can only be linked to one instructor because not multiple instructors administering an exam.
a student can take one or more exams, but An exam can only belong to one student.

* a lesson can have one and only one vehicle. And a vehicle can belong to one or multiple lessons

*  a vehicle can have zero or multiple maintenances. And then a maintenance can belong only to one and atleast one car

#### step 4: Many To Many
you can do it, but you really don't want to <br/>
you create more overhead: <br/>
insert, update, delete overhead. potential redundancy

* SHOW CASE:

 many to many relationship a book can have many authors and an author can write many books. <br />
 <img src="https://user-images.githubusercontent.com/40498170/132142698-851b2f05-e3f4-402e-9069-98e312f84269.png " />
 
 we have to have multiple foreign keys because we have two authors, Mo and Andre. And Andre was the author of Book one,
 and so was Mo. But for book two, it was only Andre.
 in the author table, we also now need to tell every single author which book they authored.
 So book one, book one and two, it becomes a column based insert update delete anomaly.
 Every time you create a relationship between these two, you have to add more columns because there
 are more relationships and it becomes difficult for you to update and delete.
 
 <img src="https://user-images.githubusercontent.com/40498170/132142699-6ce8d9ba-8b70-48df-a091-4e9200d3398b.png " />
 
 intermediate entity types or intermediate tables. <br/>
 A book can have multiple book authors and an author can author multiple books.
 
 #### step 5: Subject Area
 divide entities into logical groups that are related  <br/>
 
 SUBJECT ARE RULES: <br/>
 
 * all entities must belong to one <br/>
 * an entity can only belong to one <br/>
 * you can nest subject areas <br/>
----

SHOW CASE: CINEMA <br/>
solve a many to many relationship and keep it simple <br/>
a relationship between a movie and auditorium and a theater and a movie can be played in multiple auditoriums and multiple
auditoriums, can play multiple movies. This is because they are played at multiple times during the day.

<img src="https://user-images.githubusercontent.com/40498170/132150284-3de52fb8-b690-441b-9c30-ebf04f53536c.png " />

solution <br/>

<img src="https://user-images.githubusercontent.com/40498170/132150417-b3f93e58-a7a2-4957-8761-631025650fbd.png " width="1000" height="200" />
A theater has multiple auditoriums and an auditorium only belongs to one theater, of course, because
you do not have the ability to put an auditorium in multiple theaters at the same time it is in that theater
And so an auditorium can have multiple showings. It can have zero or multiple showings to be exact.

----

### BOTTOM-UP APPROACH <br/>

TO CREATE A DATA MODEL FROM SPECIFIC DETAILS. EXISTING SYSTEM, LEGACY SYSTEMS. WITHOUT REDUNDANCY AND ANOMALIES <br/>

1- IDENTIFY THE DATA (ATTRIBUTES) <br/>
2- GROUP THEM (ENTITIES) <br/>

* ANOMALIES <br/>

MODIFICATION ANOMALIES ARE PROBLEMS THAT ARISE WHEN YOUR DATABASE IS NOT STRUCTURED CORRECTLY. 
UPDATE INSERT DELETE ANOMALIES <br/>

* UPDATE ANOMALIES <br/>
we need to make sure the changes apply to all related data <br/>

<img src="https://user-images.githubusercontent.com/40498170/132151856-9f650c9a-9eb1-4109-8d28-1ba50a7e2856.png" />

as highlighted in red. 
Let's see that the branch Toronto changed her address to one hundred and one Front Street.
Well, when we update the record , all of a sudden we need to make sure that each and every one of these records 
gets updated correctly. So we have to make an update that goes and looks at each branch that is in Toronto and updates
the address for each and every one of those instances. because it's all in the same table, 

* DELETE ANOMALIES <br/>
we need to make sure we don't lose important data <br/>

<img src="https://user-images.githubusercontent.com/40498170/132152602-d766ef6f-f1c3-4f9a-8d22-27bfdcc022d2.png" />

as highlighted in red.
if we delete client number three, suddenly our branch disappears. ecause we're storing the branch with the customer
and we delete customer number three, suddenly we know nothing about our branch in Scarbro, our branch
at 20 Beech Street, because we have created a direct functional dependency between the customer in the branch.

* INSERT ANOMALIES <br />
we need to check that the data is consistent <br/>

<img src="https://user-images.githubusercontent.com/40498170/132153552-599dd380-67e4-43eb-9c55-f83cc6e1bc67.png" />

How do we make sure that when we want someone to bank in Toronto that if someone fills in the street wrong, 
how we validate that?!
Inserting new data means that, well, now we need to make sure that when new data is inserted,
that is consistent with the rest of the data.
So this dependency between branch and customer, we really need to separate it.

And so with bottom up design. <br/>
What we're trying to get to is basically looking at those dependencies between data and making them into their own entities
What we're trying to achieve here is basically making it so that each individual customer only has the
data that they need to update for themselves, that the dependency of the data of the customer only is about the customer.
know about their branch as a relationship, but it doesn't need to store the information about the branch

This is the process that you follow in bottom up design to come to an 
isolated way and don't create these anomalies or redundancy of information being stored in a table

#### NORMALIZATION
IS KEY TO AVOID ANOMALIES! <br/>
TO UNDERSTAND NORMALIZATION WE MUST UNDERSTAND FUNCTIONAL DEPENDENCIES AND  NORMAL FORMS

FUNCTIONAL DEPENDENCY: <br/>
shows a relationship between attributes, it's showing a relationship between the data itself inside a table <br/>
we say that A is functional dependent on B when a value of B determines a value of A B ---> A <br/>
what does this actually mean?
it means that based on the value of B you can determine the value of A  emp_no ---> first_name <br/>
for the emp_no, we will find ONE and ONLY first_name. <br/> 
NOTE: THE DETERMINANT MUST HAS A UNQUIE VALUE ON THE DEPENDENT
but if we did a functinal dependency first---> emp_no <br/>
will you can a have a lot of first_name that are exact the same,a 10 hamos and they will be correspond to a different emp_no <br/>

| Example 1 | Example 2 | Example 3 |
| :---         |     :---:      |          ---: |
| <img src="https://user-images.githubusercontent.com/40498170/132159139-63010b51-0c96-4c8f-807b-43d18df185f0.png"/>   |  <img src="https://user-images.githubusercontent.com/40498170/132159141-f87814d6-279d-4ba8-9147-2416a34219aa.png"/>   | <img src="https://user-images.githubusercontent.com/40498170/132159274-53411122-f3da-49e6-9270-7daaef915a89.png"/>    |

-  NORMALIZATION <br/>
0NF -> 1NF -> 2NF -> 3NF -> BCNF -> 4NF -> 4NF -> 5NF <br/>
each normal form aims to further separate relationships into smaller instances as to create less redundancy & anomalies <br/>

 



- 0NF <br/>

DATA IS IN 0 NORMAL FORM WHEN IT IS UNNORMALIZED:  <br/>
1- REPEATING GROUPS OF FIELDS  <br/>
2- POSITONAL DEPENDENCE OF DATA  <br/>
3- NON-ATOMIC DATA  <br/>
<img src="https://user-images.githubusercontent.com/40498170/132166652-c77c4892-aa69-4661-beaa-10603ac1d3aa.png"  width="600" height="300"/>

-  ACHIEVE 1NF  <br/>
1- ELIMINATE REPEATING COLUMNS OF THE SAME DATA  <br/>
2- EACH ATTRIBUTE SHOULD CONTAIN A SINGLE VALUE  <br/>
3- DETERMINE A PRIMARY KEY <br/>

| violation     | solution |
| ---      | ---       |
|<img src="https://user-images.githubusercontent.com/40498170/132167216-491d93a9-1d0c-466b-b3f1-1eff439a9992.png"/>  | <img src="https://user-images.githubusercontent.com/40498170/132167222-79efb956-634d-47f5-a66d-f2248afbbc9b.png"/>          |

- ACHIEVE 2NF  <br/>
1- IT IS IN 1NF <br/>
2- ALL NON-KEY ATTRIBUTES ARE FULLY FUNCTINAL DEPENDENT ON THE PRIMARY KEY (no partial dependency)  <br/>

UNDERSTAND WHAT IS PARTIL DEPENDENCY <br/>
here the primary key is composite which is score_id&student_id <br/>
but teacher column depends on subject_id which is not the primary key

| violation | solution | final solution |
| :---         |     :---:      |          ---: |
| <img src="https://user-images.githubusercontent.com/40498170/132168929-e54a5638-9822-4553-aa32-e442a0a9be3a.png"/>   | <img src="https://user-images.githubusercontent.com/40498170/132168997-ff433c27-4b11-465d-b379-65ff98bc3c83.png"/>   | <img src="https://user-images.githubusercontent.com/40498170/132169099-7a17fad5-fc9f-4d9d-996f-54c3fae72c99.png"/>    |

- ACHIEVE 3NF  <br/>
1- IT IS IN 1NF and 2NF <br/>
2- NO TRANSITIVE DEPENDENCIES  A (non-prime)--> B (non-prime) <br/>

| violation    | solution |
| ---      | ---       |
| <img src="https://user-images.githubusercontent.com/40498170/132174599-640c7477-a81a-42c0-97a5-09a766992036.png"/> | <img src="https://user-images.githubusercontent.com/40498170/132174636-c508f3ca-568c-45ab-b825-7a547d4c5579.png"/>         |

- ACHIEVE BCNF  <br/>
1- IT IS IN 3NF  <br/>
2- FOR ANY DEPENDENCY A-->B A SHOULD BE SUPER KEY  <br/>

  3NF ALLOWS ATTRIBUTES TO BE PART OF A CANDIDATE KEY THAT IS NOT THE PRIMARY KEY- BCNF DOES NOT 
  
- A RELATIONSHIP IS NOT IN BCNF IF:    <br/>
1- THE PRIMARY KEY IS A COMPOSITE KEY   <br/>
2- THERE IS MORE THAT ONE CANDIDATE KEY   <br/>
3- SOME ATTRIBUTES HAVE KEYS IN COMMON   <br/>
4- non-prime attribute --> prime attribute  <br/>

| example | case: not BCNF | non-prime drives prime |   solution     | 
| :---         |     :---:      |     :---:     |  ---:  |
| <img src="https://user-images.githubusercontent.com/40498170/132178238-6b13cdbf-14a5-4788-bc8e-7bfccef7c9e3.png"/>   |<img src="https://user-images.githubusercontent.com/40498170/132178575-141513f8-f121-4144-8ace-0ed16a38f75c.png"/>     | <img src="https://user-images.githubusercontent.com/40498170/132178880-4267c7e8-8fdb-4f64-8942-67d8d9aa7038.png"/>    |  <img src="https://user-images.githubusercontent.com/40498170/132178992-2cd7470f-9949-4f89-8ca2-7633dca1683c.png"/>      |




 








 













































