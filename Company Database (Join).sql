-- 1. Display the department ID, department name, manager ID, and the full name of the manager.
SELECT d.Dnum, d.Dname, d.MGRSSN, CONCAT(e.Fname, ' ', e.Lname) AS FullName
FROM Departments d
JOIN Employee e ON d.MGRSSN = e.SSN;

-- 2. Display the names of departments and the names of the projects they control.
SELECT d.Dname, p.Pname
FROM Departments d
JOIN Project p ON d.Dnum = p.Dnum;

-- 3. Display full data of all dependents, along with the full name of the employee they depend on.
SELECT d.*, CONCAT(e.Fname, ' ', e.Lname) AS FullName
FROM Dependent d
JOIN Employee e ON d.ESSN = e.SSN;

-- 4. Display the project ID, name, and location of all projects located in Cairo or Alex.
SELECT p.Pnumber, p.Pname, p.Plocation
FROM Project p
WHERE p.City = 'Cairo' OR p.City = 'Alex';

-- 5. Display all project data where the project name starts with the letter 'A'.
SELECT p.*
FROM Project p
WHERE p.Pname LIKE 'A%';

-- 6. Display the IDs and names of employees in department 30 with a salary between 1000 and 2000 LE.
SELECT e.SSN, CONCAT(e.Fname, ' ', e.Lname) AS FullName
FROM Employee e
JOIN Departments d ON e.Dno = d.Dnum
WHERE d.Dnum = 30 AND e.Salary BETWEEN 1000 AND 2000;

-- 7. Retrieve the names of employees in department 10 who work ≥ 10 hours/week on the "AL Rabwah" project.
SELECT CONCAT(e.Fname, ' ', e.Lname) AS FullName
FROM Employee e
JOIN Departments d ON e.Dno = d.Dnum
JOIN Works_for w ON e.SSN = w.Essn
JOIN Project pj ON w.Pno = pj.Pnumber
WHERE d.Dnum = 10 AND pj.Pname = 'AL Rabwah' AND w.Hours >= 10;

-- 8. Find the names of employees who are directly supervised by "Kamel Mohamed".
SELECT CONCAT(e.Fname, ' ', e.Lname) AS FullName
FROM Employee e
JOIN Employee s ON e.Superssn = s.SSN
WHERE s.Fname = 'Kamel' AND s.Lname = 'Mohamed';

-- 9. Retrieve the names of employees and the names of the projects they work on, sorted by project name.
SELECT CONCAT(e.Fname, ' ', e.Lname) AS FullName, pj.Pname AS ProjectName
FROM Employee e
JOIN Works_for w ON e.SSN = w.Essn
JOIN Project pj ON w.Pno = pj.Pnumber
ORDER BY pj.Pname;

-- 10. For each project located in Cairo, display the project number, controlling department name,
--     manager's last name, address, and birthdate.
SELECT pj.Pnumber, d.Dname AS DepartmentName, m.Lname AS ManagerLastName, m.Address, m.Bdate
FROM Project pj
JOIN Departments d ON pj.Dnum = d.Dnum
JOIN Employee m ON d.MGRSSN = m.SSN
WHERE pj.City = 'Cairo';

-- 11. Display all data of managers in the company.
SELECT *
FROM Employee
WHERE SSN IN (
SELECT MGRSSN FROM Departments
);

-- 12. Display all employees and their dependents, even if some employees have no dependents.
SELECT e.SSN, e.Fname, e.Lname, d.Dependent_name, d.Sex, d.Bdate
FROM Employee e
LEFT JOIN Dependent d ON e.SSN = d.ESSN;
