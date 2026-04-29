create table users(
	user_name varchar,
	user_id varchar primary key,
	user_email varchar
);

create table movies(
	movie_id varchar primary key,
	movie_name varchar
);

create table city(
	city_id varchar primary key,
	city_name varchar
);

create table theatre(
	theatre_id varchar primary key,
	theatre_name varchar,
	city_id varchar,
	foreign key(city_id) references city(city_id)
);

create table screen(
	screen_id varchar primary key,
	theatre_id varchar,
	foreign key(theatre_id) references theatre(theatre_id)
);

create table shows(
	show_id varchar primary key,
	show_time datetime,
	movie_id varchar,
	screen_id varchar,
	foreign key(movie_id) references movies(movie_id),
	foreign key(screen_id) references screen(screen_id)
);

create table seat(
	seat_id varchar primary key,
	seat_number varchar,
	screen_id varchar,
	foreign key(screen_id) references screen(screen_id)
);


create table bookings(
	booking_id varchar primary key,
	show_id varchar,
	foreign key(show_id) references shows(show_id)
);


create table booking_users(
	booking_id varchar,
	user_id varchar,
	primary key (booking_id, user_id),
	foreign key(booking_id) references bookings(booking_id),
	foreign key(user_id) references users(user_id)
);

create table booking_seats(
	booking_id varchar,
	seat_id varchar,
	user_id varchar,
	primary key (booking_id, seat_id, user_id),
	foreign key(booking_id) references bookings(booking_id),
	foreign key(seat_id) references seat(seat_id),
	foreign key(user_id) references users(user_id)
);

create table payments(
	payment_id varchar primary key,
	payment_status varchar,
	price integer,
	booking_id varchar,
	foreign key(booking_id) references bookings(booking_id)
);

create table genre(
	movie_id varchar,
	genre text,
	primary key(movie_id, genre),
	foreign key(movie_id) references movies(movie_id)
);

create table language(
	movie_id varchar,
	language_name text,
	primary key(movie_id, language_name),
	foreign key(movie_id) references movies(movie_id)
);


insert into users values ('alice', 'u1', 'alice@gmail.com');
insert into users values ('bob', 'u2', 'bob@gmail.com');

insert into movies values ('m1', 'inception');
insert into movies values ('m2', 'avatar');

insert into city values ('c1', 'mysore');
insert into city values ('c2', 'bangalore');

insert into theatre values ('t1', 'pvr', 'c1');
insert into theatre values ('t2', 'inox', 'c2');

insert into screen values ('s1', 't1');
insert into screen values ('s2', 't2');

insert into shows values ('sh1', '2026-05-01 10:00:00', 'm1', 's1');
insert into shows values ('sh2', '2026-05-01 14:00:00', 'm2', 's2');

insert into seat values ('seat1', 'A1', 's1');
insert into seat values ('seat2', 'A2', 's2');

insert into bookings values ('b1', 'sh1');
insert into bookings values ('b2', 'sh2');

insert into booking_users values ('b1', 'u1');
insert into booking_users values ('b2', 'u2');

insert into booking_seats values ('b1', 'seat1', 'u1');
insert into booking_seats values ('b2', 'seat2', 'u2');

insert into payments values ('p1', 'paid', 250, 'b1');
insert into payments values ('p2', 'pending', 300, 'b2');

insert into genre values ('m1', 'sci-fi');
insert into genre values ('m2', 'action');

insert into language values ('m1', 'english');
insert into language values ('m2', 'hindi');


select 
	u.user_name,
	m.movie_name,
	t.theatre_name,
	s.show_time,
	group_concat(se.seat_number) as seats_booked
from users u
join booking_users bu 
	on u.user_id = bu.user_id
join bookings b 
	on bu.booking_id = b.booking_id
join shows s 
	on b.show_id = s.show_id
join movies m 
	on s.movie_id = m.movie_id
join screen sc 
	on s.screen_id = sc.screen_id
join theatre t 
	on sc.theatre_id = t.theatre_id
join booking_seats bs 
	on b.booking_id = bs.booking_id 
	and bs.user_id = u.user_id
join seat se 
	on bs.seat_id = se.seat_id
where u.user_id = 'u1'
and s.show_time between '2026-05-01' and '2026-05-10'
group by b.booking_id, u.user_name, m.movie_name, t.theatre_name, s.show_time;

select 
	m.movie_name,
	count(b.booking_id) as total_bookings
from bookings b
join shows s 
	on b.show_id = s.show_id
join movies m 
	on s.movie_id = m.movie_id
group by m.movie_name
order by total_bookings desc
limit 1;


select 
	s.show_id,
	m.movie_name,
	s.show_time,
	count(distinct bs.seat_id) as seats_booked,
	count(distinct se.seat_id) - count(distinct bs.seat_id) as seats_available
from shows s
join movies m 
	on s.movie_id = m.movie_id
join screen sc 
	on s.screen_id = sc.screen_id
join theatre t 
	on sc.theatre_id = t.theatre_id
join seat se 
	on sc.screen_id = se.screen_id
left join bookings b 
	on s.show_id = b.show_id
left join booking_seats bs 
	on b.booking_id = bs.booking_id
where t.theatre_id = 't1'
and date(s.show_time) = '2026-05-01'
group by s.show_id, m.movie_name, s.show_time;


select count(*)
from booking_seats bs
join bookings b on bs.booking_id = b.booking_id
where b.show_id = 'sh1'
and bs.seat_id = 'seat1';

insert into bookings values ('b3', 'sh1');
insert into booking_users values ('b3', 'u1');
insert into booking_seats values ('b3', 'seat1', 'u1');
insert into payments values ('p3', 'paid', 250, 'b3');
commit;
