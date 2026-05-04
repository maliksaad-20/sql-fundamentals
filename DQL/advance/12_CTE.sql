/* ============================================================
   📘 CTE SCENARIO NOTEBOOK (WITH DESCRIPTIONS)
   ============================================================ */


/* ============================================================
   SCENARIO 1: Employee count per department (CTE)
   Description: Use a CTE to group employees by department
   and calculate total employee count in each department.
   ============================================================ */
WITH dept_count AS (
    SELECT department_id,
           COUNT(*) AS employee_count
    FROM operations.employee_info
    GROUP BY department_id
)
SELECT *
FROM dept_count;



/* ============================================================
   SCENARIO 2: Total salary per employee (CTE)
   Description: Use a CTE to calculate total salary paid
   to each employee.
   ============================================================ */
WITH emp_salary AS (
    SELECT employee_id,
           SUM(salary_amount) AS total_salary
    FROM operations.salaries
    GROUP BY employee_id
)
SELECT *
FROM emp_salary;



/* ============================================================
   SCENARIO 3: Average salary by department (CTE + JOIN)
   Description: Use a CTE to compute average salary
   for each department by joining employee and salary tables.
   ============================================================ */
WITH dept_avg AS (
    SELECT e.department_id,
           AVG(s.salary_amount) AS avg_salary
    FROM operations.employee_info e
    JOIN operations.salaries s
         ON e.employee_id = s.employee_id
    GROUP BY e.department_id
)
SELECT *
FROM dept_avg;



/* ============================================================
   SCENARIO 4: Departments with high average salary
   Description: Use a CTE to find departments where
   average salary is greater than 60000.
   ============================================================ */
WITH dept_avg AS (
    SELECT e.department_id,
           AVG(s.salary_amount) AS avg_salary
    FROM operations.employee_info e
    JOIN operations.salaries s
         ON e.employee_id = s.employee_id
    GROUP BY e.department_id
)
SELECT *
FROM dept_avg
WHERE avg_salary > 60000;



/* ============================================================
   SCENARIO 5: Employees earning above overall average (CTE)
   Description: Compute overall average salary using a CTE
   and retrieve employees earning above that average.
   ============================================================ */
WITH avg_salary AS (
    SELECT AVG(salary_amount) AS avg_sal
    FROM operations.salaries
)
SELECT employee_id,
       salary_amount
FROM operations.salaries, avg_salary
WHERE salary_amount > avg_sal;



/* ============================================================
   SCENARIO 6: Employees earning above department average (CTE)
   Description: Use a CTE to compute department averages,
   then compare each employee’s salary with their department average.
   ============================================================ */
WITH dept_avg AS (
    SELECT e.department_id,
           AVG(s.salary_amount) AS avg_salary
    FROM operations.employee_info e
    JOIN operations.salaries s
         ON e.employee_id = s.employee_id
    GROUP BY e.department_id
)
SELECT e.employee_id,
       e.department_id,
       s.salary_amount
FROM operations.employee_info e
JOIN operations.salaries s
     ON e.employee_id = s.employee_id
JOIN dept_avg d
     ON e.department_id = d.department_id
WHERE s.salary_amount > d.avg_salary;



/* ============================================================
   SCENARIO 7: Highest paid employee per department (CTE)
   Description: Use a CTE to find maximum salary in each
   department, then retrieve employees matching that salary.
   ============================================================ */
WITH dept_max AS (
    SELECT e.department_id,
           MAX(s.salary_amount) AS max_salary
    FROM operations.employee_info e
    JOIN operations.salaries s
         ON e.employee_id = s.employee_id
    GROUP BY e.department_id
)
SELECT e.employee_id,
       e.department_id,
       s.salary_amount
FROM operations.employee_info e
JOIN operations.salaries s
     ON e.employee_id = s.employee_id
JOIN dept_max d
     ON e.department_id = d.department_id
    AND s.salary_amount = d.max_salary;



/* ============================================================
   SCENARIO 8: Employees without salary records (CTE)
   Description: Use a CTE with LEFT JOIN to identify employees
   who do not have corresponding salary entries.
   ============================================================ */
