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
#### Visualizing Salary Distribution with a Histogram
```python
# Set the aesthetic style of the plots
sns.set_style("whitegrid")

# Plotting the histogram using Seaborn
plt.figure(figsize=(10, 6))
sns.histplot(salary_df['salary'], bins=20, color='blue', alpha=0.7, kde=False)

plt.title('Distribution of Employee Salaries')
plt.xlabel('Salary')
plt.ylabel('Number of Employees')

# Show the plot
plt.show()
```
This code block creates a histogram to visualize the distribution of employee salaries:
* `sns.set_style("whitegrid")`: Sets the aesthetic style of the plots to 'whitegrid', which is a theme in Seaborn that provides a white background with gridlines for better readability.
* `plt.figure(figsize=(10, 6))`: Initializes a new figure for plotting with a specified size (10 inches wide and 6 inches tall), ensuring that the histogram has adequate space to be displayed clearly.
* `sns.histplot(...)`: This function from Seaborn is used to create the histogram. It takes the salary data from the `salary_df` DataFrame and organizes it into 20 bins (as specified by the `bins=20` argument), providing a detailed view of the salary distribution. The color and transparency of the bars are set with `color='blue'` and `alpha=0.7`.
* `plt.title`, `plt.xlabel`, and `plt.ylabel`: These lines add a title to the histogram and label the x-axis and y-axis with 'Salary' and 'Number of Employees', respectively, making the plot informative and easy to understand.
* `plt.show()`: Finally, this command displays the histogram plot within the Jupyter Notebook.

This histogram is a key visualization in our analysis, as it gives us a clear picture of how employee salaries are distributed, which can be crucial for understanding the overall salary structure in the dataset.
#### Calculating Average Salary by Title
```python
# SQL query to select average salary by title
avg_salary_query = text("""
SELECT t.title, AVG(s.salary) as average_salary
FROM titles t
JOIN employees e ON t.title_id = e.emp_title_id
JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY t.title
""")

# Execute the query and store the result in a DataFrame
avg_salary_df = pd.read_sql(avg_salary_query, connection)
```
This section of the code performs a crucial analysis task: calculating the average salary for each job title:
* `avg_salary_query = text(...)`: Defines an SQL query that calculates the average salary (`AVG(s.salary)`) for each title (`t.title`). The query joins three tables: `titles`, `employees`, and `salaries`. The `JOIN` operations are based on the relations between the titles and employees (via `title_id` and `emp_title_id`) and between employees and their salaries (via `emp_no`). The `GROUP BY t.title` clause ensures that the average salary is calculated separately for each distinct title in the `titles` table.
* `pd.read_sql(avg_salary_query, connection)`: Executes the query using Pandas' `read_sql` function with the established database connection. The result of the query, which is a DataFrame containing each title and its corresponding average salary, is stored in `avg_salary_df`.

This DataFrame, `avg_salary_df`, is now ready to be used for further visualization or analysis, such as creating a bar chart to compare the average salaries across different job titles in the organization.
#### Creating a Bar Chart of Average Salary by Title
```python
# Plotting the bar chart using Seaborn
plt.figure(figsize=(12, 8))
sns.barplot(x='title', y='average_salary', data=avg_salary_df, color='green')

plt.title('Average Salary by Title')
plt.xlabel('Title')
plt.ylabel('Average Salary')
plt.xticks(rotation=45)

# Show the plot
plt.show()

# Close the database connection
connection.close()
```
This code block is focused on visually representing the average salary for each job title:
* `plt.figure(figsize=(12, 8))`: Sets up a figure for the bar chart with a specified size, ensuring the chart is large enough for clear visualization.
* `sns.barplot(...)`: Utilizes Seaborn's `barplot` function to create the bar chart. The x-axis is set to 'title' and the y-axis to 'average_salary', drawing data from `avg_salary_df`. Each bar represents the average salary for a particular job title, with the bars colored green.
* `plt.title`, `plt.xlabel`, and `plt.ylabel`: These lines add a title to the chart and label the axes, making the plot informative and easy to interpret. The title 'Average Salary by Title' succinctly describes the chart's purpose.
* `plt.xticks(rotation=45)`: Rotates the x-axis labels (job titles) by 45 degrees to prevent overlapping text, ensuring that each job title is readable.
* `plt.show()`: Displays the bar chart within the Jupyter Notebook.
* `connection.close()`: Closes the database connection. This is a best practice to free up database resources once all the necessary data retrieval operations are completed.

