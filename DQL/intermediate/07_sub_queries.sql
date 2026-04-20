/* ============================================================
   SCENARIO 31: Employees earning above average salary
   ============================================================ */
SELECT employee_id,
       salary_amount
FROM operations.salaries
WHERE salary_amount > (
    SELECT AVG(salary_amount)
    FROM operations.salaries
);

/* ============================================================
   SCENARIO 32: Employees with highest salary
   ============================================================ */
SELECT employee_id,
       salary_amount
FROM operations.salaries
WHERE salary_amount = (
    SELECT MAX(salary_amount)
    FROM operations.salaries
);


/* ============================================================
   SCENARIO 33: Employees working in departments with > 5 employees
   ============================================================ */
SELECT employee_id,
       department_id
FROM operations.employee_info
WHERE department_id IN (
    SELECT department_id
    FROM operations.employee_info
    GROUP BY department_id
    HAVING COUNT(*) > 5
);


/* ============================================================
   SCENARIO 34: Employees whose salary is greater than employee_id = 101
   ============================================================ */
SELECT employee_id,
       salary_amount
FROM operations.salaries
WHERE salary_amount > (
    SELECT salary_amount
    FROM operations.salaries
    WHERE employee_id = 101
);

/* ============================================================
   SCENARIO 35: Departments with highest total salary
   ============================================================ */
SELECT department_id
FROM operations.employee_info
WHERE employee_id IN (
    SELECT employee_id
    FROM operations.salaries
    WHERE salary_amount = (
        SELECT MAX(salary_amount)
        FROM operations.salaries
    )
);


/* ============================================================
   SCENARIO 36: Employees NOT in departments with low headcount (<3)
   ============================================================ */
SELECT employee_id,
       department_id
FROM operations.employee_info
WHERE department_id NOT IN (
    SELECT department_id
    FROM operations.employee_info
    GROUP BY department_id
    HAVING COUNT(*) < 3
);


/* ============================================================
   SCENARIO 37: Employees whose salary is above department average
   (Correlated Subquery)
   ============================================================ */
SELECT employee_id,
       salary_amount
FROM operations.salaries s1
WHERE salary_amount > (
    SELECT AVG(s2.salary_amount)
    FROM operations.salaries s2
    WHERE s1.employee_id = s2.employee_id
);


/* ============================================================
   SCENARIO 38: Employees existing in salary table (EXISTS)
   ============================================================ */
SELECT employee_id
FROM operations.employee_info e
WHERE EXISTS (
    SELECT 1
    FROM operations.salaries s
    WHERE s.employee_id = e.employee_id
);


/* ============================================================
   SCENARIO 39: Employees without salary (NOT EXISTS)
   ============================================================ */
SELECT employee_id
FROM operations.employee_info e
WHERE NOT EXISTS (
    SELECT 1
    FROM operations.salaries s
    WHERE s.employee_id = e.employee_id
);


/* ============================================================
   SCENARIO 40: Second highest salary (no JOIN)
   ============================================================ */
SELECT MAX(salary_amount) AS second_highest_salary
FROM operations.salaries
WHERE salary_amount < (
    SELECT MAX(salary_amount)
    FROM operations.salaries
);