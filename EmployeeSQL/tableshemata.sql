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