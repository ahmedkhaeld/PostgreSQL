
-- COALESCE: ENABLE TO REPLACE NULL VALUE IN A COLUMN THAT MAY HAVE NULL IS THERE ANY WITH SUBTITUTE
-- COALESCE: MEANS PUT A FALLBACK VALUE TO IS NEARLY THE FIELD WOULD HAVE

SELECT sum(coalase(age, 15)) AS age
FROM students
-- here if there a null field then put the age to 15, 
-- so that to not leave a person that should have an age to reach approx sum all the students

