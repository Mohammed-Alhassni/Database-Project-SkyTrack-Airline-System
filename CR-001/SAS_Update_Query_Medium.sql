use SAS

-- 1. Show each flight with its flight number, airline name, and gate code.
select * from Flight
select * from Airline
select * from Gate
select Flight.flight_num, Flight.depature_datetime, Flight.arrival_datetime, Flight.status, Airline.full_name, Gate.gate_code, Gate.terminal_name from Flight
inner join Airline on Airline.IATA = Flight.airline_id
inner join Gate on Flight.gate_id = Gate.gate_code

-- 2. List all baggage items along with the passenger name and flight number they are linked to.
select * from Baggage
select * from Passenger
select * from Flight
select Baggage.tag_number, Baggage.weight, Baggage.type, Passenger.f_name + ' ' + Passenger.l_name as [full_name], Flight.flight_num from Booking
inner join Baggage on Booking.booking_id = Baggage.booking_id
inner join Flight on Flight.flight_num = Flight.flight_num
inner join Passenger on Passenger.national_id = Booking.national_id

-- 3. Count the total number of baggage items per booking. Show the booking ID, passenger name, and baggage count.
select * from Baggage
select * from Passenger
select * from Flight

-- 4. Show all delay logs including the flight number, airline name, delay reason, and duration in minutes.
-- 5. Find the total weight of checked baggage per flight. Show the flight number and total checked weight.
-- 6. Count how many flights each airline operates. Order from highest to lowest.
-- 7. Show all flights that have been delayed more than once. Display the flight number and total number of delay records.