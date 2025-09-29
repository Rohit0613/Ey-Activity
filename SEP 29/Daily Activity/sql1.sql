INSERT INTO Employees (name, age, salary, dept_id) VALUES
('Rahul', 28, 55000, 1),   -- IT
('Priya', 32, 60000, 2),   -- HR
('Arjun', 25, 48000, 3),   -- Finance
('Neha', 30, 70000, 1),    -- IT
('Vikram', 35, 65000, 4);  -- Sales

TRUNCATE TABLE Employees;
TRUNCATE TABLE Departments;

INSERT INTO Departments (dept_name) VALUES

('IT'),         -- id = 1

('HR'),         -- id = 2

('Finance'),    -- id = 3

('Sales'),      -- id = 4

('Marketing');  -- id = 5  

 
 ALTER TABLE Employees DROP FOREIGN KEY employees_ibfk_1;

INSERT INTO Employees (name, age, salary, dept_id) VALUES

('Rahul', 28, 55000, 1),   -- IT

('Priya', 32, 60000, 2),   -- HR

('Arjun', 25, 48000, NULL),-- 

('Neha', 30, 70000, 1),    -- IT

('Vikram', 35, 65000, 4);  -- Sales

 
 
 SELECT e.name, e.salary, d.dept_name
FROM employee e
INNER JOIN Departments d
on e.dept_id=d.dept_id;

 SELECT e.name, e.salary, d.dept_name
FROM employee e
LEFT JOIN Departments d
on e.dept_id=d.dept_id;

 SELECT e.name, e.salary, d.dept_name
FROM employee e
right JOIN Departments d
on e.dept_id=d.dept_id;


 SELECT e.name, e.salary, d.dept_name
FROM employee e
LEFT JOIN Departments d
on e.dept_id=d.dept_id

UNION
SELECT e.name, e.salary, d.dept_name
FROM employee e
right JOIN Departments d
on e.dept_id=d.dept_id; -- FULL JOIN
