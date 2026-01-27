CREATE TABLE employees (
   id INT PRIMARY KEY,
   name VARCHAR(50),
   department VARCHAR(50),
   salary INT,
   city VARCHAR(50)
);
-- Insert data
INSERT INTO employees (id, name, department, salary, city) VALUES
(1, 'Alex',  'Sales', 50000,  'Mumbai'),
(2, 'Priya', 'HR',    60000,  'Delhi'),
(3, 'John',  'IT',    75000,  'Bangalore'),
(4, 'Meera', 'Sales', 52000,  'Mumbai'),
(5, 'Karan', 'IT',    90000,  'Chennai'),
(6, 'Reena', 'HR',    62000,  'Kolkata'),
(7, 'Aman',  'Sales', NULL,   'Mumbai');

----SET1
SELECT * FROM [dbo].[employees]

SELECT name,salary FROM [dbo].[employees]

SELECT id, name
FROM [dbo].[employees]
WHERE city = 'Mumbai'

SELECT DISTINCT department
FROM [dbo].[employees]

SELECT TOP 3 id,name,salary
FROM [dbo].[employees]
ORDER BY salary DESC

---SET 2
SELECT id,name
FROM [dbo].[employees]
WHERE name LIKE '[a]%'

SELECT id,name
FROM [dbo].[employees]
WHERE name LIKE '%[a]'

SELECT id,name
FROM [dbo].[employees]
WHERE name LIKE '%ee%'

SELECT id,name
FROM [dbo].[employees]
WHERE name LIKE '_____'

SELECT id,name
FROM [dbo].[employees]
WHERE name LIKE '[a-m]%'

SELECT id,name
FROM [dbo].[employees]
WHERE name LIKE '[^a]%' --not a
---SET3
SELECT id,name,salary
FROM [dbo].employees
WHERE salary IS NULL

SELECT id,name,salary
FROM [dbo].employees
WHERE salary IS NOT NULL
--SET4
SELECT MIN(salary) AS MinSalary
FROM [dbo].employees

SELECT MAX(salary) AS Maxsalary
FROM [dbo].employees

SELECT AVG(salary) AS AvgSalary
FROM [dbo].employees
WHERE salary IS NOT NULL

SELECT COUNT(id) AS TotalEmployee
FROM [dbo].employees
--SET5
INSERT INTO employees
VALUES(8,'Sara','IT',80000,'Pune')

UPDATE employees
SET salary = 65000
WHERE name = 'Priya'

DELETE FROM employees
WHERE id = 3

SELECT * FROM employees