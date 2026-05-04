/* ============================================================
   📘 WINDOW FUNCTION SCENARIO NOTEBOOK
   Dataset: operations.employee_info, operations.salaries
   ============================================================ */

/* Similar to group by aggregation but it preserve every indivdual row */

/* ============================================================
   SCENARIO 1: Row number for employees
   Description: Assign a unique row number to each employee
   based on salary in descending order.
   ============================================================ */
SELECT employee_id,
       salary_amount,
       ROW_NUMBER() OVER (ORDER BY salary_amount DESC) AS row_num
FROM operations.salaries;



/* ============================================================
   SCENARIO 2: Rank employees by salary
   Description: Assign rank to employees based on salary.
   Employees with same salary share the same rank.
   ============================================================ */
SELECT employee_id,
       salary_amount,
       RANK() OVER (ORDER BY salary_amount DESC) AS rank_val
FROM operations.salaries;



/* ============================================================
   SCENARIO 3: Dense rank employees
   Description: Assign dense rank where no gaps exist between ranks.
   ============================================================ */
SELECT employee_id,
       salary_amount,
       DENSE_RANK() OVER (ORDER BY salary_amount DESC) AS dense_rank_val
FROM operations.salaries;



/* ============================================================
   SCENARIO 4: Rank within department
   Description: Rank employees within each department
   based on salary.
   ============================================================ */
SELECT e.employee_id,
       e.department_id,
       s.salary_amount,
       RANK() OVER (
           PARTITION BY e.department_id
           ORDER BY s.salary_amount DESC
       ) AS dept_rank
FROM operations.employee_info e
JOIN operations.salaries s
     ON e.employee_id = s.employee_id;



/* ============================================================
   SCENARIO 5: Top 2 employees per department
   Description: Use window function to get top 2 highest paid
   employees in each department.
   ============================================================ */
WITH ranked AS (
    SELECT e.employee_id,
           e.department_id,
           s.salary_amount,
           ROW_NUMBER() OVER (
               PARTITION BY e.department_id
               ORDER BY s.salary_amount DESC
           ) AS rn
    FROM operations.employee_info e
    JOIN operations.salaries s
         ON e.employee_id = s.employee_id
)
SELECT *
FROM ranked
WHERE rn <= 2;



/* ============================================================
   SCENARIO 6: Running total of salaries
   Description: Calculate cumulative salary ordered by employee.
   ============================================================ */
SELECT employee_id,
       salary_amount,
       SUM(salary_amount) OVER (
           ORDER BY employee_id
       ) AS running_total
FROM operations.salaries;



/* ============================================================
   SCENARIO 7: Running total within department
   Description: Calculate cumulative salary per department.
   ============================================================ */
SELECT e.department_id,
       e.employee_id,
       s.salary_amount,
       SUM(s.salary_amount) OVER (
           PARTITION BY e.department_id
           ORDER BY s.salary_amount
       ) AS dept_running_total
FROM operations.employee_info e
JOIN operations.salaries s
     ON e.employee_id = s.employee_id;



/* ============================================================
   SCENARIO 8: Moving average salary
   Description: Calculate moving average of salary considering
   current and previous row.
   ============================================================ */
SELECT employee_id,
       salary_amount,
       AVG(salary_amount) OVER (
           ORDER BY employee_id
           ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
       ) AS moving_avg
FROM operations.salaries;



/* ============================================================
   SCENARIO 9: Compare salary with previous employee (LAG)
   Description: Use LAG to access previous row salary.
   ============================================================ */
SELECT employee_id,
       salary_amount,
       LAG(salary_amount) OVER (
           ORDER BY employee_id
       ) AS prev_salary
FROM operations.salaries;



/* ============================================================
   SCENARIO 10: Compare salary with next employee (LEAD)
   Description: Use LEAD to access next row salary.
   ============================================================ */
SELECT employee_id,
       salary_amount,
       LEAD(salary_amount) OVER (
           ORDER BY employee_id
       ) AS next_salary
FROM operations.salaries;



/* ============================================================
   SCENARIO 11: Salary difference from previous
   Description: Calculate difference between current and previous salary.
   ============================================================ */
SELECT employee_id,
       salary_amount,
       salary_amount - LAG(salary_amount) OVER (
           ORDER BY employee_id
       ) AS salary_diff
FROM operations.salaries;



/* ============================================================
   SCENARIO 12: First and last salary in dataset
   Description: Retrieve first and last salary using window functions.
   ============================================================ */
SELECT employee_id,
       salary_amount,
       FIRST_VALUE(salary_amount) OVER (ORDER BY salary_amount) AS min_salary,
       LAST_VALUE(salary_amount) OVER (
           ORDER BY salary_amount
           ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS max_salary
FROM operations.salaries;



/* ============================================================
   SCENARIO 13: Percentage of total salary
   Description: Calculate each employee's contribution to total salary.
   ============================================================ */
SELECT employee_id,
       salary_amount,
       ROUND(
           salary_amount * 100.0 /
           SUM(salary_amount) OVER (),
           2
       ) AS salary_percent
FROM operations.salaries;



/* ============================================================
   SCENARIO 14: Department-wise salary percentage
   Description: Calculate salary percentage within each department.
   ============================================================ */
SELECT e.employee_id,
       e.department_id,
       s.salary_amount,
       ROUND(
           s.salary_amount * 100.0 /
           SUM(s.salary_amount) OVER (PARTITION BY e.department_id),
           2
       ) AS dept_percent
FROM operations.employee_info e
JOIN operations.salaries s
     ON e.employee_id = s.employee_id;



/* ============================================================
   SCENARIO 15: NTILE distribution
   Description: Divide employees into 4 salary groups (quartiles).
   ============================================================ */
SELECT employee_id,
       salary_amount,
       NTILE(4) OVER (ORDER BY salary_amount DESC) AS quartile
FROM operations.salaries;


/* ============================================================
   Scenario: Total salary per department (without GROUP BY)

Description: Use a window function with PARTITION BY to calculate total salary for each department without collapsing rows (unlike GROUP BY).
When you use PARTITION BY without ORDER BY, the function operates on the entire partition (group), not row-by-row sequence.
   ============================================================ */
SELECT e.employee_id,
       e.department_id,
       s.salary_amount,
       SUM(s.salary_amount) OVER (
           PARTITION BY e.department_id
       ) AS dept_total_salary
FROM operations.employee_info e
JOIN operations.salaries s
     ON e.employee_id = s.employee_id;

     