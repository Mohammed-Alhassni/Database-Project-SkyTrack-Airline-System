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
select Passenger.f_name + ' ' + Passenger.l_name as [full_name], Baggage.type, count(Baggage.tag_number) as [total_baggage]
from Passenger
    join Booking on Booking.national_id =  Passenger.national_id
    join Baggage on Baggage.booking_id = Booking.booking_id
group by Passenger.national_id, Passenger.f_name + ' ' + Passenger.l_name, Baggage.type

-- 5. List all flights operated by airlines registered in 'UAE', showing the flight number, origin airport, destination airport, and total revenue from bookings.
select Flight.flight_num, Airport1.name as [origin], Airport2.name as [destination], sum(Booking.price_paid) as [total_revenue]
from Flight
    join Airport Airport1 on Flight.origin_airport = Airport1.IATA
    join Airport Airport2 on Flight.destination_airport = Airport2.IATA
    join Booking on Booking.flight_num = Flight.flight_num
    join Airline on Airline.IATA = Flight.airline_id
where  Airline.registration_country= 'UAE'
-- having can be used, but where is better for performance in this case
group by Flight.flight_num, Airport1.name, Airport2.name, Airline.registration_country

-- 6. FINAL CHALLENGE: Show a complete flight report — flight number, airline name, gate code, origin airport city, destination airport city, total passengers booked,
-- total baggage items, total delay duration in minutes (0 if no delays), and total booking revenue. Order by total booking revenue from highest to lowest.
SELECT
    f.flight_num,
    al.full_name AS [airline_name],
    f.gate_code,
    a1.city AS [origin_city],
    a2.city AS [destination_city],
    COUNT(DISTINCT b.booking_id) AS [total_passengers],
    COUNT(DISTINCT bag.tag_number) AS [total_baggage],
    ISNULL(delay.total_duration, 0) AS [total_delay_minutes],
    SUM(DISTINCT b.price_paid) AS [total_revenue]
-- Only if prices are unique; otherwise use a subquery for revenue
FROM Flight f
    LEFT JOIN Airline al ON f.airline_id = al.IATA
    LEFT JOIN Airport a1 ON f.origin_airport = a1.IATA
    LEFT JOIN Airport a2 ON f.destination_airport = a2.IATA
    LEFT JOIN Booking b ON f.flight_num = b.flight_num
    LEFT JOIN Baggage bag ON b.booking_id = bag.booking_id
    -- We join a pre-calculated subquery for delays to avoid the fan-out
    LEFT JOIN (
    SELECT flight_num, SUM(duration) as total_duration
    FROM Delay_log
    GROUP BY flight_num
) delay ON f.flight_num = delay.flight_num
GROUP BY f.flight_num, al.full_name, f.gate_code, a1.city, a2.city, delay.total_duration
ORDER BY [total_revenue] DESC;
