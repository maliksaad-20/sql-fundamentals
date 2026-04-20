-- Scenario 59: Department categorization
SELECT employee_id,
       department_id,
       CASE
           WHEN department_id <= 3 THEN 'SMALL'
           WHEN department_id BETWEEN 4 AND 7 THEN 'MEDIUM'
           ELSE 'LARGE'
       END AS dept_category
FROM operations.employee_info;

-- Scenario 60: Salary increment
SELECT employee_id,
       salary_amount,
       CASE
           WHEN salary_amount <= 50000 THEN salary_amount * 1.05
           ELSE salary_amount * 1.07
       END AS new_salary
FROM operations.salaries;

-- Scenario 61: Salary category
SELECT employee_id,
       salary_amount,
       CASE
           WHEN salary_amount < 40000 THEN 'LOW'
           WHEN salary_amount BETWEEN 40000 AND 70000 THEN 'MEDIUM'
           ELSE 'HIGH'
       END AS salary_category
FROM operations.salaries;

-- Scenario 62: Bonus by department
SELECT e.employee_id,
       e.department_id,
       s.salary_amount,
       CASE
           WHEN e.department_id = 6 THEN s.salary_amount * 0.10
           ELSE 0
       END AS bonus
FROM operations.employee_info e
JOIN operations.salaries s
     ON e.employee_id = s.employee_id;

-- Scenario 63: Gender count using CASE
SELECT 
    COUNT(CASE WHEN gender = 'Male' THEN 1 END) AS male_count,
    COUNT(CASE WHEN gender = 'Female' THEN 1 END) AS female_count
FROM operations.employee_info;

-- Scenario 64: Department salary classification
SELECT e.department_id,
       AVG(s.salary_amount) AS avg_salary,
       CASE
           WHEN AVG(s.salary_amount) > 70000 THEN 'HIGH'
           WHEN AVG(s.salary_amount) BETWEEN 50000 AND 70000 THEN 'MEDIUM'
           ELSE 'LOW'
       END AS dept_category
FROM operations.employee_info e
JOIN operations.salaries s
     ON e.employee_id = s.employee_id
GROUP BY e.department_id;

-- Scenario 67: CASE in ORDER BY
SELECT employee_id,
       salary_amount
FROM operations.salaries
ORDER BY 
    CASE
        WHEN salary_amount > 70000 THEN 1
        WHEN salary_amount BETWEEN 50000 AND 70000 THEN 2
        ELSE 3
    END;

-- Scenario 68: Conditional totals
SELECT 
    SUM(CASE WHEN salary_amount > 60000 THEN salary_amount ELSE 0 END) AS high_salary_total,
    SUM(CASE WHEN salary_amount <= 60000 THEN salary_amount ELSE 0 END) AS low_salary_total
FROM operations.salaries;