WITH emp_sal AS (
    SELECT e.employee_id,
           s.employee_id AS sal_id
    FROM operations.employee_info e
    LEFT JOIN operations.salaries s
           ON e.employee_id = s.employee_id
)
SELECT employee_id
FROM emp_sal
WHERE sal_id IS NULL;



/* ============================================================
   SCENARIO 9: Departments with high total salary (CTE)
   Description: Use a CTE to calculate total salary per
   department and filter those above 200000.
   ============================================================ */
WITH dept_total AS (
    SELECT e.department_id,
           SUM(s.salary_amount) AS total_salary
    FROM operations.employee_info e
    JOIN operations.salaries s
         ON e.employee_id = s.employee_id
    GROUP BY e.department_id
)
SELECT *
FROM dept_total
WHERE total_salary > 200000;



/* ============================================================
   SCENARIO 10: Filter then aggregate (CTE chaining)
   Description: First filter salaries greater than 40000,
   then aggregate total salary per department.
   ============================================================ */
WITH high_salary AS (
    SELECT *
    FROM operations.salaries
    WHERE salary_amount > 40000
),
dept_total AS (
    SELECT e.department_id,
           SUM(h.salary_amount) AS total_salary
    FROM operations.employee_info e
    JOIN high_salary h
         ON e.employee_id = h.employee_id
    GROUP BY e.department_id
)
SELECT *
FROM dept_total
WHERE total_salary > 200000;



/* ============================================================
   SCENARIO 11: Rank employees within department (CTE + Window)
   Description: Use a CTE with window function to rank employees
   based on salary within each department.
   ============================================================ */
WITH ranked_emp AS (
    SELECT e.employee_id,
           e.department_id,
           s.salary_amount,
           RANK() OVER (
               PARTITION BY e.department_id
               ORDER BY s.salary_amount DESC
           ) AS dept_rank
    FROM operations.employee_info e
    JOIN operations.salaries s
         ON e.employee_id = s.employee_id
)
SELECT *
FROM ranked_emp
WHERE dept_rank = 1;



/* ============================================================
   SCENARIO 12: Salary categorization using CASE (CTE)
   Description: Use a CTE to classify employees into salary
   categories such as LOW, MEDIUM, and HIGH.
   ============================================================ */
WITH salary_cat AS (
    SELECT employee_id,
           salary_amount,
           CASE
               WHEN salary_amount < 40000 THEN 'LOW'
               WHEN salary_amount BETWEEN 40000 AND 70000 THEN 'MEDIUM'
               ELSE 'HIGH'
           END AS category
    FROM operations.salaries
)
SELECT *
FROM salary_cat;



/* ============================================================
   SCENARIO 13: Department stats with classification (CTE)
   Description: Use a CTE to compute department-level statistics
   and classify departments based on average salary.
   ============================================================ */
WITH dept_stats AS (
    SELECT e.department_id,
           AVG(s.salary_amount) AS avg_salary,
           COUNT(*) AS emp_count
    FROM operations.employee_info e
    JOIN operations.salaries s
         ON e.employee_id = s.employee_id
    GROUP BY e.department_id
)
SELECT department_id,
       avg_salary,
       emp_count,
       CASE
           WHEN avg_salary > 70000 THEN 'HIGH'
           WHEN avg_salary BETWEEN 50000 AND 70000 THEN 'MEDIUM'
           ELSE 'LOW'
       END AS dept_category
FROM dept_stats;



/* ============================================================
   SCENARIO 14: Layered CTE design (multi-step pipeline)
   Description: Demonstrates clean modular design by breaking
   query into base, aggregation, and filtering steps.
   ============================================================ */
WITH base AS (
    SELECT e.employee_id,
           e.department_id,
           s.salary_amount
    FROM operations.employee_info e
    JOIN operations.salaries s
         ON e.employee_id = s.employee_id
),
agg AS (
    SELECT department_id,
           AVG(salary_amount) AS avg_salary
    FROM base
    GROUP BY department_id
),
filtered AS (
    SELECT *
    FROM agg
    WHERE avg_salary > 60000
)
SELECT *
FROM filtered;