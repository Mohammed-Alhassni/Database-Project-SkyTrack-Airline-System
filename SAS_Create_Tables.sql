create database SAS

use SAS

create table Passenger 
(
	national_id int primary key identity(1,1),
	f_name varchar(20) not null,
	l_name varchar(20) not null,
	email varchar(50) unique not null,
	phone varchar(50),
	nationality varchar(20) unique not null,
	DOB date not null
)

create table Airport 
(
	IATA int primary key identity(1,1),
	name varchar(20) not null,
	city varchar(20) not null,
	country varchar(20) not null,
)

create table Aircraft 
(
	reg_num int primary key identity(1,1),
	model varchar(20) not null,
	manufacturer varchar(20) not null,
	seat_capacity int not null check (seat_capacity >0),
	manufacturer_year int 
)

create table Crew_member 
(
	license_number int primary key identity(1,1),
	f_name varchar(20) not null,
	l_name varchar(20) not null,
	role varchar(20) not null check (role in('Pilot', 'Co-Pilot', 'Flight Attendant', 'Engineer'))
)

create table Flight 
(
	flight_num int primary key identity(1,1),
	depature_datetime date not null,
	arrival_datetime date not null,
	status varchar(20) not null check (status in('Scheduled', 'Delayed', 'Cancelled', 'Completed')) default 'Scheduled',
	destination_airport int,
	origin_airport int,
	reg_num int,
	-- Compare 2 different tables here, else it will cause column level check error
	constraint timecheck
		check (arrival_datetime > depature_datetime),
	-- This one can keep the Cascade
	constraint fk_fli_destination
		foreign key (destination_airport) references Airport(IATA)
		on delete cascade 
		on update cascade,
	-- This one MUST be NO ACTION (or SET NULL) to break the cycle
	constraint fk_fli_origin
		foreign key (origin_airport) references Airport(IATA)
		--default, because my sql blocks the creation of the second cascading constraint. 
		on delete no action on update no action,
	constraint fk_fli_aircraft
		foreign key (reg_num) references Aircraft(reg_num)
		on update cascade
		on delete cascade,
)

create table Booking 
(
	booking_id int primary key identity(1,1),
	seat_number int not null,
	class varchar(20) not null check (class in('Economy', 'Bussiness', 'First')),
	booking_date date not null default cast(GETDATE() as date),
	price_paid int not null check (price_paid > 0),
	national_id int,
	flight_num int,
	constraint fk_book_pass
		foreign key (national_id) references Passenger(national_id)
		on delete cascade
		on update cascade,
	constraint fk_book_fli
		foreign key (flight_num) references Flight(flight_num)
		on update cascade
		on delete cascade
)

create table Flight_crew
(
	flight_num int,
	license_number int,
	constraint fk_flicrew_fli
		foreign key (flight_num) references Flight(flight_num)
		on update cascade
		on delete cascade,
	constraint fk_flicrew_crew
		foreign key (license_number) references Crew_member(license_number)
		on delete cascade
		on update cascade
)



select * from Aircraft
select * from Airport
select * from Booking
select * from Crew_member
select * from Flight
select * from Flight_crew
select * from Passenger