----------------------Airline Database – JOIN Queries 
---------1. Display each flight leg's ID, schedule, and the name of the airplane assigned to it. 
SELECT DISTINCT fl.leg_no, 
       fl.scheduled_dep_time, 
       fl.scheduled_arr_time, 
       a.typeName AS Airplane_Type
FROM FLIGHT_LEG fl
JOIN RESERVATION r ON fl.leg_no = r.leg_no
JOIN AIRPLANE a ON r.airplane_id = a.airplane_id;

---------2. Display all flight numbers and the names of the departure and arrival airports. 
SELECT fl.flight_no, 
       a1.name AS Departure_Airport, 
       a2.name AS Arrival_Airport
FROM FLIGHT_LEG fl
JOIN AIRPORT a1 ON fl.departure_airport = a1.airport_code
JOIN AIRPORT a2 ON fl.arrival_airport = a2.airport_code;


---------3. Display all reservation data with the name and phone of the customer who made each booking. 
SELECT r.*, c.name, c.phone
FROM RESERVATION r
JOIN CUSTOMER c ON r.customer_id = c.customer_id;


---------4. Display IDs and locations of flights departing from 'CAI' or 'DXB'. 
SELECT fl.leg_no, fl.flight_no, a.city AS Departure_City, a.state
FROM FLIGHT_LEG fl
JOIN AIRPORT a ON fl.departure_airport = a.airport_code
WHERE fl.departure_airport IN ('CAI', 'DXB');


---------5. Display full data of flights whose names start with 'A'. 
SELECT *
FROM FLIGHT
WHERE airline LIKE 'A%';


---------6. List customers who have bookings with total payment between 3000 and 5000. 
SELECT 
    c.customer_id,
    c.name,
    SUM(f.amount) AS total_payment
FROM RESERVATION r
JOIN CUSTOMER c ON r.customer_id = c.customer_id
JOIN FLIGHT_LEG fl ON r.leg_no = fl.leg_no
JOIN FARE f ON fl.flight_no = f.flight_no
GROUP BY c.customer_id, c.name
HAVING SUM(f.amount) BETWEEN 3000 AND 5000;


---------7. Retrieve all passengers on 'Flight 110' who booked more than 2 seats. 
SELECT c.name, COUNT(*) AS seats_booked
FROM RESERVATION r
JOIN CUSTOMER c ON r.customer_id = c.customer_id
JOIN FLIGHT_LEG fl ON r.leg_no = fl.leg_no
WHERE fl.flight_no = '110'
GROUP BY c.customer_id, c.name
HAVING COUNT(*) > 2;


---------8. Find names of passengers whose booking was handled by agent "Youssef Hamed". 

---------9. Display each passenger’s name and the flights they booked, ordered by flight date. 
SELECT c.name AS Customer_Name, fl.flight_no, li.date
FROM CUSTOMER c
JOIN RESERVATION r ON c.customer_id = r.customer_id
JOIN LEG_INSTANCE li ON r.leg_no = li.leg_no AND r.date = li.date
JOIN FLIGHT_LEG fl ON li.leg_no = fl.leg_no
ORDER BY li.date;

---------10. For each flight departing from 'Cairo', display the flight number, departure time, and airline name. 
SELECT f.flight_no, fl.scheduled_dep_time, f.airline
FROM FLIGHT_LEG fl
JOIN AIRPORT a ON fl.departure_airport = a.airport_code
JOIN FLIGHT f ON fl.flight_no = f.flight_no
WHERE a.name = 'Cairo';


---------11. Display all staff members who are assigned as supervisors for flights. 

---------12. Display all bookings and their related passengers, even if some bookings are unpaid.
SELECT r.*, c.name
FROM RESERVATION r
LEFT JOIN CUSTOMER c ON r.customer_id = c.customer_id;
