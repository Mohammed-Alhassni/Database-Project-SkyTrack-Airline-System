use SAS 

--Upate Tasks
-- 1. Update one flight status from 'Scheduled' to 'Completed'.
update Flight set status = 'Completed' where flight_num = 4

-- 2. Change one flight status from 'Delayed' to 'Cancelled'.
update Flight set status = 'Cancelled' where flight_num = 5

-- 3. Increase all Economy class booking prices by 10%.
update Booking set price_paid = price_paid + price_paid * 0.1
-- or UPDATE Booking SET price_paid = price_paid * 1.1;

-- 4. Update one passenger's phone number.
update Passenger set phone =9999999 where national_id =1

-- 5. Move one crew member to a different role.
update Crew_member set role = 'Pilot' where license_number =2


/* Delete Tasks */

-- 1. Delete one cancelled flight.
select * from Flight
delete from Flight where flight_num = 7 

-- 2. Delete one booking linked to a cancelled flight.
select * from Flight -- the cancelled flight has flight_num=5 
-- select top 1 flight_num from Flight where status = 'Cancelled' --it return 5 only which can be used in subquery (top 1 needed)
select * from Booking where flight_num=5 
delete from Booking where booking_id = 6

/*
DELETE FROM Booking 
WHERE flight_num = (
	SELECT TOP 1 flight_num 
    FROM Flight 
    WHERE status = 'cancelled'
);
*/ 

-- 3. Try to delete a passenger who has existing bookings. Observe what happens and write a short comment in your SQL file explaining the result.
select * from Booking
select * from Passenger
delete from Passenger where national_id = 2
/* 
Output: 

(1 row affected)

Completion time: 2026-05-03T16:41:30.5510377+04:00

observation: it deleted the raw from Passanger and inside the booking there is 2 raw reference it,
it also deleted them because they reference it.
*/