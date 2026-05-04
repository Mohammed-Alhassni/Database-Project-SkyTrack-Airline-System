use SAS


-- 1. For each flight, show the flight number, the name of the origin airport, and the name of the destination airport.
select * from Flight
select * from Airport
select Flight.flight_num, Airport1.name as [origin_airport],  Airport2.name as [destination_airport] from Flight
inner join Airport Airport1 on Flight.origin_airport=Airport1.IATA
inner join Airport Airport2 on Flight.destination_airport=Airport2.IATA

-- 2. Show each booking along with the full name of the passenger who made it and the flight number it belongs to.
select * from Booking
select * from Passenger
select Booking.booking_id, Passenger.f_name + ' ' + Passenger.l_name as [full_name], Booking.seat_number, Booking.booking_date, Booking.class, Booking.price_paid, Booking.flight_num from Booking
inner join Passenger on Booking.national_id=Passenger.national_id

-- 3. List all crew members assigned to flight '5', showing their full name and role.
select * from Crew_member
select * from Flight_crew
select Crew_member.f_name + ' ' + Crew_member.l_name as [full_name], Crew_member.role from Crew_member 
inner join Flight_crew on Crew_member.license_number = Flight_crew.license_number
where Flight_crew.flight_num = 5

-- 4. Show all completed flights along with the aircraft model used on each flight.
select * from Flight
select * from Aircraft
select Flight.flight_num, Flight.depature_datetime, Flight.arrival_datetime, Aircraft.model, Aircraft.manufacturer from Flight 
inner join Aircraft on Flight.reg_num = Aircraft.reg_num
where Flight.status = 'Completed'

-- 5. For each passenger, show their full name and the total number of bookings they have made. Order by booking count from highest to lowest.
select * from Passenger
select * from Booking
select Passenger.national_id , Passenger.f_name + ' ' + Passenger.l_name as [full_name],count(Booking.national_id) as [total_bookings] from Passenger 
left join Booking on Passenger.national_id=Booking.national_id --left join, because you also want to include Passangers with no Bookings
group by Passenger.f_name, Passenger.l_name, Passenger.national_id --items in select either warpped with agg fun or group by
order by [total_bookings] desc 


-- 6. Show the total revenue collected from each booking class.
select * from Booking
select Booking.class, sum(price_paid) as [total_revenue] from Booking 
group by Booking.class

-- 7. Count how many flights each aircraft has been assigned to.
select * from Flight
select * from Aircraft
select Aircraft.model, Aircraft.manufacturer, count(Flight.reg_num) as [total_flights] from Aircraft
left join Flight on Aircraft.reg_num = Flight.reg_num
group by Aircraft.model, Aircraft.manufacturer
order by total_flights desc

-- 8. List all flights that have more than one booking.
select * from Flight
select * from Booking
select * from Airport
select Flight.flight_num, Airport1.name as [origin], Airport2.name as [destination], Flight.depature_datetime, Flight.arrival_datetime, Flight.status, count(Booking.flight_num) as [booking_count] from Flight
inner join Booking on Flight.flight_num = Booking.flight_num
inner join Airport Airport1 on Airport1.IATA = Flight.origin_airport
inner join Airport Airport2 on Airport2.IATA = Flight.destination_airport
Group by Flight.flight_num, Flight.depature_datetime, Flight.arrival_datetime, Flight.status, Airport1.name, Airport2.name 
Having (count(Booking.flight_num) > 1)

-- 9. Show the full details of all bookings — passenger name, flight number, origin airport, destination airport, class, and price paid.
select * from Booking
select * from Passenger
select * from Flight
select * from Airport
select Booking.booking_id, Booking.seat_number, Passenger.f_name + ' ' + Passenger.l_name as [full_name],
	Booking.flight_num, Airport1.name as [origin], Airport2.name as [destination], Booking.class, Booking.price_paid
	from Booking
	inner join Passenger on Passenger.national_id = Booking.national_id
	inner join Flight on Flight.flight_num = Booking.flight_num
	inner join Airport Airport1 on Flight.origin_airport = Airport1.IATA
	inner join Airport Airport2 on Flight.destination_airport = Airport2.IATA