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