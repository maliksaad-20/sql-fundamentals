----------------------------------------
-- 1. Find top 5 highest paid employees
-- Concept: ORDER BY + LIMIT
----------------------------------------

SELECT first_name,
       salary
FROM operations.employee_info
ORDER BY salary DESC
LIMIT 5;


----------------------------------------
-- 2. Find employees with 2nd to 6th highest salaries
-- Concept: ORDER BY + LIMIT + OFFSET
----------------------------------------

SELECT first_name,
       salary
FROM operations.employee_info
ORDER BY salary DESC
LIMIT 5 OFFSET 1;


----------------------------------------
-- 3. Find employees in multiple departments
-- Concept: IN
----------------------------------------

SELECT first_name,
       department
FROM operations.employee_info
WHERE department IN ('Sales', 'HR', 'Finance');


----------------------------------------
-- 4. Exclude specific departments
-- Concept: NOT IN
----------------------------------------

SELECT first_name,
       department
FROM operations.employee_info
WHERE department NOT IN ('IT', 'Support');


----------------------------------------
-- 5. Find employees with salary between a range
-- Concept: BETWEEN
----------------------------------------

SELECT first_name,
       salary
FROM operations.employee_info
WHERE salary BETWEEN 50000 AND 80000;


----------------------------------------
-- 6. Find employees with missing emails
-- Concept: IS NULL
----------------------------------------

SELECT first_name,
       email
FROM operations.employee_info
WHERE email IS NULL;


----------------------------------------
-- 7. Find employees whose names start with 'A'
-- Concept: LIKE
----------------------------------------

SELECT first_name
FROM operations.employee_info
WHERE first_name LIKE 'A%';


----------------------------------------
-- 8. Find employees whose names contain 'ar'
-- Concept: LIKE with wildcard
----------------------------------------

SELECT first_name
FROM operations.employee_info
WHERE first_name LIKE '%ar%';


----------------------------------------
-- 9. Find employees who are female and earn > 60,000
-- Concept: AND condition
----------------------------------------

SELECT first_name,
       gender,
       salary
FROM operations.employee_info
WHERE gender = 'Female'
  AND salary > 60000;


----------------------------------------
-- 10. Find employees in Sales OR Marketing
-- Concept: OR condition
----------------------------------------

SELECT first_name,
       department
FROM operations.employee_info
WHERE department = 'Sales'
   OR department = 'Marketing';


----------------------------------------
-- 11. Complex filtering with precedence
-- Concept: AND + OR + parentheses
----------------------------------------

SELECT first_name,
       department,
       salary
FROM operations.employee_info
WHERE (department = 'Sales'
    OR department = 'HR')
  AND salary > 50000;


----------------------------------------
-- 12. Find employees not born after 2000
-- Concept: NOT
----------------------------------------

SELECT first_name,
       birth_date
FROM operations.employee_info
WHERE NOT birth_date > '2000-01-01';


----------------------------------------
-- 13. Sort employees by department, then salary
-- Concept: Multiple column sorting
----------------------------------------

SELECT first_name,
       department,
       salary
FROM operations.employee_info
ORDER BY department ASC,
         salary DESC;


----------------------------------------
-- 14. Pagination (Page 2, 5 records per page)
-- Concept: LIMIT + OFFSET
----------------------------------------

SELECT first_name,
       salary
FROM operations.employee_info
ORDER BY salary DESC
LIMIT 5 OFFSET 5;