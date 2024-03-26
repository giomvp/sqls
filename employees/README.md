# Employee Database Analysis

## Overview
This project aims to extract valuable insights from an employee database by generating various reports related to employee headcount, salaries, turnover rates, promotion rates, tenure, and salary distribution. These reports will provide data-driven insights to inform business decisions and identify areas for improvement.

## Table of Contents
- [Database Schema](dbSchema.txt)
- [Problem Statement](problemStatement.pdf)
- [Queries - Solution](queries.sql)


## Database Schema
The employee database consists of the following tables:

- `departments`: Stores information about the departments within the company.
- `dept_emp`: Tracks employee-department associations, including start and end dates.
- `dept_manager`: Maintains records of department managers and their tenure.
- `employees`: Contains personal information about employees, such as name, birth date, gender, and hire date.
- `salaries`: Stores salary information, including start and end dates for each salary entry.
- `titles`: Holds data about employee job titles and their respective start and end dates.

For a detailed view of the database schema, please refer to the `dbSchema.txt` file.

## Requested Reports
The project aims to generate the following reports:

1. **Employee headcount by department**: Provides the number of employees in each department, highlighting the most and least staffed departments.
2. **Average salary by department**: Displays the average salary of employees in each department, identifying the highest and lowest paid departments.
3. **Employee turnover rate**: Reveals the rate at which employees are leaving the company, enabling the identification of potential problem areas.
4. **Promotion rate**: Shows the rate at which employees are being promoted within the company, indicating areas where employees may lack advancement opportunities.
5. **Average tenure**: Presents the average length of time employees have been with the company.
6. **Salary distribution**: Illustrates how salaries are distributed among employees, helping to identify potential overpayment or underpayment of certain groups.
