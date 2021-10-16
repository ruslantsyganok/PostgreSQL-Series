create table person (
    id bigserial primary key,
    name varchar not null
);

create table car (
    id bigserial primary key,
    model varchar not null
);

create table car_person (
    id bigserial primary key,
    user_id bigint not null,
    car_id bigint not null
);

drop table person;
drop table car;
drop table car_person;

insert into person (name) select (md5(random()::text)) from generate_series(1, 1000000);
insert into car (model) select md5(random()::text) from generate_series(1, 1000000);
insert into car_person (user_id, car_id) select floor(random() * 1000000 + 1), floor(random() * 1000000 + 1) from generate_series(1, 10000000);

select count(*) from car;
select count(*) from person;
select count(*) from car_person;

explain select * from person;
explain select car.model, person.name from person join car_person on user_id = person.id join car on car_person.car_id = car.id;
explain analyze select car.model, person.name from person join car_person on user_id = person.id join car on car_person.car_id = car.id;

-- (cost=0.00..19346.00)
-- Startup cost represents the amount of time between when the component starts executing (reading in data) and when the component outputs its first row.
-- Total cost is the entire execution time of the component, from when it begins reading in data to when it finishes writing its output.
