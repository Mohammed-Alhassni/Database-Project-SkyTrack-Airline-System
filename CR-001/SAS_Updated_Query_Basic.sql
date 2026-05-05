use SAS


-- 1. List all airlines and their country of registration, ordered alphabetically by airline name.
select * from Airline
select full_name, registration_country, email from Airline order by full_name

-- 2. Show all gates and the airport they belong to.
select * from Gate
select * from Airport
select Gate.gate_code, Gate.terminal_name, Airport.name, Airport.country, Airport.country from Gate 
inner join Airport on Airport.IATA = Gate.IATA

-- 3. List all baggage records and their type, ordered by weight from heaviest to lightest.
select * from Baggage
select tag_number, type, weight from Baggage order by weight desc

-- 4. Show all delay log records and the flight they belong to, ordered by recorded datetime.
select * from Delay_log
select * from Flight
select Delay_log.log_id, Delay_log.reason, Delay_log.duration, Delay_log.recorded_at, Delay_log.flight_num, Flight.depature_datetime, Flight.arrival_datetime, Flight.status from Delay_log
inner join Flight on Flight.flight_num = Delay_log.flight_num 
order by recorded_at

-- 5. List all flights that currently have no gate assigned.
select * from Flight
select flight_num, depature_datetime, arrival_datetime, status, gate_id from Flight where gate_id is null
