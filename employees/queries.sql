-- 1. Headcount by departement
-- This query will return a list of department names and their corresponding headcounts, 
-- ordered by headcount in descending order. The query first joins the departments and 
-- dept_emp tables on the dept_no column, and then groups the results by department name. 

SELECT
    departments.dept_name,
    COUNT(dept_emp.emp_no) as headcount 
FROM
    departments 
JOIN
    dept_emp 
        ON departments.dept_no = dept_emp.dept_no 
WHERE
    dept_emp.from_date >= '1995-01-01' 
    and dept_emp.to_date <='2000-08-01' 
GROUP BY
    departments.dept_name 
ORDER BY
    headcount DESC;

-- 2. Average salary by department
-- This query will return a list of department names and their corresponding average salaries, 
-- ordered by average salary in descending order. The query first joins the departments, dept_emp 
-- and salaries tables on the dept_no and emp_no columns, respectively. Then, the results are grouped 
-- by department name and the AVG() function is used to calculate the average salary for each group.

SELECT
    departments.dept_name,
    AVG(salaries.salary) as avg_salary 
FROM
    departments 
JOIN
    dept_emp 
        ON departments.dept_no = dept_emp.dept_no 
JOIN
    salaries 
        ON dept_emp.emp_no = salaries.emp_no 
WHERE
    dept_emp.from_date >= '1995-01-01' 
    and dept_emp.to_date <='2000-08-01' 
GROUP BY
    departments.dept_name 
ORDER BY
    avg_salary DESC;

-- 3. Employee turnover rate
-- This query will return the total number of employees, the number of employees who have 
-- left the company and the turnover rate (expressed as a percentage). The query uses a left 
-- join to join the dept_emp table with a subquery that selects only the employees who are 
-- still working for the company (based on the to_date column being greater than or equal to the current date).

SELECT
    COUNT(DISTINCT dept_emp.emp_no) as total_employees,
    COUNT(DISTINCT dept_emp.emp_no) - COUNT(DISTINCT current_employees.emp_no) as turnover,
    ((COUNT(DISTINCT dept_emp.emp_no) - COUNT(DISTINCT current_employees.emp_no)) / COUNT(DISTINCT dept_emp.emp_no)) * 100 as turnover_rate 
FROM
    dept_emp 
LEFT JOIN
    (
        SELECT
            DISTINCT emp_no
        FROM
            dept_emp 
        WHERE
            to_date >= CURRENT_DATE()
    ) as current_employees 
        ON dept_emp.emp_no = current_employees.emp_no 

-- 4. Promotion Rate
-- This query will return the total number of promotions and the promotion rate (expressed as a percentage)
-- within the company. The query uses a left join to join the employees table with a subquery that selects 
-- only the employees who have been promoted to the title of "Manager". 

SELECT
    COUNT(DISTINCT promotions.emp_no) as total_promotions,
    COUNT(DISTINCT promotions.emp_no) / COUNT(DISTINCT employees.emp_no) * 100 as promotion_rate 
FROM
    employees 
LEFT JOIN
    (
        SELECT
            emp_no 
        FROM
            titles 
        WHERE
            title = 'Manager' 
            and from_date >= '1985-01-01' 
            and to_date <='1995-08-01'
    ) as promotions 
        ON employees.emp_no = promotions.emp_no   


-- 5. average tenure of employees:
-- This query will return the average tenure of employees in years. The query uses the DATEDIFF() 
-- function to calculate the difference between the current date and the hire_date of each employee, 
-- and then divide it by 365 to convert it to years. The AVG() function is then used to calculate the 
-- average of these differences.

SELECT
    AVG(DATEDIFF(CURRENT_DATE(),
    hire_date) / 365) as avg_tenure 
FROM
    employees
--WHERE hire_date >= 'YYYY-MM-DD' and hire_date <='YYYY-MM-DD'

-- By Department 
SELECT
    departments.dept_name,
    AVG(DATEDIFF(CURRENT_DATE(),
    employees.hire_date) / 365) as avg_tenure 
FROM
    employees 
JOIN
    dept_emp 
        ON employees.emp_no = dept_emp.emp_no 
JOIN
    departments 
        ON dept_emp.dept_no = departments.dept_no 
WHERE
    dept_emp.from_date >= '1995-01-01' 
    and dept_emp.to_date <='1999-12-31' 
GROUP BY
    departments.dept_name

-- 6. Salary Distribution
-- This query will return the average salary of employees, grouped by year of tenure bins 
-- of 5,10,15, etc. The query joins the employees and the salaries table on the emp_no column, 
-- then it calculates the tenure of each employee using DATEDIFF() function. The tenure is divided by 
-- 365 to convert it to years.

SELECT
    CASE          
        WHEN DATEDIFF(CURRENT_DATE(),
        employees.hire_date) / 365 < 5 THEN '0-5'          
        WHEN DATEDIFF(CURRENT_DATE(),
        employees.hire_date) / 365 < 10 THEN '5-10'          
        WHEN DATEDIFF(CURRENT_DATE(),
        employees.hire_date) / 365 < 15 THEN '10-15'          
        ELSE '15 '        
    END AS tenure_bins,
    AVG(salaries.salary) as avg_salary 
FROM
    employees 
JOIN
    salaries 
        ON employees.emp_no = salaries.emp_no 
GROUP BY
    tenure_bins