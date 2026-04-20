/* ============================================================
   SCENARIO 41: Combine employee IDs from both tables (UNION)
   Description: Get unique employee IDs from employee_info
   and salaries tables
   ============================================================ */
SELECT employee_id
FROM operations.employee_info

UNION

SELECT employee_id
FROM operations.salaries;

/* ============================================================
   SCENARIO 42: Combine employee IDs (UNION ALL)
   Description: Include duplicates as well
   ============================================================ */
SELECT employee_id
FROM operations.employee_info

UNION ALL

SELECT employee_id
FROM operations.salaries;


/* ============================================================
   SCENARIO 43: Employees from two specific departments
   Description: Combine employees from dept 10 and dept 20
   ============================================================ */
SELECT employee_id, department_id
FROM operations.employee_info
WHERE department_id = 10

UNION

SELECT employee_id, department_id
FROM operations.employee_info
WHERE department_id = 20;

/* ============================================================
   SCENARIO 44: Combine high salary and low salary groups
   Description: Categorize salaries using UNION ALL
   ============================================================ */
SELECT employee_id,
       salary_amount,
       'HIGH' AS salary_category
FROM operations.salaries
WHERE salary_amount > 60000

UNION ALL

SELECT employee_id,
       salary_amount,
       'LOW' AS salary_category
FROM operations.salaries
WHERE salary_amount <= 60000;

/* ============================================================
   SCENARIO 45: Combine employees with and without salaries
   Description: Label employees based on salary existence
   ============================================================ */
SELECT employee_id,
       'HAS SALARY' AS status
FROM operations.salaries

UNION

SELECT employee_id,
       'NO SALARY' AS status
FROM operations.employee_info
WHERE employee_id NOT IN (
    SELECT employee_id FROM operations.salaries
);

/* ============================================================
   SCENARIO 46: Combine aggregated results
   Description: Show total employees and total salary in one result
   ============================================================ */
SELECT 'TOTAL EMPLOYEES' AS metric,
       COUNT(*) AS value
FROM operations.employee_info

UNION ALL

SELECT 'TOTAL SALARY',
       SUM(salary_amount)
FROM operations.salaries;

/* ============================================================
   SCENARIO 46: Combine aggregated results
   Description: Show total employees and total salary in one result
   ============================================================ */
SELECT 'TOTAL EMPLOYEES' AS metric,
       COUNT(*) AS value
FROM operations.employee_info

UNION ALL

SELECT 'TOTAL SALARY',
       SUM(salary_amount)
FROM operations.salaries;

/* ============================================================
   SCENARIO 47: Department-wise counts + overall total
   ============================================================ */
SELECT department_id,
       COUNT(*) AS employee_count
FROM operations.employee_info
GROUP BY department_id

UNION ALL

SELECT NULL AS department_id,
       COUNT(*) AS employee_count
FROM operations.employee_info;



/* ============================================================
   SCENARIO 48: Remove duplicates using UNION
   Description: Demonstrates duplicate elimination
   ============================================================ */
SELECT department_id
FROM operations.employee_info

UNION

SELECT department_id
FROM operations.employee_info;


/* ============================================================
   SCENARIO 49: Keep duplicates using UNION ALL
   ============================================================ */
SELECT department_id
FROM operations.employee_info

UNION ALL

SELECT department_id
FROM operations.employee_info;


/* ============================================================
   SCENARIO 50: Top salaries and bottom salaries combined
   ============================================================ */
SELECT employee_id, salary_amount
FROM operations.salaries
WHERE salary_amount = (
    SELECT MAX(salary_amount) FROM operations.salaries
)

UNION

SELECT employee_id, salary_amount
FROM operations.salaries
WHERE salary_amount = (
    SELECT MIN(salary_amount) FROM operations.salaries
);


/* ============================================================
   SCENARIO 50: Top salaries and bottom salaries combined
   ============================================================ */
SELECT employee_id, salary_amount
FROM operations.salaries
WHERE salary_amount = (
    SELECT MAX(salary_amount) FROM operations.salaries
)

UNION

SELECT employee_id, salary_amount
FROM operations.salaries
WHERE salary_amount = (
    SELECT MIN(salary_amount) FROM operations.salaries
);


/* ============================================================
   SCENARIO 51: Different number of columns (ERROR)
   Description: UNION requires same number of columns
   ============================================================ */
SELECT employee_id
FROM operations.employee_info

UNION

SELECT employee_id, salary_amount
FROM operations.salaries;


/* ============================================================
   SCENARIO 52: Incompatible data types (POTENTIAL ERROR)
   Description: Mixing integer with string improperly
   ============================================================ */
SELECT employee_id
FROM operations.employee_info

UNION

SELECT 'TEXT_VALUE'
FROM operations.salaries;


/* ============================================================
   SCENARIO 53: ORDER BY used incorrectly before UNION
   ============================================================ */
SELECT employee_id
FROM operations.employee_info
ORDER BY employee_id

UNION

SELECT employee_id
FROM operations.salaries;


/* ============================================================
   SCENARIO 56: Using different aliases inconsistently
   ============================================================ */
SELECT employee_id AS emp_id
FROM operations.employee_info

UNION

SELECT employee_id AS id
FROM operations.salaries;


/* ============================================================
   SCENARIO 58: Mixing aggregate and non-aggregate incorrectly
   ============================================================ */
SELECT employee_id
FROM operations.employee_info

UNION

SELECT COUNT(*)
FROM operations.salaries;