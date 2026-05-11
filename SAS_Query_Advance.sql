use SAS

-- 1. Show each flight with its flight number, origin airport, destination airport, aircraft model, and the total number of passengers booked on it. Include flights that have no bookings.
select Flight.flight_num, Airport1.name as [origin_airport], Airport2.name as [destination_airport], Aircraft.model, count(Booking.booking_id) as [total_bookings] from Flight
left join Airport Airport1 on Airport1.IATA = Flight.origin_airport
left join Airport Airport2 on Airport2.IATA = Flight.destination_airport
left join Aircraft on Aircraft.reg_num = Flight.reg_num
left join Booking on Booking.flight_num = Flight.flight_num
group by Flight.flight_num, Airport1.name, Airport2.name , Aircraft.model

-- 2. List all passengers who have never made a booking.
select Passenger.f_name + ' ' + Passenger.l_name as [full_name], count(Booking.booking_id) as [total_booking] from Passenger
left  join Booking on Passenger.national_id = Booking.national_id
group by Passenger.f_name + ' ' + Passenger.l_name
having count(Booking.booking_id) = 0

-- 3. For each flight, show the flight number and the total revenue generated from its bookings. Show only flights where the total revenue exceeds 500. Order from highest to lowest.
select Flight.flight_num, sum(Booking.price_paid) as [total_revenue] from Flight 
left join Booking on Flight.flight_num = Booking.flight_num
group by Flight.flight_num
having sum(Booking.price_paid) > 500
order by sum(Booking.price_paid) desc

-- 4. Show each crew member's full name and the total number of flights they have been assigned to. Show only crew members assigned to more than one flight.
select Crew_member.f_name + ' ' + Crew_member.l_name as [full_name], count(Flight.flight_num) as [total_flights] from Crew_member
left join Flight_crew on Crew_member.license_number = Flight_crew.license_number
left join Flight on Flight_crew.flight_num = Flight.flight_num
group by Crew_member.license_number, Crew_member.f_name + ' ' + Crew_member.l_name
having count(Flight.flight_num) > 1

-- 5. Find the average booking price per flight. Show only flights where the average price is above the overall average price across all bookings.
select Flight.flight_num, avg(Booking.price_paid) as [average_price] from Flight
inner join Booking on Flight.flight_num = Booking.flight_num
group by Flight.flight_num
having avg(Booking.price_paid) > (select avg(Booking.price_paid) from Booking)

-- 6. Show the flight with the highest number of bookings. Display its flight number, origin, destination, and total bookings.
select TOP 1 Flight.flight_num, Airport1.name as [origin], Airport2.name as [destination], count(Booking.booking_id) as [total_booking] from Flight -- sort so the highest is first and top 1 
join Airport Airport1 on Airport1.IATA = Flight.origin_airport
join Airport Airport2 on Airport2.IATA = Flight.destination_airport
join Booking on Booking.flight_num = Flight.flight_num
group by Flight.flight_num, Airport1.name, Airport2.name
order by total_booking desc --highest to lowest 

-- 7. For each booking class, show the total revenue, the number of bookings, the average price, the highest price, and the lowest price.
select Booking.class, sum(Booking.price_paid) as [total_revenue], count(Booking.booking_id) as [total_bookings],
avg(Booking.price_paid) as [average_price], max(Booking.price_paid) as [maximum_price], min(Booking.price_paid) as [minimum_price] from Booking
group by Booking.class

-- 8. List all passengers who booked a flight that is currently 'Cancelled'. Show the passenger name, flight number, and booking date.
select Passenger.f_name + ' '+ Passenger.l_name as [full_name], Flight.flight_num, Booking.booking_date from Booking
full join Passenger on Passenger.national_id = Booking.national_id
full join Flight on Flight.flight_num = Booking.flight_num
where Flight.status = 'Cancelled'

-- 9. Show all flights that have at least one pilot and at least one flight attendant assigned. Display the flight number, total crew count, and departure datetime.
select Flight.flight_num, count(Crew_member.license_number) as [total_crew_count], Flight.depature_datetime from Flight
full join Flight_crew on Flight.flight_num = Flight_crew.flight_num
full join Crew_member on Flight_crew.license_number = Crew_member.license_number
group by Flight.flight_num, Flight.depature_datetime
HAVING 
    SUM(CASE WHEN Crew_member.role = 'Pilot' THEN 1 ELSE 0 END) >= 1
    AND 
    SUM(CASE WHEN Crew_member.role = 'Flight Attendant' THEN 1 ELSE 0 END) >= 1

/* 
--This might work but not the correct way
select Flight.flight_num, count(Crew_member.license_number) as [total_crew_count], Flight.depature_datetime from Flight
full join Flight_crew on Flight.flight_num = Flight_crew.flight_num
full join Crew_member on Flight_crew.license_number = Crew_member.license_number
where Crew_member.role = 'Pilot' or Crew_member.role = 'Flight Attendant' --filter the raws grouped only to pilot and attendant
group by Flight.flight_num, Flight.depature_datetime
having count(distinct Crew_member.role) >= 2 --filter
*/

--From → Join → where → Group by → having → select → order by 

-- 10. FINAL CHALLENGE: Show the complete flight summary — flight number, origin airport city, destination airport city, aircraft model, aircraft manufacturer, total passengers booked, total crew assigned, and total revenue. Order by total revenue from highest to lowest.
select Flight.flight_num, Airport1.city as [origin_airport_city], Airport2.city as [destination_airport_city], Aircraft.model, Aircraft.manufacturer,
count(Passenger.national_id) as [total_passangers], count(Crew_member.license_number) as [total_crew_members], sum(Booking.price_paid) as [total_revenue] from Flight
left join Airport Airport1 on Flight.origin_airport = Airport1.IATA
left join Airport Airport2 on Flight.destination_airport = Airport2.IATA
left join Aircraft on Aircraft.reg_num = Flight.reg_num
left join Booking on Booking.flight_num = Flight.flight_num
left join Passenger on Passenger.national_id= Booking.national_id
left join Flight_crew on Flight_crew.flight_num = Flight.flight_num
left join Crew_member on Crew_member.license_number = Flight_crew.license_number
group by Flight.flight_num, Airport1.city, Airport2.city, Aircraft.model, Aircraft.manufacturer
order by sum(Booking.price_paid) desc
