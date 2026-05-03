use SAS

-- 1. List all flights and their current status, ordered by departure datetime from earliest to latest.
select *
from Flight
order by depature_datetime
--default is asc, smaller is early in case of time

-- 2. Show all passengers, ordered alphabetically by full name. 
select *
from Passenger
order by f_name, l_name
-- sort first name then last
-- SELECT * FROM Passenger ORDER BY f_name + ' ' + l_name; --SQL server
-- SELECT * FROM Passenger ORDER BY f_name || ' ' || l_name; --SQL

-- 3. List all aircraft and their seating capacity, ordered from largest to smallest. 
select *
from Aircraft
order by seat_capacity desc
-- 4. Show all bookings and their class. Display only distinct class values that exist in the system.
-- 5. List all flights that have a status of 'Delayed' or 'Cancelled'.
-- 6. Show all passengers whose nationality is 'Omani'. 
-- 7. List all airports, ordered by country.