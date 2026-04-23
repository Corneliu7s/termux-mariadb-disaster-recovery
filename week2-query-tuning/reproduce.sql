-- Week 2: Query Tuning
EXPLAIN SELECT * FROM employees WHERE dept='IT';
CREATE INDEX idx_dept ON employees(dept);
EXPLAIN SELECT * FROM employees WHERE dept='IT';
SHOW INDEX FROM employees;
SET profiling=1; SELECT * FROM employees WHERE dept='IT'; SHOW PROFILES;
