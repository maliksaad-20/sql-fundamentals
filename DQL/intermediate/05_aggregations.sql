----------------------------------------
-- Scenario 4:. Count total employees
-- Description: Get the total number of
-- employees in the employee_info table.
----------------------------------------

SELECT COUNT(*) AS total_employees
FROM operations.employee_info;


----------------------------------------
-- Scenario 5:. Count employees by department
-- Description: Get number of employees
-- in each department.
----------------------------------------

SELECT department_id,
       COUNT(*) AS employee_count
FROM operations.employee_info
GROUP BY department_id;


----------------------------------------
-- Scenario 6:. Total salary expense
-- Description: Calculate the sum of all
-- salaries from the salaries table.
----------------------------------------

SELECT SUM(salary_amount) AS total_salary
FROM operations.salaries;


----------------------------------------
-- Scenario 7:. Average salary
-- Description: Find the average salary
-- of all employees.
----------------------------------------

SELECT AVG(salary_amount) AS avg_salary
FROM operations.salaries;


----------------------------------------
-- Scenario 8:. Minimum salary
-- Description: Retrieve the lowest
-- salary from the salaries table.
----------------------------------------

SELECT MIN(salary_amount) AS min_salary
FROM operations.salaries;


----------------------------------------
-- Scenario 9:. Maximum salary
-- Description: Retrieve the highest
-- salary from the salaries table.
----------------------------------------

SELECT MAX(salary_amount) AS max_salary
FROM operations.salaries;


----------------------------------------
-- Scenario 10:. Salary summary by department
-- Description: Get total, average, minimum,
-- and maximum salary for each department.
----------------------------------------

SELECT e.department_id,
       SUM(s.salary_amount) AS total_salary,
       AVG(s.salary_amount) AS avg_salary,
       MIN(s.salary_amount) AS min_salary,
       MAX(s.salary_amount) AS max_salary
FROM operations.employee_info e
JOIN operations.salaries s
     ON e.employee_id = s.employee_id
GROUP BY e.department_id;