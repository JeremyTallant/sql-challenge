# SQL-Challenge

## Background
It’s been two weeks since you were hired as a new data engineer at Pewlett Hackard (a fictional company). Your first major task is to do a research project about people whom the company employed during the 1980s and 1990s. All that remains of the employee database from that period are six CSV files.

For this project, you’ll design the tables to hold the data from the CSV files, import the CSV files into a SQL database, and then answer questions about the data. That is, you’ll perform data modeling, data engineering, and data analysis, respectively.

## Instructions
This Challenge is divided into three parts: data modeling, data engineering, and data analysis.

### Data Modeling
Inspect the CSV files, and then sketch an ERD of the tables.

![ERD](https://user-images.githubusercontent.com/112406455/202908138-5e8ba4a7-750f-4eda-8cf2-9e4cc86bb8e3.png)

### Data Engineering
1. Use the provided information to create a table schema for each of the six CSV files. Be sure to do the following:

      * Remember to specify the data types, primary keys, foreign keys, and other constraints.

      * For the primary keys, verify that the column is unique. Otherwise, create a composite key, which takes two primary keys to uniquely identify a row.

      * Be sure to create the tables in the correct order to handle the foreign keys.
      
<img width="1440" alt="Screenshot 2022-11-20 at 9 53 03 AM" src="https://user-images.githubusercontent.com/112406455/202912040-5d5053aa-8b12-43a6-87ff-74913cb35709.png">

<img width="1440" alt="Screenshot 2022-11-19 at 9 46 33 AM" src="https://user-images.githubusercontent.com/112406455/202859278-6a751d1e-b45f-47cf-9bf2-12c32f197c66.png">


2. Import each CSV file into its corresponding SQL table.

Titles:

<img width="1440" alt="Screenshot 2022-11-19 at 9 49 53 AM" src="https://user-images.githubusercontent.com/112406455/202859430-98aa0334-1f3e-48f2-8d57-4b85a7f305a3.png">

Employees:

<img width="1440" alt="Screenshot 2022-11-19 at 9 52 26 AM" src="https://user-images.githubusercontent.com/112406455/202859634-52a6da13-271a-4e71-aad3-b0a071e089ec.png">

Dept_emp:

<img width="1440" alt="Screenshot 2022-11-19 at 9 53 26 AM" src="https://user-images.githubusercontent.com/112406455/202859719-a33fac8e-80b9-4672-97e4-bf94fb79b9ed.png">

Salaries:

<img width="1440" alt="Screenshot 2022-11-19 at 9 53 39 AM" src="https://user-images.githubusercontent.com/112406455/202859758-ebac1a10-2ac0-405f-a21e-2d50b252edd3.png">

Dept_manager:

<img width="1440" alt="Screenshot 2022-11-19 at 10 00 29 AM" src="https://user-images.githubusercontent.com/112406455/202860001-003c2883-abd2-4109-958d-06fa24b83d47.png">

Departments:

<img width="1440" alt="Screenshot 2022-11-19 at 9 54 08 AM" src="https://user-images.githubusercontent.com/112406455/202859859-f40c27ad-1ca5-4d96-8e38-4ed9f7fc4a44.png">

### Data Analysis

1. List the employee number, last name, first name, sex, and salary of each employee.

<img width="1440" alt="Screenshot 2022-11-21 at 10 45 34 AM" src="https://user-images.githubusercontent.com/112406455/203112191-d2194c10-6615-4f22-b07f-cf245c8bd3f5.png">

2. List the first name, last name, and hire date for the employees who were hired in 1986.

<img width="1440" alt="Screenshot 2022-11-21 at 10 47 05 AM" src="https://user-images.githubusercontent.com/112406455/203112405-248bf3c2-3597-4296-90d3-ec1fa0f0740a.png">

3. List the manager of each department along with their department number, department name, employee number, last name, and first name.

<img width="1440" alt="Screenshot 2022-11-21 at 10 48 14 AM" src="https://user-images.githubusercontent.com/112406455/203112645-75193ae8-aee5-4138-baae-aea51451e7b0.png">

4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

<img width="1440" alt="Screenshot 2022-11-21 at 10 49 16 AM" src="https://user-images.githubusercontent.com/112406455/203112826-cd7acf5f-a495-46c4-9889-47d5e604a7bf.png">

5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

<img width="1440" alt="Screenshot 2022-11-21 at 10 50 00 AM" src="https://user-images.githubusercontent.com/112406455/203112989-1ace7045-1fda-4bf6-a2c2-51c45ff9b168.png">

6. List each employee in the Sales department, including their employee number, last name, and first name.

<img width="1440" alt="Screenshot 2022-11-21 at 10 50 48 AM" src="https://user-images.githubusercontent.com/112406455/203113142-cae704b4-b48f-4d3d-bf33-dca918c10790.png">

7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

<img width="1440" alt="Screenshot 2022-11-21 at 10 51 36 AM" src="https://user-images.githubusercontent.com/112406455/203113342-f15838aa-be77-4ecb-bc61-48c7605ae691.png">

8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

<img width="1440" alt="Screenshot 2022-11-21 at 10 53 08 AM" src="https://user-images.githubusercontent.com/112406455/203113672-548923d7-3aa9-4df3-9819-0cc471966f3d.png">

### Bonus

As you examine the data, you begin to suspect that the dataset is fake. Maybe, your boss gave you spurious data to test the data engineering skills of a new employee? To confirm your hunch, you decide to create a visualization of the data to present to your boss. To do so, complete the following steps:

1. Import the SQL database into Pandas. (Although you could read the CSV files directly in Pandas, you’re trying to prove your technical resourcefulness.)

2. Create a histogram to visualize the employee salary ranges that were the most common.

3. Create a bar chart of average salary by title.

## References
Data generated by Mockaroo, LLC, (2022). Realistic Data Generator.

© 2022 edX Boot Camps LLC
