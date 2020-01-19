---create the tables then import the data
create table departments (
dept_no varchar (10) not null PRIMARY KEY,
dept_name varchar(30));

--Employees
create table employees ( 
emp_no INTEGER not null PRIMARY KEY,
birth_date DATE,
first_name VARCHAR (30),
last_name VARCHAR (30),
gender VARCHAR (10),
hire_date DATE);

create table titles (
ID SERIAL primary Key,
emp_no INTEGER,
	foreign key (emp_no) references employees(emp_no),
title VARCHAR (30),
from_date date,
to_date date);

create table dept_emp (
ID serial primary key,
emp_no INTEGER,
	foreign key (emp_no) references employees(emp_no),
dept_no VARCHAR (10),
	foreign key (dept_no) references departments(dept_no), 
from_date date,
to_date date);

create table salaries (
ID serial primary key,
emp_no INTEGER,
	foreign key (emp_no) references employees(emp_no),
salary INTEGER,
from_date date,
to_date date);

create table dept_manager(
ID serial primary key,
dept_no VARCHAR,
	foreign key (dept_no) references departments(dept_no),
emp_no INTEGER,
	foreign key (emp_no) references employees(emp_no),
from_date date,
to_date date);

--check to see if import worked
select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;

--1. List the following details of each employee: 
--employee number, last name, first name, gender, and salary.
select 
e.emp_no,
e.last_name,
e.first_name,
e.gender,
s.salary
from employees as e
left join salaries as s
on e.emp_no=s.emp_no;

--
--2. List employees who were hired in 1986.
select * from employees
where hire_date > '1985-12-31' order by hire_date
--used order by to ensure the where was accurate

--3. List the manager of each department with the following information: 
--department number, department name, the manager's employee number,
--last name, first name, and start and end employment dates.
select 
dm.dept_no,
d.dept_name,
dm.emp_no,
e.last_name,
e.first_name,
dm.from_date,
dm.to_date
from dept_manager as dm
left join departments as d
on dm.dept_no= d.dept_no
left join employees as e
on dm.emp_no=e.emp_no

--4. List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
select 
e.emp_no,
e.last_name,
e.first_name,
d.dept_name
from employees as e
left join dept_emp as de
on e.emp_no=de.emp_no
left join departments as d
on de.dept_no=d.dept_no;

--5. List all employees whose first name is "Hercules" and last names begin with "B."
select * from employees
where first_name = 'Hercules' and last_name like 'B%'

--6. List all employees in the Sales department,
--including their employee number, last name, first name, and department name.
select 
e.emp_no,
e.last_name,
e.first_name,
d.dept_name
from employees as e
left join dept_emp as de
on e.emp_no=de.emp_no
left join departments as d
on de.dept_no=d.dept_no
where d.dept_name = 'Sales';

--7. List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
select 
e.emp_no,
e.last_name,
e.first_name,
d.dept_name
from employees as e
left join dept_emp as de
on e.emp_no=de.emp_no
left join departments as d
on de.dept_no=d.dept_no
where d.dept_name in('Sales','Development')

--8. In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.
select 
last_name,
count(last_name) AS name_count
from employees
group by last_name
order by name_count desc
