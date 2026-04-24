SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 1;
SHOW VARIABLES LIKE 'slow_query_log%';
SHOW VARIABLES LIKE 'long_query_time';
EXPLAIN SELECT * FROM cars JOIN owners ON cars.owner_id = owners.id WHERE cars.year > 2000;
SHOW INDEX FROM cars;
SHOW INDEX FROM owners;
