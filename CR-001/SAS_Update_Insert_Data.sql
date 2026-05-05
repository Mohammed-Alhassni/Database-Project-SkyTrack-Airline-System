use SAS

INSERT INTO Airline (full_name, registration_country, email) VALUES 
('British Airways', 'United Kingdom', 'ops@ba.com'),
('Delta Airlines', 'USA', 'contact@delta.com'),
('Emirates', 'UAE', 'info@emirates.com'),
('Air France', 'France', 'support@airfrance.fr');

INSERT INTO Gate (terminal_name, IATA) VALUES 
('Terminal 5', 1), ('Terminal 5', 1), ('Terminal 2', 1), -- Heathrow
('Terminal 4', 2), ('Terminal 4', 2),                  -- JFK
('Terminal 3', 5), ('Terminal 3', 5), ('Terminal 1', 5); -- Dubai

UPDATE Flight SET airline_id = 1, gate_id = 1 WHERE flight_num = 1;
UPDATE Flight SET airline_id = 2, gate_id = 4 WHERE flight_num = 2;
UPDATE Flight SET airline_id = 3, gate_id = 6 WHERE flight_num = 3;
UPDATE Flight SET airline_id = 4, gate_id = 3 WHERE flight_num = 4;
UPDATE Flight SET airline_id = 3, gate_id = 7 WHERE flight_num = 5;
UPDATE Flight SET airline_id = 1, gate_id = 2 WHERE flight_num = 6;
UPDATE Flight SET airline_id = 3, gate_id = 8 WHERE flight_num = 8;

INSERT INTO Baggage (weight, type, booking_id) VALUES 
(7, 'Cabin', 1), (23, 'Checked', 1),
(8, 'Cabin', 3), (20, 'Checked', 3),
(10, 'Cabin', 4), (30, 'Checked', 4),
(5, 'Cabin', 5),
(12, 'Cabin', 7), (25, 'Checked', 7),
(22, 'Checked', 10);

INSERT INTO Delay_log (recorded_at, reason, duration, flight_num) VALUES 
('2026-06-10', 'Technical Engine Issue', 120, 5),
('2026-06-10', 'Severe Weather Warning', 240, 5),
('2026-06-15', 'Late Arrival of Incoming Aircraft', 45, 6),
('2026-06-15', 'Air Traffic Control Congestion', 30, 6);