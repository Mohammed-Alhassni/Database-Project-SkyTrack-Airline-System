create database SAS

use SAS

create table Passenger 
(
	national_id int primary key identity(1,1),
	f_name varchar(20) not null,
	l_name varchar(20) not null,
	email varchar(50) unique not null,
	phone varchar(50),
	nationality varchar(20) not null,
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
	depature_datetime date,
	arrival_datetime date,
	status varchar(20)
)

create table Booking 
(
	booking_id int primary key identity(1,1),
	seat_number int not null,
	class varchar(20) not null check (class in('Economy', 'Bussiness', 'First')),
	booking_date date default CURRENT_DATE() not null,
	price_paid int not null check (price_paid > 0),
	national_id int,
	flight_num int,
	constraint fk_book_pass
		foreign key (national_id) references Passenger(national_id),
	constraint fk_book_fli
		foreign key (flight_num) references Flight(flight_num)
)

create table Flight_crew
(
	flight_num int,
	license_number int
)