This bar chart is an effective way to compare average salaries across different titles, providing clear visual insights into the compensation structure of the organization.
## Insights
In the Insights section of this README, we delve into the findings and interpretations derived from our comprehensive data analysis. Here, we not only showcase previews of the results obtained from our SQL queries but also provide thoughtful summaries and key insights gleaned from the data. This section serves as a bridge between raw data and actionable knowledge, highlighting notable trends, anomalies, and patterns that emerged during our exploration.

Accompanying our summaries are two distinct chart visualizations – a histogram of employee salary ranges and a bar chart depicting average salaries by title. These visual representations aid in contextualizing the data, making complex information more accessible and understandable. Through this analytical lens, we aim to unveil the deeper narratives hidden within the dataset and offer a clearer understanding of the underlying dynamics at play.
### Summary of Employee Details and Salaries Query
![image](images/query1.png)

The executed SQL query provides a comprehensive view of each employee's personal and salary details within the organization. It presents a table listing the employee number, last name, first name, sex, and corresponding salary for all employees. With a total count of 300,024 employees, the data offers an extensive overview of the workforce demographics and salary distribution.

Key Aspects of the Query Results:
1. **Employee Identification**: Each row uniquely identifies an employee through their employee number, facilitating easy referencing and data management.
2. **Personal Details**: The inclusion of last names, first names, and sex of the employees assists in understanding the demographic composition of the workforce. This information is crucial for HR-related analytics, such as diversity assessments and personnel management.
3. **Salary Insights**: By associating each employee with their salary, the query provides vital data for financial analysis, payroll management, and budgeting.
### Summary of Employees Hired in 1986 Query
![image](images/query2.png)

The SQL query executed focuses on employees who were hired in the year 1986, presenting their first names, last names, and hire dates. The result, encompassing a total of 36,150 rows, offers a historical perspective of the hiring pattern for that particular year.

Key Aspects of the Query Results:
1. **Hiring Trends**: The data gives an insight into the volume of hiring done in 1986, which could be indicative of the company's growth, expansion, or turnover rates during that period.
2. **Employee Information**: Listing first names, last names, and hire dates provides a snapshot of the individuals who joined the company in 1986, contributing to a historical record of the workforce.
3. **Temporal Analysis**: The focus on the hire date allows for a time-specific analysis, which can be valuable for understanding hiring trends, workforce expansion, and historical staffing strategies.
### Summary of Department Managers Query
![image](images/query3.png)

The SQL query executed provides a detailed list of managers for each department within the organization. The result encompasses department numbers, department names, along with each manager's employee number, last name, and first name. Notably, the query identifies a total of 24 managers, indicating the breadth of leadership across various departments.

Key Aspects of the Query Results:
1. **Comprehensive Leadership Overview**: The data effectively outlines the leadership structure, linking each of the 24 managers to their respective departments, thereby offering a clear view of the managerial hierarchy.
2. **Precise Manager Identification**: Including both employee numbers and names allows for precise identification of each manager, a crucial aspect for internal operations, communications, and record-keeping.
3. **Inter-Departmental Connect**: The seamless join between the departments, dept_manager, and employees tables ensures a holistic view, connecting managerial roles with specific departmental functions.
### Summary of Employee Department Details Query
![image](images/query4.png)

This SQL query efficiently maps each employee to their respective department, providing a comprehensive dataset that includes the employee's number, last name, first name, and the name of the department they are associated with.

Key Aspects of the Query Results:
1. **Employee-Department Association**: The query bridges the gap between individual employees and their respective departments, offering a clear understanding of where each employee is positioned within the organizational structure.
2. **Detailed Employee Information**: By including employee numbers along with full names, the data facilitates easy identification and referencing of individual staff members.
3. **Comprehensive Departmental View**: The inclusion of department names alongside employee details provides a complete picture of the workforce distribution across various departments.
### Summary of Employees Named Hercules with Last Names Starting with B Query
![image](images/query5.png)

