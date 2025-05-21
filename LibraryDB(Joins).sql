-- Library Management System Database – JOIN Queries 

-- 1. Display library ID, name, and the name of the manager.
SELECT l.LibraryID, l.Name AS LibraryName, s.FullName AS ManagerName
FROM Libraries l
JOIN Staffs s ON l.LibraryID = s.LibraryID
WHERE s.Position = 'Manager';

-- 2. Display library names and the books available in each one.
SELECT l.Name AS LibraryName, COUNT(b.BookID) AS BookCount
FROM Libraries l
JOIN Books b ON l.LibraryID = b.LibraryID
WHERE b.IsAvailable = 1
GROUP BY l.Name;

-- 3. Display all member data along with their loan history.
SELECT m.*, l.LoanID, l.LoanDate, l.DueDate, l.ReturnDate, l.Status
FROM Members m
LEFT JOIN Loans l ON m.MemberID = l.MemberID;

-- 4. Display all books located in 'Zamalek' or 'Downtown'.
SELECT b.*
FROM Books b
JOIN Libraries l ON b.LibraryID = l.LibraryID
WHERE l.Location LIKE '%Zamalek%' OR l.Location LIKE '%Downtown%';

-- 5. Display all books whose titles start with 'T'.
SELECT *
FROM Books
WHERE Title LIKE 'T%';

-- 6. List members who borrowed books priced between 100 and 300 LE.
SELECT DISTINCT m.*
FROM Members m
JOIN Loans l ON m.MemberID = l.MemberID
JOIN Books b ON l.BookID = b.BookID
WHERE b.Price BETWEEN 100 AND 300;

-- 7. Retrieve members who borrowed and returned books titled 'The Alchemist'.
SELECT m.*
FROM Members m
JOIN Loans l ON m.MemberID = l.MemberID
JOIN Books b ON l.BookID = b.BookID
WHERE b.Title = 'The Alchemist' AND l.Status = 'Returned';

-- 8. Find all members assisted by librarian "Sarah Fathy".
SELECT m.*
FROM Members m
JOIN Loans l ON m.MemberID = l.MemberID
JOIN Staffs s ON l.BookID IN (SELECT BookID FROM Books WHERE LibraryID = s.LibraryID)
WHERE s.FullName = 'Sarah Fathy' AND s.Position = 'Librarian';

-- 9. Display each member's name and the books they borrowed, ordered by book title.
SELECT m.FullName AS MemberName, b.Title AS BookTitle
FROM Members m
JOIN Loans l ON m.MemberID = l.MemberID
JOIN Books b ON l.BookID = b.BookID
ORDER BY b.Title;

-- 10. For each book located in 'Cairo Branch', show title, library name, manager, and shelf info.
SELECT b.Title, l.Name AS LibraryName, s.FullName AS ManagerName, b.ShelfLocation
FROM Books b
JOIN Libraries l ON b.LibraryID = l.LibraryID
JOIN Staffs s ON l.LibraryID = s.LibraryID AND s.Position = 'Manager'
WHERE l.Name = 'Central Library';

-- 11. Display all staff members who manage libraries.
SELECT s.*
FROM Staffs s
WHERE s.Position = 'Manager';

-- 12. Display all members and their reviews, even if some didn't submit any review yet.
SELECT m.*, r.Rating, r.Comments, r.ReviewDate
FROM Members m
LEFT JOIN Reviews r ON m.MemberID = r.MemberID;