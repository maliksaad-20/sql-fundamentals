
----------------------------------------
--Scenario 23: Employee details with total salary
--Description: Join employee and salary tables to show
--employee name, department, and total salary.
----------------------------------------

SELECT e.employee_id,
       e.department_id,
       SUM(s.salary_amount) AS total_salary
FROM operations.employee_info e
JOIN operations.salaries s
     ON e.employee_id = s.employee_id
GROUP BY e.employee_id, e.department_id;


----------------------------------------
--Scenario 24: Departments with employee count and avg salary
--Description: Combine aggregation from both tables
----------------------------------------

SELECT e.department_id,
       COUNT(DISTINCT e.employee_id) AS employee_count,
       AVG(s.salary_amount) AS avg_salary
FROM operations.employee_info e
JOIN operations.salaries s
     ON e.employee_id = s.employee_id
GROUP BY e.department_id;


----------------------------------------
--Scenario 25: Employees without salary records (LEFT JOIN)
--Description: Find employees who don’t have salary entries
----------------------------------------

SELECT e.employee_id,
       e.department_id
FROM operations.employee_info e
LEFT JOIN operations.salaries s
       ON e.employee_id = s.employee_id
WHERE s.employee_id IS NULL;

----------------------------------------
--Scenario 26: Highest paid employee in each department
--Description: Use JOIN + subquery
----------------------------------------

SELECT e.department_id,
       e.employee_id,
       s.salary_amount
FROM operations.employee_info e
JOIN operations.salaries s
     ON e.employee_id = s.employee_id
WHERE (e.department_id, s.salary_amount) IN (
    SELECT e.department_id,
           MAX(s.salary_amount)
    FROM operations.employee_info e
    JOIN operations.salaries s
         ON e.employee_id = s.employee_id
    GROUP BY e.department_id
);


-- SELF JOIN SCENARIO (Important)

----------------------------------------
--Scenario 27: Employee-Manager Relationship (Self Join)
--Description: Retrieve employee name along with their manager name.
--Assumption: employee_info has manager_id column referencing employee_id
----------------------------------------

SELECT e.employee_id,
       e.employee_name AS employee_name,
       m.employee_name AS manager_name,
       e.department_id
FROM operations.employee_info e
LEFT JOIN operations.employee_info m
       ON e.manager_id = m.employee_id;


----------------------------------------
--Scenario 28: Employees working in same department (Self Join)
--Description: Pair employees within the same department
----------------------------------------

SELECT e1.employee_id AS emp1,
       e2.employee_id AS emp2,
       e1.department_id
FROM operations.employee_info e1
JOIN operations.employee_info e2
     ON e1.department_id = e2.department_id
    AND e1.employee_id < e2.employee_id;


/* 
============================================================
   SCENARIO 29: Join more than 2 tables
   Description: Retrieve employee name, department name,
   and total salary using 3 tables.
   Assumption:
     - departments table exists (department_id, department_name)
============================================================ 
*/
SELECT e.employee_id,
       e.employee_name,
       d.department_name,
       SUM(s.salary_amount) AS total_salary
FROM operations.employee_info e
JOIN operations.salaries s
     ON e.employee_id = s.employee_id
JOIN operations.departments d
     ON e.department_id = d.department_id
GROUP BY e.employee_id, e.employee_name, d.department_name;


/* ============================================================
   SCENARIO 30: Multi-table join with conditions
   Description: Get departments where avg salary > 60000
   along with department name and employee count
   ============================================================ */
SELECT d.department_name,
       COUNT(DISTINCT e.employee_id) AS employee_count,
       AVG(s.salary_amount) AS avg_salary
FROM operations.employee_info e
JOIN operations.salaries s
     ON e.employee_id = s.employee_id
JOIN operations.departments d
     ON e.department_id = d.department_id
GROUP BY d.department_name
HAVING AVG(s.salary_amount) > 60000;