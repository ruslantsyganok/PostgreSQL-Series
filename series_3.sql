-- index scan only
explain select id from car where id = 16;
--          1
--     2          3
--  4    5     6     7
-- 8 9 10 11 12 13 14 16

-- 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16

-- seq scan
explain select id from car;

-- index scan
explain select model from car where id < 400;

-- bitmap
create index index_id ON car_person (user_id, car_id);
drop index index_id;
explain select * from car_person where user_id < 40000 or car_id < 40000;
-- user_id: 1 0 1 1 1 0 0 0 0
--  car_id: 0 1 0 0 1 1 1 0 0
--  bitmap: 0 0 0 0 1 0 0 0 0
--  bitmap: 1 1 1
