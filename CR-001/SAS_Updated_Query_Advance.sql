use SAS

-- 1. Show each airline with the total number of flights it operates, the total number of passengers across all its flights, and the total revenue generated from bookings on its flights.
select Airline.full_name, count(distinct Flight.flight_num) as [total_flights], count(Passenger.national_id) as [total_passangers], sum(Booking.price_paid) as [total_revenue]
from Airline
    left join Flight on Flight.airline_id = Airline.IATA
    left join Booking on Booking.flight_num = Flight.flight_num
    left join Passenger on Passenger.national_id = Booking.national_id
group by Airline.IATA, Airline.full_name

-- 2. Find the gate that has been used by the most flights. Show the gate code, terminal, airport name, and flight count.
select top 1
    Gate.gate_code, Gate.terminal_name, Airport.name, count(Flight.flight_num) as [total_flights]
from Gate
    join Airport on Airport.IATA = Gate.IATA
    join Flight on Flight.gate_code = Gate.gate_code
group by Gate.gate_code, Gate.terminal_name, Airport.name
order by count(Flight.flight_num) desc

-- 3. For each flight that has delay records, show the flight number, airline name, total number of delays,and total accumulated delay duration in minutes.
select Flight.flight_num, Airline.full_name, count(Delay_log.log_id) as [delays_count], sum(Delay_log.duration) as [total_delay_duration]
from Flight
    join Delay_log on Delay_log.flight_num = Flight.flight_num
    join Airline on Airline.IATA = Flight.airline_id
group by Flight.flight_num, Airline.full_name

-- 4. Show each passenger's full name alongside the total number of baggage items they have across all their bookings, broken down by type (Cabin and Checked).


-- 5. List all flights operated by airlines registered in 'Oman', showing the flight number, origin airport, destination airport, and total revenue from bookings.
-- 6. FINAL CHALLENGE: Show a complete flight report — flight number, airline name, gate code, origin airport city, destination airport city, total passengers booked,
-- total baggage items, total delay duration in minutes (0 if no delays), and total booking revenue. Order by total booking revenue from highest to lowest.