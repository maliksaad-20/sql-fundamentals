/* ============================================================
   STRING FUNCTIONS PRACTICE SCRIPT
   Schema: operations
   Tables:
     - employee_info
     - salaries
   ============================================================ */


/* ============================================================
   SCENARIO 69: Length of employee_id
   ============================================================ */
SELECT employee_id,
       LENGTH(CAST(employee_id AS CHAR)) AS id_length
FROM operations.employee_info;


/* ============================================================
   SCENARIO 70: Uppercase conversion
   ============================================================ */
SELECT employee_id,
       UPPER(CAST(employee_id AS CHAR)) AS upper_id
FROM operations.employee_info;


/* ============================================================
   SCENARIO 71: Lowercase conversion
   ============================================================ */
SELECT department_id,
       LOWER(CAST(department_id AS CHAR)) AS lower_dept
FROM operations.employee_info;


/* ============================================================
   SCENARIO 72: TRIM functions demo
   ============================================================ */
SELECT TRIM('   employee   ') AS trimmed_value,
       LTRIM('   employee   ') AS left_trim,
       RTRIM('   employee   ') AS right_trim;


/* ============================================================
   SCENARIO 73: LEFT, RIGHT, SUBSTRING
   ============================================================ */
SELECT employee_id,
       LEFT(CAST(employee_id AS CHAR), 2) AS first_two,
       RIGHT(CAST(employee_id AS CHAR), 2) AS last_two,
       SUBSTRING(CAST(employee_id AS CHAR), 2, 2) AS middle_part
FROM operations.employee_info;


/* ============================================================
   SCENARIO 74: Extract month from birth_date
   ============================================================ */
SELECT employee_id,
       birth_date,
       SUBSTRING(CAST(birth_date AS CHAR), 6, 2) AS birth_month
FROM operations.employee_info;


/* ============================================================
   SCENARIO 75: REPLACE function
   ============================================================ */
SELECT employee_id,
       REPLACE(CAST(employee_id AS CHAR), '1', '9') AS replaced_id
FROM operations.employee_info;


/* ============================================================
   SCENARIO 76: LOCATE function
   ============================================================ */
SELECT department_id,
       LOCATE('1', CAST(department_id AS CHAR)) AS position_found
FROM operations.employee_info;


/* ============================================================
   SCENARIO 77: CONCAT employee and department
   ============================================================ */
SELECT employee_id,
       department_id,
       CONCAT('EMP_', employee_id, '_DEP_', department_id) AS formatted_code
FROM operations.employee_info;


/* ============================================================
   SCENARIO 78: CONCAT with JOIN (real-world usage)
   ============================================================ */
SELECT e.employee_id,
       e.department_id,
       s.salary_amount,
       CONCAT('Employee ', e.employee_id, ' earns ', s.salary_amount) AS description
FROM operations.employee_info e
JOIN operations.salaries s
     ON e.employee_id = s.employee_id;


/* ============================================================
   SCENARIO 79: Clean formatted code using TRIM + CONCAT
   ============================================================ */
SELECT CONCAT(
           TRIM(CAST(employee_id AS CHAR)),
           '_',
           TRIM(CAST(department_id AS CHAR))
       ) AS clean_code
FROM operations.employee_info;

/* ============================================================
   SCENARIO 80: Complex string manipulation
   ============================================================ */
SELECT employee_id,
       department_id,
       CONCAT(
           'EMP-',
           LPAD(CAST(employee_id AS CHAR), 5, '0'),
           '-DEP-',
           LPAD(CAST(department_id AS CHAR), 3, '0')
       ) AS complex_code
FROM operations.employee_info;

