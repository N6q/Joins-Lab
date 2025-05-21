USE University;


-----1. Display the department ID, name, and the full name of the faculty managing it. 
SELECT d.Department_id AS 'Department ID', d.D_name AS 'Depatment Name', f.Name AS 'Full Name'
FROM DEPARTMENT d 
JOIN FACULTY f ON d.Department_id = f.Department_id;

-----2. Display each program's name and the name of the department offering it. 

SELECT p.Course_name AS 'Course Name', d.D_name AS 'Department Name'
FROM DEPARTMENT d 
	JOIN COURSE p 
		ON p.Course_id = d.Department_id;


-----3. Display the full student data and the full name of their faculty advisor. 

SELECT s.* , f.Name
FROM STUDENT s 
JOIN DEPARTMENT	d
		ON d.Department_id= s.Department_id
	JOIN FACULTY f 
		ON d.Department_id = f.F_ID;


-----4. Display class IDs, course titles, and room locations for classes in buildings 'A' or 'B'.


-----5. Display full data about courses whose titles start with "I" (e.g., "Introduction to..."). 
SELECT *
FROM COURSE
Where Course_name LIKE 'I%';

-----6. Display names of students in program ID 3 whose GPA is between 2.5 and 3.5. 

SELECT concat (s.F_name,'',s.L_name ) AS 'Full Name'
FROM STUDENT s 
JOIN DEPARTMENT	d
		ON d.Department_id= s.Department_id
	JOIN COURSE c 
		ON d.Department_id = c.Course_id
Where c.Course_id= 2 ;




-----7. Retrieve student names in the Engineering program who earned grades ≥ 90 in the "Database" course. 
SELECT CONCAT(s.F_name, ' ', s.L_name) AS Student_Name
FROM STUDENT s
JOIN Belong b ON s.S_ID = b.S_ID
JOIN DEPARTMENT d ON b.Department_id = d.Department_id
JOIN Enroll e ON s.S_ID = e.S_ID
JOIN SUBJECT sub ON e.Subject_id = sub.Subject_id
WHERE d.D_name = 'Engineering'
  AND sub.Subject_name = 'Database';






-----8. Find names of students who are advised by "Dr. Ahmed Hassan". 
SELECT CONCAT(s.F_name, ' ', s.L_name) AS Student_Name
FROM STUDENT s
JOIN DEPARTMENT d ON d.Department_id = s.Department_id
JOIN FACULTY f ON d.Department_id = f.Department_id
WHERE f.Name = 'Dr. Ahmed Hassan';


-----9. Retrieve each student's name and the titles of courses they are enrolled in, ordered by course title. 
SELECT CONCAT(s.F_name, ' ', s.L_name) AS Student_Name, c.Course_name
FROM STUDENT s
JOIN Enroll e ON s.S_ID = e.S_ID
JOIN SUBJECT sub ON e.Subject_id = sub.Subject_id
JOIN COURSE c ON sub.Course_id = c.Course_id
ORDER BY c.Course_name;

-----10. For each class in Building 'Main', retrieve class ID, course name, department name, and faculty name teaching the class. 
SELECT 
  e.Exam_code AS Class_ID,
  c.Course_name,
  d.D_name AS Department_Name,
  f.Name AS Faculty_Name
FROM EXAMS e
JOIN Conducted_By cb ON e.Exam_code = cb.Exam_code
JOIN DEPARTMENT d ON cb.Department_id = d.Department_id
JOIN Department_Handles_Course dhc ON d.Department_id = dhc.Department_id
JOIN COURSE c ON dhc.Course_id = c.Course_id
JOIN Handles h ON c.Course_id = h.Course_id
JOIN FACULTY f ON h.F_ID = f.F_ID
WHERE e.Room LIKE '%Main%';

-----11. Display all faculty members who manage any department. 

-----12. Display all students and their advisors' names, even if some students don’t have advisors yet.

SELECT CONCAT(s.F_name, ' ', s.L_name) AS Student_Name,
       f.Name AS Faculty_Name
FROM STUDENT s
LEFT JOIN FACULTY f ON s.Department_id = f.Department_id;
