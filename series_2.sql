explain
select car.model, person.name
from car,
     person
where car.id in (select car_id from car_person)
  and person.id in (select user_id from car_person);

explain
select car.model, person.name
from car_person
         join car on car_person.car_id = car.id
         join person on user_id = person.id;

-- Inner join
-- Scans the outer relation sequentially, and for
-- each result row it scans the inner relation for matching rows.

-- Hash join
-- Scans the inner relation sequentially and builds a
-- hash table on our join keys. Then it scans the outer relation
-- sequentially and probes the hash for each row found to find matching join keys.

-- Merge join
-- Sorts both tables by the join keys (which means that the data types must be sortable).
-- Then it iterates through both sorted lists and finds matching entries.
