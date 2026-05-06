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
inner join Flight on Flight.flight_num = Booking.flight_num
inner join Passenger on Passenger.national_id = Booking.national_id

-- 3. Count the total number of baggage items per booking. Show the booking ID, passenger name, and baggage count.
select * from Baggage
select * from Booking
select * from Passenger
select Booking.booking_id, Passenger.f_name + ' ' + Passenger.l_name as [full_name], count(Baggage.booking_id) as Baggage from Booking
inner join Baggage on Baggage.booking_id = Booking.booking_id
inner join Passenger on Passenger.national_id = Booking.national_id
group by Booking.booking_id, Passenger.f_name + ' ' + Passenger.l_name


-- 4. Show all delay logs including the flight number, airline name, delay reason, and duration in minutes.
select * from Delay_log
select * from Flight
select * from Airline
select Flight.flight_num, Airline.full_name, Delay_log.reason, Delay_log.duration from Flight
inner join Delay_log on Flight.flight_num = Delay_log.flight_num
inner join Airline on Airline.IATA = Flight.airline_id

-- 5. Find the total weight of checked baggage per flight. Show the flight number and total checked weight.
select * from Baggage 
select * from Booking
select * from Flight
select Flight.flight_num, sum(Baggage.weight) as [total_checked_weight] from Booking
inner join Baggage on Baggage.booking_id = Booking.booking_id
inner join Flight on Flight.flight_num = Booking.flight_num
where Baggage.type = 'Checked'
group by Flight.flight_num

-- 6. Count how many flights each airline operates. Order from highest to lowest.
select * from Airline 
select * from Flight
select Airline.full_name, Airline.registration_country, Airline.email, count(Flight.airline_id) as [total_flights] from Flight
right join Airline on Airline.IATA = Flight.airline_id
group by Airline.full_name, Airline.registration_country, Airline.email
order by [total_flights] desc

-- 7. Show all flights that have been delayed more than once. Display the flight number and total number of delay records.
select * from Delay_log
select * from Flight
select Flight.flight_num, count(Delay_log.flight_num) as [total_delay] from Flight
left join Delay_log on Flight.flight_num = Delay_log.flight_num
group by Flight.flight_num
having (count(Delay_log.flight_num)>1)