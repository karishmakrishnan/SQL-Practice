--CREATE TABLE employee_daily (
--    emp_id     INT,
--    name       VARCHAR(50),
--    dept       VARCHAR(20),
--    salary     INT,
--    update_ts  DATE
--);
INSERT INTO employee_daily (emp_id, name, dept, salary, update_ts) VALUES
(101, 'Alice', 'IT', 60000, '2024-01-01'),
(101, 'Alice', 'IT', 65000, '2024-02-01'),
(101, 'Alice', 'IT', 65000, '2024-03-01'),

(102, 'Bob', 'HR', 50000, '2024-01-05'),
(102, 'Bob', 'HR', 52000, '2024-02-10'),

(103, 'Carol', 'FIN', -1000, '2024-01-15'),   -- invalid salary

(104, 'David', 'IT', 70000, '2024-01-20'),
(104, 'David', 'IT', 72000, '2024-03-10'),

(105, 'Eva', 'HR', 45000, '2024-02-01'),
(105, 'Eva', 'HR', 45000, '2024-03-01'),

(106, 'Frank', 'FIN', 80000, '2024-01-25'),

(107, 'Grace', 'IT', 90000, '2024-02-05'),

(108, 'Helen', 'HR', 48000, '2024-02-15'),

(109, 'Ian', 'FIN', 62000, '2024-01-18'),
(109, 'Ian', 'FIN', 63000, '2024-02-20'),

(110, 'Jack', 'IT', 0, '2024-01-30'),          -- invalid salary

(111, 'Kathy', 'HR', 54000, '2024-03-01'),

(112, 'Leo', 'FIN', 67000, '2024-02-28'),

(113, 'Mona', 'IT', 71000, '2024-01-10'),
(113, 'Mona', 'IT', 75000, '2024-03-15'),

(114, 'Nina', 'HR', 51000, '2024-01-22'),

(115, 'Oscar', 'FIN', 68000, '2024-02-11'),

(116, 'Queen', 'IT', 83000, '2024-03-05'),

(117, 'Ryan', 'HR', 47000, '2024-03-08'),

(NULL, 'Paul', 'IT', 76000, '2024-02-01');     -- invalid emp_id


SELECT * FROM [dbo].[employee_daily]

--create invalid table from parent table
DROP TABLE IF EXISTS emp_invalid

SELECT * INTO [emp_invalid]
FROM [dbo].[employee_daily]
WHERE (emp_id IS NULL or salary <= 0)

SELECT * FROM emp_invalid

--Create the valid table from parent table
DROP TABLE IF EXISTS emp_valid
SELECT * INTO [emp_valid]
FROM [dbo].[employee_daily]
WHERE (emp_id IS NOT NULL AND salary > 0)

SELECT * FROM [emp_valid]

--previous salary table
DROP TABLE IF EXISTS [emp_salary_validation]
WITH employee_metadata_comparison AS(
SELECT *,
LAG(salary) OVER( PARTITION BY emp_id ORDER BY update_ts) AS previous_salary
FROM [dbo].[emp_valid]
)
SELECT *, update_ts as start_date,CASE
WHEN salary > previous_salary THEN 'CHANGED'
WHEN salary < previous_salary THEN 'CHANGED'
WHEN previous_salary IS NULL THEN 'UNCHANGED'
WHEN salary = previous_salary THEN 'UNACHANGED'
END AS salary_validation
INTO [emp_salary_validation]
FROM employee_metadata_comparison

SELECT * FROM [emp_salary_validation]

WITH employee_metadata_comparisons AS(
SELECT *,
LEAD(update_ts) OVER( PARTITION BY emp_id ORDER BY update_ts) AS end_date
FROM [dbo].[emp_salary_validation]
)
SELECT *,CASE
WHEN end_date IS NULL THEN 'YES'
ELSE 'NO'
END AS current_state
INTO [emp_validation]
FROM employee_metadata_comparisons

SELECT * 
FROM [emp_validation]
WHERE current_state = 'YES'