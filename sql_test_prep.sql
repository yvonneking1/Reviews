-- List all the databases
SHOW databases;

-- Switch to a database using the USE statement
USE employees;

-- Show the currently selected database
SELECT database();

-- Switch to a different database
USE salaries;

-- Show the currently selected database
SELECT database();

-- Use the employees database
USE employees;

-- List all the tables in the database
SHOW tables;

-- Show the SQL that created the dept_manager table.
SHOW CREATE TABLE dept_manager;


-- Use the albums_db database.
USE albums_db;

-- The name of all albums by Pink Floyd
SELECT name 
FROM albums
WHERE artist = "Pink Floyd";

-- The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";

-- The genre for the album Nevermind
SELECT genre
FROM albums
WHERE name = "Nevermind";

-- Which albums were released in the 1990s
SELECT name
FROM albums
WHERE release_date LIKE "199%";

-- Which albums had less than 20 million certified sales
SELECT name
FROM albums
WHERE sales < 20;

-- All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
SELECT name 
FROM albums
WHERE genre = "Rock";

-- Create a file named 3.5.1_where_exercises.sql. Make sure to use the employees database
USE employees;

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya' — 709 rows (Hint: Use IN).
SELECT *
FROM employees
WHERE first_name IN ("Irena", "Vidya", "Maya");

-- Find all employees whose last name starts with 'E' — 7,330 rows.
SELECT *
FROM employees
WHERE last_name like "e%";

-- Find all employees hired in the 90s — 135,214 rows.
SELECT *
FROM employees
WHERE hire_date like "199%";

-- Find all employees born on Christmas — 842 rows.
SELECT *
FROM employees
WHERE birthdate like "%12-25";

-- Find all employees with a 'q' in their last name — 1,873 rows.
SELECT *
FROM employees
WHERE last_name like "%q%";

-- Update your query for 'Irena', 'Vidya', or 'Maya' to use OR instead of IN — 709 rows.
SELECT *
FROM employees
WHERE first_name = "Irena"
OR first_name = "Vidya"
OR first_name = "Maya";

-- Add a condition to the previous query to find everybody with those names who is also male — 441 rows.
SELECT *
FROM employees
WHERE gender = "M" 
and (first_name IN ("Irena", "Vidya", "Maya"));

-- Find all employees whose last name starts or ends with 'E' — 30,723 rows.
SELECT *
FROM employees
WHERE last_name LIKE "e%"
OR last_name like "%e";

-- Duplicate the previous query and update it to find all employees whose last name starts and ends with 'E' — 899 rows.
SELECT *
FROM employees
WHERE last_name LIKE "e%e";

-- Find all employees hired in the 90s and born on Christmas — 362 rows.
SELECT *
FROM employees
WHERE hire_date LIKE "199%"
and birth_date like "%12-25";

-- Find all employees with a 'q' in their last name but not 'qu' — 547 rows.
SELECT *
FROM employees
WHERE last_name LIKE "%q%"
AND last_name NOT LIKE "%qu%";


-- Create a new file named 3.5.2_order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.
-- Modify your first query to order by first name. The first result should be Irena Reutenauer and the last result should be Vidya Simmen.
SELECT *
FROM employees
WHERE first_name IN ("Irena", "Vidya", "Maya")
ORDER BY first_name;

-- Update the query to order by first name and then last name. The first result should now be Irena Acton and the last should be Vidya Zweizig.
SELECT *
FROM employees
WHERE first_name IN ("Irena", "Vidya", "Maya")
ORDER BY first_name, last_name;

-- Change the order by clause so that you order by last name before first name. Your first result should still be Irena Acton but now the last result should be Maya Zyda.
SELECT *
FROM employees
WHERE first_name IN ("Irena", "Vidya", "Maya")
ORDER BY last_name, first_name;

-- Update your queries for employees with 'E' in their last name to sort the results by their employee number. Your results should not change!
SELECT * 
FROM employees
WHERE last_name LIKE "%e%"
ORDER BY emp_no;

-- Now reverse the sort order for both queries.
SELECt * 
FROM employees
WHERE first_name IN ("Irena", "Vidya", "Maya")
ORDER BY last_name DESC, first_name DESC

