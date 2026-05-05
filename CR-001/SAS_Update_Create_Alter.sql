use SAS

create table Airline 
(
	IATA int primary key identity(1,1),
	full_name varchar(20) not null unique,
	registration_country varchar(20) not null,
	email varchar(20) not null unique
)

create table Gate 
(
	gate_code int primary key identity(1,1),
	terminal_name varchar(20) not null,
	IATA int not null,
	constraint fk_Gate_Airport
		foreign key (IATA) references Airport(IATA),
	constraint UC_Gate_Airport
		unique (gate_code, IATA)
)

create table Baggage 
(
	tag_number int primary key identity(1,1),
	weight int not null check(weight > 0),
	type varchar(10) not null check (type in('Cabin', 'Checked')),
	booking_id int,
	constraint fk_bagg_book
		foreign key (booking_id) references Booking(booking_id)
)

create table Delay_log 
(
	log_id int primary key identity(1,1),
	recorded_at date not null,
	reason varchar(50) not null,
	duration int not null check(duration > 0),
	flight_num int,
	constraint fk_Delay_fli
		foreign key (flight_num) references Flight(flight_num)
		on update cascade
		on delete cascade
)

alter table Baggage drop constraint fk_bagg_book -- because it will say the constraint already exist

alter table Baggage add constraint fk_bagg_book
	foreign key (booking_id) references Booking(booking_id)
	on update cascade 
	on delete cascade 

alter table Flight add airline_id int, gate_code int -- dont repeat add

-- this run after fixing existing raws with null
alter table Flight alter column airline_id int not null

alter table Flight
	add constraint fk_fli_airline
		foreign key (airline_id) references Airline(IATA)
		on update cascade 
		on delete no action, -- because airline_id will be constrained to not null
	constraint fk_fli_gate  -- also here dont repeat add
		foreign key (gate_id) references Gate(gate_code)
		on update cascade 
		on delete set null -- because it can accept null
					

select * from Aircraft
select * from Airport
select * from Booking
select * from Crew_member
select * from Flight
select * from Flight_crew
select * from Airline
select * from Gate
select * from Delay_log
select * from Baggage
