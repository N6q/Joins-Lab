-------Hotel Database – JOIN Queries 
-------1. Display hotel ID, name, and the name of its manager.
SELECT 
    b.Branch_ID,
    b.Name AS Hotel_Name,
    s.Name AS Manager_Name
FROM BRANCH b
JOIN STAFF s ON b.Branch_ID = s.Branch_ID
WHERE s.Job_Title = 'Manager';

-------2. Display hotel names and the rooms available under them. 

SELECT 
    b.Name AS Hotel_Name,
    r.Room_Number,
    r.Type
FROM ROOM r
JOIN BRANCH b ON r.Branch_ID = b.Branch_ID;

-------3. Display guest data along with the bookings they made. 

SELECT 
    c.Customer_ID,
    c.Name,
    c.Phone,
    b.Booking_ID,
    b.Check_In_Date,
    b.Check_Out_Date
FROM CUSTOMER c
JOIN BOOKING b ON c.Customer_ID = b.Customer_ID;

-------4. Display bookings for hotels in 'Hurghada' or 'Sharm El Sheikh'. 
SELECT 
    b.Booking_ID,
    br.Name AS Hotel_Name,
    br.Location
FROM BOOKING b
JOIN BOOKING_ROOM brm ON b.Booking_ID = brm.Booking_ID
JOIN BRANCH br ON brm.Branch_ID = br.Branch_ID
WHERE br.Location IN ('Hurghada', 'Sharm El Sheikh');

-------5. Display all room records where room type starts with "S" (e.g., "Suite", "Single"). 

SELECT *
FROM ROOM
WHERE Type LIKE 'S%';

-------6. List guests who booked rooms priced between 1500 and 2500 LE.

SELECT DISTINCT 
    c.Customer_ID,
    c.Name
FROM CUSTOMER c
JOIN BOOKING b ON c.Customer_ID = b.Customer_ID
JOIN BOOKING_ROOM brm ON b.Booking_ID = brm.Booking_ID
JOIN ROOM r ON brm.Room_Number = r.Room_Number AND brm.Branch_ID = r.Branch_ID
WHERE r.Nightly_Rate BETWEEN 1500 AND 2500;

-------7. Retrieve guest names who have bookings marked as 'Confirmed' in hotel "Hilton Downtown". 

SELECT DISTINCT 
    c.Name
FROM CUSTOMER c
JOIN BOOKING b ON c.Customer_ID = b.Customer_ID
JOIN BOOKING_ROOM brm ON b.Booking_ID = brm.Booking_ID
JOIN BRANCH br ON brm.Branch_ID = br.Branch_ID
JOIN CHECK_IN_OUT cio ON cio.Booking_ID = b.Booking_ID
WHERE cio.Action = 'Confirmed'
  AND br.Name = 'Hilton Downtown';


-------8. Find guests whose bookings were handled by staff member "Mona Ali". 

SELECT DISTINCT 
    c.Name
FROM CUSTOMER c
JOIN BOOKING b ON c.Customer_ID = b.Customer_ID
JOIN CHECK_IN_OUT cio ON b.Booking_ID = cio.Booking_ID
JOIN STAFF s ON cio.Staff_ID = s.Staff_ID
WHERE s.Name = 'Mona Ali';


-------9. Display each guest’s name and the rooms they booked, ordered by room type. 

SELECT 
    c.Name AS Guest_Name,
    r.Room_Number,
    r.Type
FROM CUSTOMER c
JOIN BOOKING b ON c.Customer_ID = b.Customer_ID
JOIN BOOKING_ROOM brm ON b.Booking_ID = brm.Booking_ID
JOIN ROOM r ON brm.Room_Number = r.Room_Number AND brm.Branch_ID = r.Branch_ID
ORDER BY r.Type;


-------10. For each hotel in 'Cairo', display hotel ID, name, manager name, and contact info. 

SELECT 
    br.Branch_ID,
    br.Name AS Hotel_Name,
    s.Name AS Manager_Name,
    s.Salary
FROM BRANCH br
JOIN STAFF s ON br.Branch_ID = s.Branch_ID
WHERE s.Job_Title = 'Manager' AND br.Location = 'Cairo';


-------11. Display all staff members who hold 'Manager' positions. 

SELECT *
FROM STAFF
WHERE Job_Title = 'Manager';


-------12. Display all guests and their reviews, even if some guests haven't submitted any reviews. 

SELECT 
    c.Customer_ID,
    c.Name,
    r.Review_Text,
    r.Rating,
    r.Review_Date
FROM CUSTOMER c
LEFT JOIN REVIEW r ON c.Customer_ID = r.Customer_ID;
