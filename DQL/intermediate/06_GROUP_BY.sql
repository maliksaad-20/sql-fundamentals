----------------------------------------
-- Scenario 11:. Group employees by department
-- Description: Retrieve department_id and
-- count of employees in each department.
----------------------------------------

SELECT department_id,
       COUNT(*) AS employee_count
FROM operations.employee_info
GROUP BY department_id;


----------------------------------------
-- Scenario 12:. Group salaries by employee
-- Description: Calculate total salary paid
-- to each employee.
----------------------------------------

SELECT employee_id,
       SUM(salary_amount) AS total_salary
FROM operations.salaries
GROUP BY employee_id;


----------------------------------------
-- Scenario 13:. Average salary by department
-- Description: Find the average salary
-- for each department.
----------------------------------------

SELECT e.department_id,
       AVG(s.salary_amount) AS avg_salary
FROM operations.employee_info e
JOIN operations.salaries s
     ON e.employee_id = s.employee_id
GROUP BY e.department_id;


----------------------------------------
-- Scenario 14:. Group by multiple columns
-- Description: Count employees based on
-- department and gender.
----------------------------------------

SELECT department_id,
       gender,
       COUNT(*) AS employee_count
FROM operations.employee_info
GROUP BY department_id, gender;


----------------------------------------
-- Scenario 15:. Departments with high salary expense
-- Description: Get departments where total
-- salary is greater than 100000.
----------------------------------------

SELECT e.department_id,
       SUM(s.salary_amount) AS total_salary
FROM operations.employee_info e
JOIN operations.salaries s
     ON e.employee_id = s.employee_id
GROUP BY e.department_id
HAVING SUM(s.salary_amount) > 100000;


----------------------------------------
-- Scenario 16:. Minimum and maximum salary per department
-- Description: Retrieve lowest and highest
-- salary for each department.
----------------------------------------

SELECT e.department_id,
       MIN(s.salary_amount) AS min_salary,
       MAX(s.salary_amount) AS max_salary
FROM operations.employee_info e
JOIN operations.salaries s
     ON e.employee_id = s.employee_id
GROUP BY e.department_id;



----------------------------------------
-- Scenario 20:. Using HAVING clause
-- Description: Get departments having more
-- than 5 employees.
----------------------------------------

SELECT department_id,
       COUNT(*) AS employee_count
FROM operations.employee_info
GROUP BY department_id
HAVING COUNT(*) > 5;


----------------------------------------
-- Scenario 21:. HAVING with aggregate condition
-- Description: Retrieve departments where
-- average salary is greater than 60000.
----------------------------------------

SELECT e.department_id,
       AVG(s.salary_amount) AS avg_salary
FROM operations.employee_info e
JOIN operations.salaries s
     ON e.employee_id = s.employee_id
GROUP BY e.department_id
HAVING AVG(s.salary_amount) > 60000;


----------------------------------------
-- Scenario 22:. WHERE + HAVING together
-- Description: Filter employees with salary
-- above 40000, then group by department and
-- show only departments with total salary
-- greater than 200000.
----------------------------------------

SELECT e.department_id,
       SUM(s.salary_amount) AS total_salary
FROM operations.employee_info e
JOIN operations.salaries s
     ON e.employee_id = s.employee_id
WHERE s.salary_amount > 40000
GROUP BY e.department_id
HAVING SUM(s.salary_amount) > 200000;