SELECT * 
FROM employees
WHERE last_name LIKE "%e%"
ORDER BY emp_no DESC;

-- Change the query for employees hired in the 90s and born on Christmas such that the first result is the oldest employee who was hired last. 
--It should be Khun Bernini.
SELECT *
FROM employees
WHERE hire_date LIKE "199%"
AND birth_date LIKE "%12-25"
ORDER BY birth_date, hire_date DESC;

-- Create a new SQL script named 3.5.3_limit_exercises.sql.
-- Find your query for employees born on Christmas and hired in the 90s from order_by_exercises.sql. 
-- Update it to find just the first 5 employees. Their names should be:
-- Khun Bernini
-- Pohua Sudkamp
-- Xiaopeng Uehara
-- Irene Isaak
-- Dulce Wrigley
SELECT *
FROM employees
WHERE hire_date LIKE "199%"
AND birth_date LIKE "%12-25"
ORDER BY birth_date, hire_date DESC
LIMIT 5;

-- Try to think of your results as batches, sets, or pages. The first five results are your first page. 
-- The five after that would be your second page, etc. 
-- Update the query to find the tenth page of results. The employee names should be:
-- Piyawadee Bultermann
-- Heng Luft
-- Yuqun Kandlur
-- Basil Senzako
-- Mabo Zobel

SELECT *
FROM employees
WHERE hire_date LIKE "199%"
AND birth_date LIKE "%12-25"
ORDER BY birth_date, hire_date DESC
LIMIT 5 OFFSET 45;

-- Copy the order by exercise and save it as 3.6_functions_exercises.sql.
-- Update your queries for employees whose names start and end with 'E'
-- Use concat() to combine their first and last name together as a single column named full_name.
SELECT 
CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
WHERE last_name LIKE "e%e";

-- Convert the names produced in your last query to all uppercase.

SELECT 
UPPER(CONCAT(first_name, ' ', last_name)) AS full_name
FROM employees
WHERE last_name LIKE "e%e";


-- For your query of employees born on Christmas and hired in the 90s, 
--use datediff() to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE())

SELECT emp_no,
datediff(CURDATE(), hire_date)
FROM employees
WHERE hire_date LIKE "199%"
AND birth_date LIKE "%12-25"
ORDER BY birth_date, hire_date DESC

-- Find the smallest and largest salary from the salaries table.
USE employees;

SELECT MAX(salary),
MIN(salary)
FROM salaries;

-- Use your knowledge of built in SQL functions to generate a username for all of the employees. 
-- A username should be all lowercase, and consist of the first character of the employees first name, 
--the first 4 characters of the employees last name, an underscore, the month the employee was born, 
--and the last two digits of the year that they were born. 

SELECT 
LOWER(CONCAT(LEFT(first_name,1), LEFT(last_name,4), "_", MID(birth_date,6,2), SUBSTR(birth_date,3,2))) AS username,
first_name,
last_name,
birth_date
FROM employees;

-- Create a new file named 3.7_group_by_exercises.sql
-- In your script, use DISTINCT to find the unique titles in the titles table. Your results should look like:

SELECT DISTINCT title
FROM titles;

-- Find your query for employees whose last names start and end with 'E'. 
--Update the query find just the unique last names that start and end with 'E' using GROUP BY. The results should be:

SELECT last_name
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY last_name;


-- Update your previous query to now find unique combinations of first and last name where the last name starts and ends with 'E'. You should get 846 rows.

SELECT first_name,
last_name
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY last_name, first_name;


-- Find the unique last names with a 'q' but not 'qu'. Your results should be:

SELECT last_name
FROM employees
WHERE last_name LIKE '%q%'
AND last_name NOT LIKE '%qu%'
GROUP BY last_name;


-- Add a COUNT() to your results and use ORDER BY to make it easier to find employees whose unusual name is shared with others.

SELECT last_name,
COUNT(*)
FROM employees
WHERE last_name LIKE '%q%'
AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

-- Update your query for 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names. 

