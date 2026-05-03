USE SAS;
GO

-- 1. Insert 5 Airports
INSERT INTO Airport (name, city, country) VALUES 
('Heathrow', 'London', 'United Kingdom'),
('JFK International', 'New York', 'USA'),
('Haneda', 'Tokyo', 'Japan'),
('Charles de Gaulle', 'Paris', 'France'),
('Dubai International', 'Dubai', 'UAE');

-- 2. Insert 5 Aircraft
INSERT INTO Aircraft (model, manufacturer, seat_capacity, manufacturer_year) VALUES 
('747-8', 'Boeing', 410, 2018),
('A350-900', 'Airbus', 325, 2019),
('787 Dreamliner', 'Boeing', 290, 2020),
('A320neo', 'Airbus', 180, 2021),
('737 MAX 8', 'Boeing', 170, 2022);

-- 3. Insert 8 Passengers (Unique Nationalities as per your schema)
INSERT INTO Passenger (f_name, l_name, email, phone, nationality, DOB) VALUES 
('Alice', 'Smith', 'alice@mail.com', '123456', 'British', '1990-05-15'),
('Bob', 'Jones', 'bob@mail.com', '234567', 'American', '1985-11-20'),
('Yuki', 'Tanaka', 'yuki@mail.com', '345678', 'Japanese', '1992-02-10'),
('Jean', 'Dupont', 'jean@mail.com', '456789', 'French', '1988-07-30'),
('Omar', 'Al-Maktoum', 'omar@mail.com', '567890', 'Emirati', '1995-12-01'),
('Maria', 'Garcia', 'maria@mail.com', '678901', 'Spanish', '1993-04-25'),
('Hans', 'Muller', 'hans@mail.com', '789012', 'German', '1980-09-12'),
('Luca', 'Rossi', 'luca@mail.com', '890123', 'Italian', '1991-01-18');

-- 4. Insert 6 Crew Members
INSERT INTO Crew_member (f_name, l_name, role) VALUES 
('John', 'Captain', 'Pilot'),
('Sarah', 'Flyer', 'Co-Pilot'),
('Mike', 'Service', 'Flight Attendant'),
('Emma', 'Sky', 'Flight Attendant'),
('Robert', 'Fixit', 'Engineer'),
('David', 'Wing', 'Pilot');

-- 5. Insert 8 Flights (Covers all statuses and ensures Arrival > Departure)
-- Note: departure/arrival_datetime are DATE types in your schema, but I'll use sequential dates to pass 'timecheck'
INSERT INTO Flight (depature_datetime, arrival_datetime, status, origin_airport, destination_airport, reg_num) VALUES 
('2024-05-10', '2024-05-11', 'Completed', 1, 2, 1),
('2024-05-12', '2024-05-13', 'Completed', 2, 3, 2),
('2026-06-01', '2026-06-02', 'Scheduled', 3, 4, 3),
('2026-06-05', '2026-06-06', 'Scheduled', 4, 5, 4),
('2026-06-10', '2026-06-11', 'Delayed', 5, 1, 5),
('2026-06-15', '2026-06-16', 'Delayed', 1, 3, 1),
('2026-07-01', '2026-07-02', 'Cancelled', 2, 4, 2),
('2026-07-05', '2026-07-06', 'Scheduled', 3, 5, 3);

-- 6. Insert 10 Bookings (Distributed across passengers, flights, and classes)
INSERT INTO Booking (seat_number, class, booking_date, price_paid, national_id, flight_num) VALUES 
(101, 'First', '2024-04-01', 5000, 1, 1),
(205, 'Bussiness', '2024-04-02', 2500, 2, 1),
(302, 'Economy', '2024-04-10', 800, 3, 2),
(10, 'First', '2026-01-15', 5500, 4, 3),
(55, 'Economy', '2026-01-20', 750, 5, 4),
(12, 'Bussiness', '2026-02-01', 2200, 6, 5),
(88, 'Economy', '2026-02-10', 900, 7, 6),
(99, 'Economy', '2026-03-01', 850, 8, 8),
(102, 'First', '2024-04-05', 4800, 2, 1),
(45, 'Bussiness', '2026-03-05', 2100, 1, 3);

-- 7. Assign Crew to Flights (Each flight gets 1 Pilot + 1 Flight Attendant)
-- Flight 1
INSERT INTO Flight_crew (flight_num, license_number) VALUES (1, 1), (1, 3);
-- Flight 2
INSERT INTO Flight_crew (flight_num, license_number) VALUES (2, 6), (2, 4);
-- Flight 3
INSERT INTO Flight_crew (flight_num, license_number) VALUES (3, 1), (3, 3);
-- Flight 4
INSERT INTO Flight_crew (flight_num, license_number) VALUES (4, 6), (4, 4);
-- Flight 5
INSERT INTO Flight_crew (flight_num, license_number) VALUES (5, 1), (5, 3), (5, 5); -- Adding Engineer
-- Flight 6
INSERT INTO Flight_crew (flight_num, license_number) VALUES (6, 6), (6, 4);
-- Flight 7
INSERT INTO Flight_crew (flight_num, license_number) VALUES (7, 1), (7, 3);
-- Flight 8
INSERT INTO Flight_crew (flight_num, license_number) VALUES (8, 6), (8, 4), (8, 2); -- Adding Co-pilot