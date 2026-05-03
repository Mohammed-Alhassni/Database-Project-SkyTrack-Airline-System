use SAS 

--Upate Tasks

update Flight set status = 'Completed' where flight_num = 4

update Flight set status = 'Cancelled' where flight_num = 5

update Booking set price_paid = price_paid + price_paid * 0.1
--or UPDATE Booking SET price_paid = price_paid * 1.1;

update Passenger set phone =9999999 where national_id =1

update Crew_member set role = 'Pilot' where license_number =2



