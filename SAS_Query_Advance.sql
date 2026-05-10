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
-- 4. Show each crew member's full name and the total number of flights they have been assigned to. Show only crew members assigned to more than one flight.
-- 5. Find the average booking price per flight. Show only flights where the average price is above the overall average price across all bookings.
-- 6. Show the flight with the highest number of bookings. Display its flight number, origin, destination, and total bookings.
-- 7. For each booking class, show the total revenue, the number of bookings, the average price, the highest price, and the lowest price.
-- 8. List all passengers who booked a flight that is currently 'Cancelled'. Show the passenger name, flight number, and booking date.
-- 9. Show all flights that have at least one pilot and at least one flight attendant assigned. Display the flight number, total crew count, and departure datetime.
-- 10. FINAL CHALLENGE: Show the complete flight summary — flight number, origin airport city, destination airport city, aircraft model, aircraft manufacturer, total passengers booked, total crew assigned, and total revenue. Order by total revenue from highest to lowest.