This specific SQL query identifies a unique subset of employees, specifically those named Hercules with last names beginning with the letter "B". The query returned a total of 20 rows, indicating there are 20 employees who match these criteria.

Key Aspects of the Query Results:
1. **Unique Name Combination**: The query focuses on a rare and specific name combination, filtering for first names exactly matching 'Hercules' and last names starting with 'B'.
2. **Data Scope**: It retrieves the first name, last name, and sex of the employees, providing essential details about these individuals.
3. **Narrowed Down Results**: The return of 20 rows from what is presumably a much larger database highlights the effectiveness of SQL in pinpointing a small, distinct group within a vast employee dataset.
### Summary of Query for Employees in the Sales Department
![image](images/query6.png)

This SQL query is designed to list all employees working in the Sales department, showing their employee number, last name, first name, and the department name. The query has returned a total of 52,245 rows, indicating that there are 52,245 employees in the Sales department.

Key Aspects of the Query Results:

1. **Department-Specific Listing**: The query filters the employees database to only include those who are part of the Sales department.
2. **Comprehensive Employee Details**: The query provides a detailed listing of employees in the Sales department, including their unique employee numbers, names, and the department they belong to.
3. **Large Department Size**: The return of 52,245 rows indicates a considerable number of employees in the Sales department, suggesting it's a major area within the organization.
### Summary of Query for Employees in Sales and Development Departments
![image](images/query7.png)

This SQL query effectively identifies and lists all employees who are part of either the Sales or the Development departments. It provides crucial details like employee number, last name, first name, and department name. The query has yielded a substantial total of 137,952 rows, indicating the combined size of these two key departments within the organization.

Key Aspects of the Query Results:
1. **Focused Departmental Selection**: The query uses the `WHERE` clause with the `IN` operator to specifically target employees in the 'Sales' and 'Development' departments. This dual department focus offers insights into two pivotal areas of the organization.
2. **Detailed Employee Information**: By including comprehensive details for each employee, the query facilitates easy identification and referencing, which is essential for internal operations and communications.
3. **Large Combined Department Size**: The total of 137,952 rows signifies the significant number of employees in both departments, reflecting their importance in the overall structure of the organization.
### Summary of Query for Frequency Count of Employee Last Names
![image](images/query8.png)

This SQL query provides a frequency count of employee last names in the organization, showcasing how many employees share each last name. It organizes the data in descending order of frequency. The query results in a total of 1,638 distinct last names, highlighting the diversity of the workforce in terms of surname representation.

Key Aspects of the Query Results:
1. **Last Name Frequency Analysis**: The query counts the occurrences of each last name within the employees table using the `COUNT(*)` function, grouped by `last_name`. This offers a clear view of the most to least common surnames among employees.
2. **Descending Order Sorting**: By ordering the results in descending frequency, the query immediately brings the most common last names to the forefront, providing an easy way to identify which surnames are most prevalent in the organization.
3. **Diversity Insight**: The total of 1,638 rows indicates a broad variety of last names, which can be indicative of a diverse workforce.
### Salary Distribution Within the Organization 
![image](images/histogram.svg)

The histogram depicting employee salary distribution indicates a skewed pattern, with a substantial majority of employees earning salaries at the lower end of the spectrum, as evidenced by the tall bar on the far left. This suggests that entry-level or junior positions dominate the workforce. As the salary increases, the number of employees diminishes, which is typical in organizational structures but may also point to potential disparities in pay scales. The absence of high-salary outliers could imply a standardized cap on wages or a relatively equitable pay structure across the organization. These findings could be instrumental for the HR department in evaluating compensation strategies and addressing equitable pay practices.
### Average Salary by Title
![image](images/barplot.svg)

The bar plot illustrates the average salaries for various job titles, highlighting a relatively uniform distribution of compensation across different roles. The bars, representing titles from 'Assistant Engineer' to 'Technique Leader', suggest minimal variation in average pay, with 'Senior Staff' and 'Staff' roles slightly higher on the scale. This uniformity could indicate a structured and equitable pay strategy within the organization. However, the closeness in compensation between junior and senior positions may also suggest a need to review the differentiation in pay relative to job responsibilities and hierarchy. The data provides a compelling visual argument for potential salary restructuring to maintain motivation and reward experience and expertise adequately.
