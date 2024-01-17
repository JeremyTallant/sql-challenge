# Database Revival Project 
![image](images/database.png)
## Background
Two weeks into my new role as a data engineer at Pewlett Hackard, a fictional company, I've been tasked with a challenging and exciting project: to reconstruct and analyze the company's employee database from the 1980s and 1990s, using only six remaining CSV files. This project will encompass the full spectrum of my data engineering skills, including data modeling to design the database structure, data engineering to create and populate SQL tables, and data analysis to extract meaningful insights from this historical data. This endeavor not only tests my technical abilities but also provides a unique window into the company's past workforce dynamics.
## Objective
The primary goal of the "Database Revival Project" is to meticulously reconstruct and analyze the historical employee data of a fictional company from the 1980s and 1990s. This comprehensive project is structured into three distinct phases: data modeling, data engineering, and data analysis.

### Data Modeling
The initial phase focuses on understanding the structure and relationships within the data. By inspecting the six CSV files provided, I will create an Entity Relationship Diagram (ERD) to visually map out the connections and dependencies between different data tables. This diagram will be crafted using tools like QuickDBD, offering clarity and precision in the design process.

### Data Engineering
In the second phase, the project transitions into the technical realm of database creation and management. My tasks include:

* **Schema Development**: Designing a table schema for each CSV file. This involves specifying data types, primary keys, foreign keys, and other constraints to ensure data integrity and relational coherence.

* **Primary Key Identification**: Ensuring each table has a unique primary key. If a single column does not suffice for uniqueness, I will create a composite key combining multiple columns.

* **Sequential Table Creation**: Constructing tables in an order that respects foreign key dependencies, thereby ensuring a smooth and error-free database structure.

* **Data Importation**: Migrating data from the CSV files into their respective tables within the SQL database, transforming unstructured data into a structured format ready for analysis.

### Data Analysis
The final phase is dedicated to extracting actionable insights from the data. This involves executing a series of SQL queries to:

* Retrieve detailed employee information including salaries.
* Identify employees hired in a specific year (1986).
* List department managers with associated details.
* Associate employees with their respective departments.
* Filter employees by specific name criteria (e.g., first name 'Hercules' and last names starting with 'B').
* Enumerate employees in specific departments (Sales, Development).
* Analyze the frequency distribution of employee last names.

Through these phases, the "Database Revival Project" aims to not only reconstruct a piece of the company's historical data but also to glean meaningful insights that reflect the employee dynamics and trends during the 1980s and 1990s.
## Implementation
In the Implementation section of this project, we systematically bring to life the Database Revival Project by executing a series of well-defined steps. This process encompasses the practical application of data engineering principles, from the initial setup of database schemas to the intricate tasks of data importation and query execution, ensuring a seamless transition from raw data to valuable insights.
### Data Modeling
The data modeling phase is the cornerstone of the Database Revival Project, where we begin to shape the raw data into a structured and organized database. This process starts with a thorough examination of the contents within six CSV files, each representing a distinct segment of the historical employee database from the 1980s and 1990s.

