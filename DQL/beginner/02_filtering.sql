----------------------------------------
-- Scenario 1:. Filter data using WHERE
-- Requirement: Get employees who are male
-- Description: WHERE filters rows based on a condition
----------------------------------------

SELECT *
FROM operations.employee_info
WHERE gender = 'Male';


----------------------------------------
-- Scenario 2. Use comparison operator
-- Requirement: Get employees born after 1990
-- Description: Use comparison operator (>) with dates
----------------------------------------

SELECT first_name,
       birth_date
FROM operations.employee_info
WHERE birth_date > '1990-01-01';


----------------------------------------
-- Scenario 3:. Use AND condition
-- Requirement: Get female employees born after 1990
-- Description: AND ensures both conditions must be true
----------------------------------------

SELECT *
FROM operations.employee_info
WHERE gender = 'Female'
  AND birth_date > '1990-01-01';

-- Scenario 5: BETWEEN (range filtering)
----------------------------------------

SELECT first_name, salary
FROM operations.employee_info
WHERE salary BETWEEN 40000 AND 80000;


----------------------------------------
-- 6. Logical operators (AND, OR, NOT)
----------------------------------------

-- Scenario 1: AND (both conditions must be true)
SELECT first_name, department, salary
FROM operations.employee_info
WHERE department = 'Sales'
  AND salary > 60000;


-- Scenario 2: OR (either condition can be true)
SELECT first_name, department
FROM operations.employee_info
WHERE department = 'Sales'
   OR department = 'Marketing';


-- Scenario 3: NOT (exclude condition)
SELECT first_name, gender
FROM operations.employee_info
WHERE NOT gender = 'Male';


----------------------------------------
-- 7. IN / NOT IN
-- Description: Used for matching multiple values
----------------------------------------

-- Scenario 1: IN
SELECT first_name, department
FROM operations.employee_info
WHERE department IN ('Sales', 'HR', 'Finance');


-- Scenario 2: NOT IN
SELECT first_name, department
FROM operations.employee_info
WHERE department NOT IN ('IT', 'Support');


----------------------------------------
-- 8. LIKE (pattern matching)
-- Description: % = multiple characters, _ = single character
----------------------------------------

-- Scenario 1: Names starting with A
SELECT first_name
FROM operations.employee_info
WHERE first_name LIKE 'A%';


-- Scenario 2: Names ending with n
SELECT first_name
FROM operations.employee_info
WHERE first_name LIKE '%n';


-- Scenario 3: Names containing "ar"
SELECT first_name
FROM operations.employee_info
WHERE first_name LIKE '%ar%';


-- Scenario 4: Second letter is 'a'
SELECT first_name
FROM operations.employee_info
WHERE first_name LIKE '_a%';


----------------------------------------
-- 9. NULL handling
----------------------------------------

-- Scenario 1: Find missing values
SELECT first_name, email
FROM operations.employee_info
WHERE email IS NULL;


-- Scenario 2: Find non-missing values
SELECT first_name, email
FROM operations.employee_info
WHERE email IS NOT NULL;




----------------------------------------
-- 12. Precedence of conditions
-- Description: NOT > AND > OR (use parentheses for control)
----------------------------------------

-- Without parentheses (can be confusing)
SELECT *
FROM operations.employee_info
WHERE department = 'Sales'
   OR department = 'HR'
  AND salary > 50000;


-- With parentheses (correct logic control)
SELECT *
FROM operations.employee_info
WHERE (department = 'Sales'
    OR department = 'HR')
  AND salary > 50000;


----------------------------------------
-- 13. Best practices for filtering
----------------------------------------

-- 1. Always select only required columns
-- 2. Use indexes-friendly filters when possible
-- 3. Avoid SELECT *
-- 4. Use BETWEEN for ranges instead of multiple conditions
-- 5. Use parentheses for complex logic
-- 6. Prefer IN over multiple OR conditions