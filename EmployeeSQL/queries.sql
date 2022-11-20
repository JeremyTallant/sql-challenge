-- 1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees as e
JOIN salaries as s ON
s.emp_no = e.emp_no;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE DATE_PART('year', hire_date) = 1986;

-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT d.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name
FROM departments as d
INNER JOIN dept_manager as m ON
d.dept_no = m.dept_no
INNER JOIN employees as e ON
m.emp_no = e.emp_no;

-- 4. List the department number for each employee along with that employee's employee number, last name, first name, and department name.
SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp as de 
INNER JOIN employees as e ON 
de.emp_no = e.emp_no
INNER JOIN departments as d ON 
de.dept_no = d.dept_no;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE 
	first_name = 'Hercules'
	AND last_name LIKE 'B%';
	
-- 6. List each employee in the Sales department, including their employee number, last name, and first name
SELECT d.dept_name, e.emp_no, e.last_name, e.first_name
FROM departments as d
INNER JOIN dept_emp as de ON
d.dept_no = de.dept_no
INNER JOIN employees as e ON
de.emp_no = e.emp_no
WHERE dept_name = 'Sales'
