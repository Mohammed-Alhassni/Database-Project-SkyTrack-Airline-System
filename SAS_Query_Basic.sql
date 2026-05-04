use SAS

-- 1. List all flights and their current status, ordered by departure datetime from earliest to latest.
-- select * from Flight order by depature_datetime -- default is asc, smaller is early in case of time
select * from Flight
select * from Airport 
-- Corrected
select Flight.flight_num, Flight.status, Flight.depature_datetime, Flight.arrival_datetime, Airport1.name as origin, Airport2.name as destination from Flight 
INNER JOIN Airport Airport1 on Flight.origin_airport = Airport1.IATA
INNER JOIN Airport Airport2 on Flight.destination_airport = Airport2.IATA

-- 2. Show all passengers, ordered alphabetically by full name. 
-- select * from Passenger order by f_name, l_name
-- sort first name then last
-- SELECT * FROM Passenger ORDER BY f_name + ' ' + l_name; --SQL server
-- SELECT * FROM Passenger ORDER BY f_name || ' ' || l_name; --SQL
-- Enhanced
select f_name + ' ' + l_name as [full_name], email, phone, nationality, DOB from Passenger order by [full_name]

-- 3. List all aircraft and their seating capacity, ordered from largest to smallest. 
select * from Aircraft order by seat_capacity desc

-- 4. Show all bookings and their class. Display only distinct class values that exist in the system.
select booking_id, class from Booking
select distinct class from Booking

-- 5. List all flights that have a status of 'Delayed' or 'Cancelled'.
select * from Airport
select * from Flight
select Flight.flight_num,  Flight.depature_datetime,  Flight.arrival_datetime, Airport1.name as [origin], Airport2.name as [destination] from Flight
inner join Airport Airport1 on Flight.origin_airport = Airport1.IATA
inner join Airport Airport2 on Flight.destination_airport = Airport2.IATA
where status in('Delayed', 'Cancelled')

-- 6. Show all passengers whose nationality is 'Omani'. 
-- 7. List all airports, ordered by country.