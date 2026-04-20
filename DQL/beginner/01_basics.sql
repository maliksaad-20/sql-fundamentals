----------------------------------------
-- Scenario 1:. Retrieve all data from a table
-- Description: Get all columns and all records
-- from the employee_info table.
----------------------------------------

SELECT *
FROM operations.employee_info;


----------------------------------------
-- Scenario 2:. Retrieve specific columns
-- Description: Get only first name, last name,
-- and birth date of employees.
----------------------------------------

SELECT first_name,
       last_name,
       birth_date
FROM operations.employee_info;


----------------------------------------
-- Scenario 3:. Retrieve unique values
-- Description: Get unique (distinct) gender values
-- without duplicates.
----------------------------------------

SELECT DISTINCT gender
FROM operations.employee_info;