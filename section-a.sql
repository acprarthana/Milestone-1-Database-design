create table users(
	user_name varchar,
	user_id varchar unique primary key,
	user_email varchar
);

drop table movies;

create table movies(
	movie_id varchar unique primary key,
	movie_name varchar
);


create table theatre(
	theatre_id varchar unique primary key,
	theatre_name varchar,
	theatre_location varchar
);

create table screen(
	screen_id varchar primary key unique,
	theatre_id varchar,
	foreign key(theatre_id) references threatre(theatre_id)
);

create table show(
	show_id varchar unique primary key,
	show_time datetime,
	movie_id varchar,
	screen_id varchar,
	foreign key(movie_id) references movies(movie_id),
	foreign key(screen_id) references screen(screen_id)
);


create table seat(
	seat_id varchar unique primary key,
	seat_number varchar,
	screen_id varchar,
	foreign key(screen_id) references screen(screen_id)
);

create table bookings(
	booking_id varchar primary key,
	user_id varchar,
	show_id varchar,
	foreign key(user_id) references users(user_id),
	foreign key(show_id) references show(show_id)
);

create table booking_seats(
	booking_id varchar,
	seat_id varchar,
	foreign key(booking_id) references bookings(booking_id),
	foreign key(seat_id) references seat(seat_id)
);


create table payments(
	payment_id varchar PRIMARY key,
	payment_status text,
	total_price integer,
	booking_id varchar,
	foreign key(booking_id) references bookings(booking_id)
);
