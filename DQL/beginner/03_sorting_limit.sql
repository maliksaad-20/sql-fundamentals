----------------------------------------
-- 7. Sort results using ORDER BY
-- Scenario 1: Sort employees by birth date (newest first)
-- Description: DESC shows most recent dates first
----------------------------------------

SELECT first_name,
       birth_date
FROM operations.employee_info
ORDER BY birth_date DESC;


----------------------------------------
-- 7. Sort results using ORDER BY
-- Scenario 2: Sort employees by first name (A to Z)
-- Description: ASC is default sorting order
----------------------------------------

SELECT first_name,
       last_name
FROM operations.employee_info
ORDER BY first_name ASC;


----------------------------------------
-- 7. Sort results using ORDER BY
-- Scenario 3: Sort by multiple columns
-- Description: First by gender, then by birth date
----------------------------------------

SELECT first_name,
       gender,
       birth_date
FROM operations.employee_info
ORDER BY gender ASC,
         birth_date ASC;


----------------------------------------
-- 10. ORDER BY (Sorting results)
----------------------------------------

-- Scenario 1: Sort salary high to low
SELECT first_name, salary
FROM operations.employee_info
ORDER BY salary DESC;


-- Scenario 2: Sort alphabetically
SELECT first_name
FROM operations.employee_info
ORDER BY first_name ASC;


----------------------------------------
-- 11. Multiple column sorting
----------------------------------------

SELECT first_name, department, salary
FROM operations.employee_info
ORDER BY department ASC,
         salary DESC;


----------------------------------------
-- 8. Limit results
-- Scenario 1: Get first 5 employees
-- Description: LIMIT controls number of rows returned
----------------------------------------

SELECT *
FROM operations.employee_info
LIMIT 5;


----------------------------------------
-- 8. Limit results
-- Scenario 2: Get top 3 youngest employees
-- Description: Combine ORDER BY + LIMIT for ranking results
----------------------------------------

SELECT first_name,
       birth_date
FROM operations.employee_info
ORDER BY birth_date DESC
LIMIT 3;


----------------------------------------
-- 8. Pagination using LIMIT + OFFSET
-- Scenario 3: Get employees 6 to 10 (pagination)
-- Description: OFFSET skips rows, LIMIT defines page size
----------------------------------------

SELECT first_name,
       birth_date
FROM operations.employee_info
ORDER BY birth_date DESC
LIMIT 5 OFFSET 5;


----------------------------------------
-- Scenario 29:. Order by column position (single column)
-- Description: Retrieve employee names and
-- sort results using column number instead
-- of column name.
----------------------------------------

SELECT first_name,
       last_name
FROM operations.employee_info
ORDER BY 1;  -- orders by first_name


----------------------------------------
-- Scenario 30:. Order by column position (descending)
-- Description: Sort employees by last_name
-- in descending order using column index.
----------------------------------------

SELECT first_name,
       last_name
FROM operations.employee_info
ORDER BY 2 DESC;  -- orders by last_name


----------------------------------------
-- Scenario 31:. Order by multiple column positions
-- Description: Sort by department_id first,
-- then by employee_id using column numbers.
----------------------------------------

SELECT department_id,
       employee_id,
       first_name
FROM operations.employee_info
ORDER BY 1 ASC,
         2 DESC;


----------------------------------------
-- Scenario 32:. Order salaries using column index
-- Description: Retrieve employee salary data
-- and sort by salary using column number.
----------------------------------------

SELECT e.employee_id,
       e.first_name,
       s.salary_amount
FROM operations.employee_info e
JOIN operations.salaries s
     ON e.employee_id = s.employee_id
ORDER BY 3 DESC;  -- orders by salary_amount


----------------------------------------
-- Scenario 33:. Column position with LIMIT
-- Description: Get top 3 highest salaries
-- using column index for ordering.
----------------------------------------

SELECT e.employee_id,
       e.first_name,
       s.salary_amount
FROM operations.employee_info e
JOIN operations.salaries s
     ON e.employee_id = s.employee_id
ORDER BY 3 DESC
LIMIT 3;