SELECt gender,
COUNT(*)
FROM employees
WHERE first_name IN ("Irena", "Vidya", "Maya")
GROUP BY gender;

-- Recall the query the generated usernames for the employees from the last lesson. Are there any duplicate usernames?

SELECT 
LOWER(CONCAT(LEFT(first_name,1), LEFT(last_name,4), "_", MID(birth_date,6,2), SUBSTR(birth_date,3,2))) AS username,
COUNT(*) AS num_users
FROM employees
WHERE num_users > 1
GROUP BY username;

-- Bonus: how many duplicate usernames are there?
SELECT 
COUNT(LOWER(CONCAT(LEFT(first_name,1), LEFT(last_name,4), "_", MID(birth_date,6,2), SUBSTR(birth_date,3,2)))) - 
COUNT(DISTINCT(LOWER(CONCAT(LEFT(first_name,1), LEFT(last_name,4), "_", MID(birth_date,6,2), SUBSTR(birth_date,3,2))))) AS duplicate_usernames
FROM employees;


-- write a query that shows each department along with the name of the current manager for that department.
SELECT dept_name AS "Department Name",
CONCAT(first_name, " ", last_name) AS "Department Manager"
FROM departments
JOIN dept_manager dm USING (dept_no)
JOIN employees em USING (emp_no)
WHERE dm.to_date > NOW()
ORDER BY dept_name;

-- Find the name of all departments currently managed by women.

SELECT dept_name AS "Department Name",
CONCAT(first_name, " ", last_name) AS "Manager Name"
FROM departments
JOIN dept_manager dm USING (dept_no)
JOIN employees USING (emp_no)
WHERE gender = "F"
AND dm.to_date > NOW()
ORDER BY dept_name;

-- Find the current titles of employees currently working in the Customer Service department.

SELECT title AS Title,
COUNT(*)
FROM dept_emp dem
JOIN departments dep USING (dept_no)
JOIN titles t USING (emp_no)
WHERE dept_name = "Customer Service"
AND t.to_date > NOW()
GROUP BY title
ORDER BY title;

-- Find the current salary of all current managers.
SELECT dept_name AS "Department Name",
CONCAT (first_name, " ", last_name) as "Name",
salary
FROM employees emp
JOIN dept_manager dm USING (emp_no)
JOIN salaries sal USING (emp_no)
JOIN departments dep USING (dept_no)
WHERE sal.to_date > NOW()
AND dm.to_date > NOW()
ORDER BY dept_name;

-- Find the number of employees in each department.
SELECT dept_no,
dept_name,
COUNT(*)
FROM departments
JOIN dept_emp USING (dept_no)
WHERE to_date > NOW()
GROUP BY dept_no, dept_name;


-- Which department has the highest average salary?

SELECT dept_name,
AVG(salary) AS average_salary
FROM departments
JOIN dept_emp USING (dept_no)
JOIN salaries USING (emp_no)
GROUP BY dept_name
ORDER BY average_salary DESC
LIMIT 1;

-- Who is the highest paid employee in the Marketing department?
SELECT first_name,
last_name,
MAX(salary) AS salary
FROM employees emp
JOIN salaries sal USING (emp_no)
JOIN dept_emp dem USING (emp_no)
JOIN departments USING (dept_no)
WHERE dept_name = "Marketing"
GROUP BY first_name, last_name
ORDER BY salary DESC
LIMIT 1;

-- Which current department manager has the highest salary?

SELECT first_name,
last_name,
MAX(salary) AS salary,
dept_name
FROM employees
JOIN salaries sal USING (emp_no)
JOIN dept_manager dm USING (emp_no)
JOIN departments USING (dept_no)
WHERE dm.to_date > NOW()
GROUP BY first_name, last_name, dept_name
ORDER BY salary DESC
LIMIT 1;


-- Bonus Find the names of all current employees, their department name, and their current manager's name.


-- 240,124 Rows

-- Employee Name | Department Name  |  Manager Name
-- --------------|------------------|-----------------
--  Huan Lortz   | Customer Service | Yuchang Weedman

--  .....
-- Bonus Find the highest paid employee in each department.