Utilizing [QuickDBD](https://www.quickdatabasediagrams.com/) for its intuitive design capabilities, we construct an Entity Relationship Diagram (ERD) to visually map out the data relationships. 

![image](images/erd.png)

In the design of our database schema, each entity is meticulously structured to capture specific segments of our data:

* **employees**: This entity encapsulates personal and employment information. The `emp_no` (employee number) serves as the primary key, uniquely identifying each employee. Additionally, `emp_title_id` is a foreign key in this table, linking to the `title_id` in the titles table, thereby connecting each employee to their specific job title.

* **departments**: It details the organizational structure, with `dept_no` (department number) as the primary key, ensuring each department is uniquely identified.

* **dept_emp**: Acting as a link table, it aligns employees with their respective departments. Here, a composite key made up of `emp_no` and `dept_no` is used, as the combination uniquely identifies each record. `emp_no` and `dept_no` in this table are also foreign keys, referencing the employees and departments tables, respectively.

* **dept_manager**: This table maps out the leadership structure, connecting departments to their managers. Similar to dept_emp, it uses a composite key of `emp_no` and `dept_no` for unique identification. Both these fields are foreign keys as well, with `emp_no` referencing the employees table and `dept_no` referencing the departments table.

* **titles**: This entity catalogs possible employee roles, with `title_id` as the primary key, uniquely identifying each job title.

* **salaries**: It tracks compensation figures and has a primary key of `emp_no`. In this table, `emp_no` serves as a foreign key referencing the employees table.


These primary, foreign, and composite keys across each table play a crucial role in preserving data integrity and facilitating efficient data querying in our relational database. This carefully constructed diagram sets the stage for the Data Engineering phase, guiding the creation and interrelation of SQL tables.
### Data Engineering 
In the Data Engineering phase, we operationalize our data model by constructing and populating PostgreSQL tables, carefully defining data types, primary and foreign keys, and constraints to ensure data integrity and seamless inter-table relationships, paving the way for robust data analysis.

To set up a PostgreSQL session in pgAdmin and prepare for table creation:

1. **Download pgAdmin**: Visit the [official pgAdmin download page](https://www.pgadmin.org/), select the version compatible with your operating system, and follow the instructions to install it.

2. **Open pgAdmin**: Launch pgAdmin from your computer; it will typically open in a new browser window or tab.

3. **Create Database**: Navigate to `Databases`. For a new database, right-click on `Databases`, select `Create` > `Database`, give it a name, and save.

4. **Prepare for Table Creation**: Select the database, then click on the `Query Tool` button in the pgAdmin toolbar to open the SQL editor. This environment is where we will write and execute SQL commands to create our tables as defined in the ERD.

With pgAdmin installed and configured, we are now ready to create the tables for our PostgreSQL database as outlined in our data model.

In the `table_schemata.sql` script, we systematically define the structure of our database by creating each table and establishing their relationships. This process is crucial for setting up the database to accurately reflect our data model and ensure data integrity. Here's a walkthrough of each code block:

#### Dropping Existing Tables:
```sql
-- Drop tables if they exist
DROP TABLE IF EXISTS dept_manager, dept_emp, salaries, employees, titles, departments CASCADE;
```
This command ensures a clean slate by removing any existing tables that might conflict with our new schema. The `CASCADE` option is used to automatically drop objects that depend on these tables, like foreign key constraints, ensuring no residual dependencies are left behind.

#### Creating the Titles Table:
```sql
-- Create titles table
CREATE TABLE titles (
    title_id VARCHAR(255) NOT NULL,
    title VARCHAR(255) NOT NULL,
    CONSTRAINT pk_titles PRIMARY KEY (title_id)
);
```
This block creates the `titles` table with two columns: `title_id` (a unique identifier for each title) and `title` (the name of the title). The title_id is designated as the primary key, ensuring uniqueness across records.
#### Creating the Departments Table:
```sql
-- Create departments table
CREATE TABLE departments (
    dept_no VARCHAR(255) NOT NULL,
    dept_name VARCHAR(255) NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (dept_no)
);
```
The `departments` table is created with `dept_no` (a unique department number) and `dept_name` (the name of the department). The `dept_no` column is set as the primary key, ensuring that each department is distinct.
#### Creating the Employees Table:
```sql
-- Create employees table
CREATE TABLE employees (
    emp_no INT NOT NULL,
    emp_title_id VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    sex VARCHAR(1) NOT NULL,
    hire_date DATE NOT NULL,
    CONSTRAINT pk_employees PRIMARY KEY (emp_no),
    CONSTRAINT fk_employees_titles FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);
```
This table holds employee data like employee number (`emp_no`), title ID, birth date, name, sex, and hire date. `emp_no` is the primary key, while `emp_title_id` is a foreign key linking to the titles table, connecting employees to their job titles.
#### Creating the Salaries Table:
```sql
-- Create salaries table
CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
    CONSTRAINT pk_salaries PRIMARY KEY (emp_no),
    CONSTRAINT fk_salaries_employees FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
```
In the `salaries` table, we track employee salaries. Each record consists of an employee number and their salary. The employee number (`emp_no`) acts as a primary key and is also a foreign key that references the `employees` table, tying salary information to the respective employee.
#### Creating the DeptEmp Table:
```sql
-- Create dep_emp table
CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR(255) NOT NULL,
    CONSTRAINT pk_dept_emp PRIMARY KEY (emp_no, dept_no),
    CONSTRAINT fk_dept_emp_employees FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    CONSTRAINT fk_dept_emp_departments FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);
```
This table, `dept_emp`, establishes the relationship between employees and departments. It uses a composite primary key (`emp_no`, `dept_no`) to ensure each record is unique. The `emp_no` and `dept_no` fields also act as foreign keys, linking to the `employees` and `departments` tables, respectively.
#### Creating the DeptManager Table:
```sql
-- Create dept_manager table
CREATE TABLE dept_manager (
    dept_no VARCHAR(255) NOT NULL,
    emp_no INT NOT NULL,
    CONSTRAINT pk_dept_manager PRIMARY KEY (dept_no, emp_no),
    CONSTRAINT fk_dept_manager_departments FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    CONSTRAINT fk_dept_manager_employees FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
```
The `dept_manager` table maps departments to their managers. Similar to `dept_emp`, it uses a composite primary key (`dept_no`, `emp_no`) for unique identification. The `dept_no` and `emp_no` are foreign keys that reference the `departments` and `employees` tables, aligning each department with its manager.

Once the `table_schemata.sql` script is complete, run it against your PostgreSQL database to create the tables and establish their relationships, effectively setting up the foundational structure of your database.
#### Importing CSV Files into the Database
After successfully creating the tables, the next crucial step involves importing data from the CSV files into their respective tables in the database. This process populates the newly created tables with historical employee data, allowing for detailed analysis and query execution. Here's how to perform this import:
1. **Navigate to the Table**: In the pgAdmin dashboard, navigate to the specific table into which you want to import data. You can find the tables listed under your database in the `Schemas` > `public` > `Tables` section.
2. **Import Data from CSV**: Right-click on the table and select the `Import/Export` option. In the dialog that appears, make sure to select `Import` as the direction.
3. **Configure Import Settings**:
	* **File**: Click on the '...' button to browse and select the corresponding CSV file for the table.
	* **Format**: Choose `csv` as the format.
	* **Delimiter**: Specify the character that delimits fields in your CSV file (commonly a comma).
	* **Header**: Check this box if your CSV file includes a header row. The header should match the column names of the table.
	* **Encoding**: Choose the appropriate file encoding, typically `UTF8`.
4. **Start the Import Process**: Click the `OK` button to begin importing data. pgAdmin will load the data from the CSV file into the table.
5. **Verify the Data Import**: After importing each CSV file, it's good practice to verify that the data has been correctly loaded into the tables. You can run a few SELECT queries or check the table summary in pgAdmin.

With the successful creation of the database structure and the importation of the CSV files using pgAdmin 4, we conclude the Data Engineering phase, laying a solid foundation for the upcoming data analysis and exploration tasks.
### Data Analysis
In the Data Analysis section of our implementation, we meticulously craft and execute SQL queries to analyze the database, aiming to uncover meaningful insights and patterns from the historical employee data.

#### Employee Details and Salaries
```sql
-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no;
```
This query joins the `employees` and `salaries` tables to list essential details of each employee, including their employee number, last name, first name, sex, and corresponding salary. By using the `emp_no` field as a join key, it ensures that each employee's salary is accurately matched with their personal information.
#### Employees Hired in 1986
```sql
-- 2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;
```
This query extracts the first name, last name, and hire date of employees from the `employees` table, specifically targeting those who were hired in the year 1986. It utilizes the `EXTRACT(YEAR FROM hire_date)` function to filter the records, ensuring that only employees with a hire date in 1986 are selected.
#### Department Managers
```sql
-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
FROM departments d
JOIN dept_manager dm ON d.dept_no = dm.dept_no
JOIN employees e ON dm.emp_no = e.emp_no;
```
This query is crafted to list the managers for each department, providing essential details like the department number, department name, and the manager's employee number, last name, and first name. It achieves this by joining the `departments` table with the `dept_manager` table on the department number, and then further joining with the `employees` table on the employee number to fetch the manager's personal details.
#### Employee Department Details
```sql
-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no;
```
This query gathers and lists each employee's department along with their personal information. It joins the `employees` table with the `dept_emp` table to link each employee to their respective department, and then with the `departments` table to get the department names. The result includes the employee number, last name, first name, and the name of the department they belong to.
#### Employees Named Hercules with Last Names Starting with B
```sql
-- 5. Employees Named Hercules with Last Names Starting with B
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';
```
This query is tailored to select employees with the first name "Hercules" and whose last names start with the letter "B." It filters the `employees` table for these specific criteria, retrieving the first name, last name, and sex of the matching employees.
#### Employees in the Sales Department
```sql
-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e 
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';
```
This query identifies and lists all employees working in the Sales department. It involves joining the `employees` table with the `dept_emp` table to link each employee to their respective department, and then joining with the `departments` table to include the department names. The `WHERE` clause specifically filters for the Sales department, extracting the employee number, last name, first name, and department name for these employees.
#### Employees in Sales and Development Departments
```sql
-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e 
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');
```
This query targets employees in both the Sales and Development departments. It joins the `employees` table with `dept_emp` and `departments` tables to connect each employee to their respective department. The `WHERE` clause utilizes the `IN` operator to specifically filter for the Sales and Development departments, listing each relevant employee's number, last name, first name, and department name.
#### Frequency Count of Employee Last Names
```sql
-- 8. List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.
SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;
```
This query calculates the frequency of each last name among employees. It groups the records in the `employees` table by `last_name` and uses the `COUNT(*)` function to count the number of occurrences of each last name. The results are then ordered in descending order (`DESC`) based on this frequency count, showing the most common last names at the top.

As we dive deeper into the data analysis phase, an intriguing possibility emerges: could the dataset we're working with be a fabricated one, possibly a test of our data engineering abilities as a new hire? To investigate this further and provide concrete evidence to our suspicions, we'll leverage the power of data visualization. Visualizations can often reveal patterns and anomalies in data that might not be immediately apparent through standard query results. Here's our plan of action to visually dissect and present the data:
#### Setting Up the Environment and Dependencies
```python
%config InlineBackend.figure_format = 'svg'

# Dependencies
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from sqlalchemy import create_engine, text
from config import username, password
```
This code block is the initial setup for our data analysis in the Jupyter Notebook. It includes several key components:

* `%config InlineBackend.figure_format = 'svg'`: This line configures the Jupyter Notebook to display Matplotlib figures in the SVG format, which provides higher-quality visuals.
* Import statements for required libraries:
	* `pandas`: A fundamental package for data manipulation and analysis.
	* `seaborn` and `matplotlib.pyplot`: Libraries used for data visualization.
	* `sqlalchemy`: A SQL toolkit and Object-Relational Mapping (ORM) library for Python, used here to manage database connections.
	* `text`: A function from SQLAlchemy, used for writing SQL queries.
* Importing database credentials from `config.py`: The `username` and `password` are imported from a configuration file, adhering to best practices for sensitive data management.

This setup ensures we have all the necessary tools and configurations in place to proceed with connecting to our database and visualizing the data.
#### Establishing Database Connection
```python
# Create engine and connection to the database 
engine = create_engine(f'postgresql://{username}:{password}@localhost:5432/HistoricalEmployeeDB')
connection = engine.connect()
```
This code block is responsible for establishing a connection to the PostgreSQL database. Here's what it does:

* `create_engine(...)`: This function from SQLAlchemy creates a new instance of an engine that manages connections to the database. It uses a connection string formatted as `postgresql://username:password@localhost:5432/HistoricalEmployeeDB`, where:
	* `username` and `password` are imported from the `config` module, ensuring secure handling of credentials.
	* `localhost:5432` specifies the host and port where the PostgreSQL server is running.
	* `HistoricalEmployeeDB` is the name of the database we are connecting to.
* `engine.connect()`: This method establishes a connection to the database using the engine we just created.

This connection is essential for executing SQL commands and queries directly from the Jupyter Notebook, allowing us to retrieve and manipulate data from the database for our analysis.
#### Retrieving Salary Data from the Database
```python
# SQL query to fetch salary data
salary_query = text("SELECT salary FROM salaries")

# Fetch data into DataFrame
salary_df = pd.read_sql(salary_query, connection)
```
This section of the code is dedicated to fetching salary data from the database:
	* `salary_query = text("SELECT salary FROM salaries")`: This line creates an SQL query to select all entries from the `salary` column in the `salaries` table. The `text()` function from SQLAlchemy is used to prepare the SQL statement. This approach is particularly useful for ensuring that the query is safely constructed, especially when dealing with variables or dynamic query construction.
	* `salary_df = pd.read_sql(salary_query, connection)`: Here, the query is executed using Pandas' `read_sql` function, which takes the SQL query and the database connection as arguments. The result of the query is stored in a Pandas DataFrame called `salary_df`. This DataFrame will be used for further analysis and visualization, as it now contains all the salary data from the database.

This step is pivotal in transitioning from data retrieval to analysis, as it provides the necessary data in a format that can be easily manipulated and visualized using Python's data analysis tools.