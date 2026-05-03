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

